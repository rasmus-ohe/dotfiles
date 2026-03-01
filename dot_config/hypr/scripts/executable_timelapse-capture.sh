#!/usr/bin/env sh

#!/usr/bin/env sh
set -eu

usage() {
    echo "Usage: $0 -p <project_name> -i <interval_seconds> -c <window_class>"
    exit 1
}

PROJECT_NAME=""
INTERVAL=""
WINDOW_CLASS=""

while getopts "p:i:c:" opt; do
    case "$opt" in
        p) PROJECT_NAME="$OPTARG" ;;
        i) INTERVAL="$OPTARG" ;;
        c) WINDOW_CLASS="$OPTARG" ;;
        *) usage ;;
    esac
done

[ -z "$PROJECT_NAME" ] && usage
[ -z "$INTERVAL" ] && usage
[ -z "$WINDOW_CLASS" ] && usage

OUTDIR="$HOME/Pictures/Timelapse/$PROJECT_NAME"
mkdir -p "$OUTDIR"

MONITOR=$(hyprctl -j monitors | jq -r '.[0].name')

echo "Project      : $PROJECT_NAME"
echo "Interval     : ${INTERVAL}s"
echo "Window class : $WINDOW_CLASS"
echo "Output dir   : $OUTDIR"
echo "Monitor      : $MONITOR"
echo "------------------------------------"

while true; do
    ACTIVE_CLASS=$(hyprctl -j activewindow 2>/dev/null | jq -r '.class // empty')

    if [ "$ACTIVE_CLASS" = "$WINDOW_CLASS" ]; then
        TS=$(date '+%Y_%m_%d_%H%M%S')
        grim -t jpg -q 95 -o "$MONITOR" \
            "$OUTDIR/capture_${TS}.jpeg"
        echo "Captured: capture_${TS}.jpg"
    else
        echo "Skipped (active window: ${ACTIVE_CLASS:-none})"
    fi

    sleep "$INTERVAL"
done
