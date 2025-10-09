#!/bin/sh

# Usage: ./clamshell-mode.sh [open|closed]
ACTION="$1"

# Step 1: Check connected monitors
CONNECTED=$(hyprctl monitors all | grep '^Monitor' | awk '{print $2}')
NUM_MONITORS=$(echo "$CONNECTED" | wc -l)

if [ "$NUM_MONITORS" -eq 1 ] && [ "$CONNECTED" = "eDP-1" ]; then
    # Only internal display is active, go to sleep
    playerctl pause 2> /dev/null
    systemctl suspend
    hyprlock --no-fade-in -q
    exit 0
fi

# Step 2: Act based on lid state
if [ "$ACTION" = "closed" ]; then
    hyprctl keyword monitor "eDP-1,disable"
elif [ "$ACTION" = "open" ]; then
    MONITOR_INFO=$(hyprctl monitors all | awk '/Monitor eDP-1/,/^$/')
    RESOLUTION=$(echo "$MONITOR_INFO" | grep '^[[:space:]]*[0-9]\+x[0-9]\+@' | awk -F'@' '{print $1}' | tr -d '[:space:]')
    POSITION=$(echo "$MONITOR_INFO" | grep ' at ' | awk -F'at' '{print $2}' | tr -d '[:space:]')

    if [ -n "$RESOLUTION" ] && [ -n "$POSITION" ]; then
        hyprctl keyword monitor "eDP-1,$RESOLUTION,$POSITION,1"
    else
        echo "Failed to parse resolution or position for eDP-1"
        exit 1
    fi
else
    echo "Usage: $0 [open|closed]"
    exit 1
fi
