#!/bin/sh

notify() {
  notify-send -t 5000 -h string:synchronous:workspace_switcher "Workspace switcher" "$1"
}


DST_WORKSPACE_ID="$1"

if [ -z "$DST_WORKSPACE_ID" ]; then
  notify "Not a destination ID given!"
  exit 1
fi

src_workspace_id=$(hyprctl activewindow -j | jq .workspace.id)

# Exit if destination is same as source
if [ "$DST_WORKSPACE_ID" == "$src_workspace_id" ]; then
  notify "Destination same as source!"
  exit 0
fi

for addr in $(hyprctl clients -j | \
  jq -r ".[] | select(.workspace.id == $src_workspace_id) | .address"); do
  hyprctl dispatch movetoworkspace $DST_WORKSPACE_ID,address:$addr
done

notify "Moved to: $DST_WORKSPACE_ID"
