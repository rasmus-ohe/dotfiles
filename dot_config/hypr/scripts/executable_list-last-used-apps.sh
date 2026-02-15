#!/bin/sh

# Get windows ordered by focus history (0 = current, 1 = previous, ...)
clients=$(hyprctl clients -j | jq -r '
  sort_by(.focusHistoryID)
  | .[]
  | "[\(.workspace.id)] [\(.class)] \(.title) ::: \(.address)"
')

# Stop if no windows
if [ -z "$clients" ]; then
  notify-send -t 2000 -h string:synchronous:list-last-used-apps "No open applications"
  exit 0
fi

selected=$(echo "$clients" | fuzzel --dmenu)

[ -z "$selected" ] && exit 0

# Extract workspace + address
workspace_id=$(echo "$selected" | sed -n 's/^[0-9]\+ \[\([0-9]\+\)\].*/\1/p')
address=${selected##* ::: }

# Jump + focus
hyprctl dispatch workspace "$workspace_id" > /dev/null
hyprctl dispatch focuswindow "address:$address" > /dev/null