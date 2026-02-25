#!/bin/bash

# Get list of open windows with workspace numbers
clients=$(hyprctl clients -j | jq -r '
  sort_by(.workspace.id)
  | .[]
  | "\(.workspace.id) [\(.class)] \(.title)\t\(.workspace.id)\t\(.address)"
')

# Stop if no windows are active
if [ -z "$clients" ]; then
  notify-send -t 2000 -h string:synchronous:list-open-software "No open applications"
  exit 0
fi

# Pass to fuzzel, showing workspace number and app class
read workspace_id address < <(
  printf "$clients" | \
  fuzzel --dmenu --prompt="Open applications" \
  --with-nth=1 --accept-nth={2..} -R
)

# Jump + focus
hyprctl dispatch workspace "$workspace_id" > /dev/null
hyprctl dispatch focuswindow "address:$address" > /dev/null
