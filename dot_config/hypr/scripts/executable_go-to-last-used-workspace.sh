#!/bin/sh


notify() {
  notify-send -h string:synchronous:go-to-last-app "󰑎 $1" "$2"
}

current_workspace_id=$(hyprctl activeworkspace -j | jq -r '.id')

read -r addr wsid class <<EOF
$(hyprctl clients -j | jq -r \
  --arg cur "$current_workspace_id" '
    sort_by(.focusHistoryID)
    | map(select(.workspace.id != ($cur|tonumber)))
    | first
    | [.address, .workspace.id, .class]
    | @tsv
  ')
EOF

if [ -n "$addr" ]; then
  hyprctl dispatch "hl.dsp.focus({ workspace = $wsid })" > /dev/null
  hyprctl dispatch "hl.dsp.focus({ window = \"address:$addr\" })" > /dev/null


  notify "Jumping back to $class" "Workspace: $wsid"
else
  notify "Jumping back" "No workspace to jump to"
fi
