#!/bin/sh

# Get list of open windows with workspace numbers
windows=$(hyprctl clients -j | jq -r '.[] | "\(.workspace.id) [\(.class)] \(.title)"')

if [ -z "$windows" ]; then
  notify-send -t 2000 -h string:synchronous:list-open-software "No open applications"
  exit 0
fi

# Sort by workspace number (numeric sort on first field)
sorted=$(echo "$windows" | sort -n -k1,1)

# Pass to fuzzel, showing workspace number and app class
selected=$(echo "$sorted" | fuzzel --dmenu | awk '{print $1}')

# If a selection was made, switch to that workspace
if [ -n "$selected" ]; then
  hyprctl dispatch workspace "$selected"  >/dev/null 2>&1
fi
