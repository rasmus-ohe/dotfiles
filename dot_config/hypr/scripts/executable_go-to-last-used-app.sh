#!/bin/sh

read address workspace_id prev_app <<EOF
$(hyprctl clients -j | jq -r '
(map(select(.focusHistoryID == 1)) | .[0]) 
// (sort_by(.focusHistoryID) | .[0])
  | "\(.address) \(.workspace.id) \(.class)"
')
EOF

[ -z "$address" ] && exit 0

hyprctl dispatch workspace "$workspace_id" > /dev/null
hyprctl dispatch focuswindow "address:$address" > /dev/null

notify-send -h string:synchronous:go-to-last-app \
  "Jumping back to ${prev_app^}" \
  "Workspace: $workspace_id"
