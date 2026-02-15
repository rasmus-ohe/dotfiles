#!/bin/sh

# Get list of open windows with workspace numbers
clients=$(hyprctl clients -j | jq -r 'sort_by(.workspace.id) | .[] | "\(.workspace.id) [\(.class)] \(.title) ::: \(.address)"')

# Stop if no windows are active
if [ -z "$clients" ]; then
  notify-send -t 2000 -h string:synchronous:list-open-software "No open applications"
  exit 0
fi

# Sort by workspace number (numeric sort on first field)
sorted_clients=$(echo "$clients" | sort -n -k1,1)

# Pass to fuzzel, showing workspace number and app class
selected_client=$(echo "$sorted_clients" | fuzzel --dmenu)

# Parse the selected line to extract workspace number and window address
selected_client_id=${selected_client%% *}
selected_client_address=${selected_client##* ::: }

# Exit if no selection was made
[ -z "$selected_client_id" ] && exit 0

# Focus the selected workspace and window
hyprctl dispatch workspace "$selected_client_id" > /dev/null
hyprctl dispatch focuswindow "address:$selected_client_address" > /dev/null
