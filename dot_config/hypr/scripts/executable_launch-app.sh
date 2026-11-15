#!/bin/bash

notify() {
  BODY=$1
  ICON_PATH=$2
  TITLE="Launching..."

  notify-send -h string:synchronous:launch-app -t 4000 "${TITLE}" "${BODY}" -i "${ICON_PATH}"
}

while getopts "l:p:i:h:" opt; do
   case "$opt" in
      l ) LAUNCH_CMD="$OPTARG" ;;
      p ) NAME_PRINT="$OPTARG" ;;
      i ) ICON_PATH="$OPTARG" ;;
      h ) printhelp ;;
      * ) printhelp ;;
   esac
done

notify "${NAME_PRINT}" "${ICON_PATH}"
setsid -f sh -c "${LAUNCH_CMD}" >/dev/null 2>&1
