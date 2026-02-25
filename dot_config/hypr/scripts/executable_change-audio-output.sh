#!/bin/sh

notify() {
  notify-send -t 5000 "Audio device" "$1"
}

# Get current default source name
current=$(pactl info | awk -F': ' '/Default Sink:/ {print $2}')

# Build list with state indicator
list=$(pactl -f json list sinks | jq -r --arg current "$current" '
  .[] |
  (if .name == $current then "● " else "○ " end)
  + .description + "\t" + .name
')

echo "$list"

# Exit if no devices in list
if [ -z "$list" ]; then
  notify "No output devies!"
  exit 0
fi

# Choose new audio output; or exit if no selection (-R)
choice=$(
  echo "$list" \
  | fuzzel --dmenu --placeholder 'Output device' \
  --with-nth=1 --accept-nth={2} -R --minimal-lines
)

# Set chosen device as new input
if pactl set-default-sink "$choice" > /dev/null 2>&1; then
  notify "Could not set output device"
fi
