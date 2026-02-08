#!/bin/sh

# Usage:
# ./blender-parallel-render.sh <blend_file> <start_frame> <end_frame> <instances>

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <blend_file> <start_frame> <end_frame> <instances>"
    exit 1
fi

BLEND_FILE="$1"
START_FRAME="$2"
END_FRAME="$3"
INSTANCES="$4"

# Basic validation
if [ ! -f "$BLEND_FILE" ]; then
    echo "Error: Blender file does not exist: $BLEND_FILE"
    exit 1
fi

if [ "$START_FRAME" -gt "$END_FRAME" ]; then
    echo "Error: start_frame must be <= end_frame"
    exit 1
fi

TOTAL_FRAMES=$((END_FRAME - START_FRAME + 1))
FRAMES_PER_INSTANCE=$((TOTAL_FRAMES / INSTANCES))
REMAINDER=$((TOTAL_FRAMES % INSTANCES))

CURRENT_START="$START_FRAME"

i=1
while [ "$i" -le "$INSTANCES" ]; do
    EXTRA=0
    if [ "$i" -le "$REMAINDER" ]; then
        EXTRA=1
    fi

    RANGE_SIZE=$((FRAMES_PER_INSTANCE + EXTRA))
    CURRENT_END=$((CURRENT_START + RANGE_SIZE - 1))

    if [ "$CURRENT_START" -le "$END_FRAME" ]; then
        foot -e sh -c "
            echo 'Rendering frames $CURRENT_START to $CURRENT_END';
            blender -b \"$BLEND_FILE\" \
                --offline-mode \
                -s $CURRENT_START \
                -e $CURRENT_END \
                -a;
            echo 'Done: $CURRENT_START to $CURRENT_END';
            read -r _
        " &
    fi

    CURRENT_START=$((CURRENT_END + 1))
    i=$((i + 1))
done

wait
