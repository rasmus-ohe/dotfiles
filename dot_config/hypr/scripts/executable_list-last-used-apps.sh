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
  notify-send -t 2000 -h string:synchronous:list-open-software "No open applications"
  exit 0
fi

read workspace_id address < <(
  printf "$clients" | \
  fuzzel --dmenu --placeholder="Recent applications" \
  --with-nth=1 --accept-nth={2..} -R --minimal-lines
)

# Jump + focus
hyprctl dispatch workspace "$workspace_id" > /dev/null
hyprctl dispatch focuswindow "address:$address" > /dev/null

