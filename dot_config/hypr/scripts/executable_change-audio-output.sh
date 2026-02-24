#!/bin/sh

# Get current default source name
current=$(pactl info | awk -F': ' '/Default Sink:/ {print $2}')

# Build list with state indicator
list=$(pactl -f json list sinks | jq -r --arg current "$current" '
  .[] |
  (if .name == $current then "● " else "○ " end)
  + .description
')

[ -z "$list" ] && exit 0

choice=$(printf "%s\n" "$list" | fuzzel --dmenu --placeholder 'Output device')
[ -z "$choice" ] && exit 0

# Extract numeric source index
sid=$(printf "%s" "$choice" | sed -E 's/^[●○] \[([0-9]+)\].*/\1/')

pactl set-default-source "$sid"


