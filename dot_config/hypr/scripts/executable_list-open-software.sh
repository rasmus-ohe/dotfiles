#!/bin/sh

# Get list of open windows with workspace numbers
clients=$(hyprctl clients -j | jq -r '
  sort_by(.workspace.id)
  | .[]
  | "\(.workspace.id) [\(.class)] \(.title) \t\(.workspace.id)\t\(.address)"
')

# Stop if no windows are active
if [ -z "$clients" ]; then
  notify-send -t 2000 -h string:synchronous:list-open-software "No open applications"
  exit 0
fi


# Pass to fuzzel, showing workspace number and app class
selected=$(echo "$clients" | fuzzel --dmenu --with-nth=1)

[ -z "$selected"] && exit 0

# Parse tab separated fields
rest=${selected#*$'\t'}
workspace_id=${rest%%$'\t'*}
address=${selected##*$'\t'}

# Jump + focus
hyprctl dispatch workspace "$workspace_id" > /dev/null
hyprctl dispatch focuswindow "address:$address" > /dev/null
