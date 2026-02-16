#!/bin/sh

# Columns:
# 1 → Display string
# 2 → Workspace ID
# 3 → Window address
clients=$(hyprctl clients -j | jq -r '
  sort_by(.focusHistoryID)
  | .[]
  | "\(.workspace.id) [\(.class)] \(.title)\t\(.workspace.id)\t\(.address)"
')

if [ -z "$clients" ]; then
  notify-send -t 2000 -h string:synchronous:list-last-used-apps "No open applications"
  exit 0
fi

selected=$(printf "%s\n" "$clients" | \
           fuzzel --dmenu --with-nth=1 --prompt="Recent windows")

[ -z "$selected" ] && exit 0

# Extract tab-separated fields
rest=${selected#*$'\t'}
workspace_id=${rest%%$'\t'*}
address=${selected##*$'\t'}

# Jump + focus
hyprctl dispatch workspace "$workspace_id" > /dev/null
hyprctl dispatch focuswindow "address:$address" > /dev/null

