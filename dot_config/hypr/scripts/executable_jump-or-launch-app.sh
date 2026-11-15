#!/bin/bash

printhelp() {
   echo "Usage: $0 -c <class> -l <application>"
   echo
   echo "This script will jump to the application with the given class name or launch it if it is not running."
   echo "If only one of the parameters is given, the script will use the same value for both parameters."
   echo
   echo "Parameters:"
   echo "  -h           Print this help message"
   echo "  -c <class>   The Hyprland (hyprctl) class name of the application"
   echo "  -l <launch>  The command to launch the application"
   echo "  -p <print>   The name to print in the notification (optional, defaults to the class name; first letter capitalized)"
   echo "  -i <icon>    An icon to showcase in the notification"
   exit 1
}

while getopts "c:l:p:i:h:" opt; do
   case "$opt" in
      c ) HYPR_CLASS="$OPTARG" ;;
      l ) LAUNCH_CMD="$OPTARG" ;;
      p ) NAME_PRINT="$OPTARG" ;;
      i ) ICON="$OPTARG" ;;
      h ) printhelp ;;
      * ) printhelp ;;
   esac
done

# Print the help message if all parameters are missing
if [ -z "$HYPR_CLASS" ] && [ -z "$LAUNCH_CMD" ]; then
   printhelp
fi

# If one of the parameters is missing, set it to the value of the other parameter
if [ -z "$HYPR_CLASS" ]; then
   HYPR_CLASS=$LAUNCH_CMD
elif [ -z "$LAUNCH_CMD" ]; then
   LAUNCH_CMD=$HYPR_CLASS
fi

# If no print name is given, use the class name as the print name, with the first letter capitalized
[[ -z $NAME_PRINT ]] && NAME_PRINT="${HYPR_CLASS}"
# if [ -z "$NAME_PRINT" ]; then
#    NAME_PRINT=${HYPR_CLASS^}
# fi

# TITLE="${NAME_PRINT}"
# [[ -n $ICON ]] && TITLE="${ICON} ${TITLE}"
# if [ -n "$ICON" ]; then
#   ICON="${ICON} "
# fi

# Get the workspace ID of the application with the given class name
WS_ID="$(hyprctl clients -j \
  | jq -r --arg cls "$HYPR_CLASS" \
    '.[] | select(.class == $cls) | .workspace.id' \
  | head -n1)"

notify(){
  TITLE=$1
  BODY=$2

  notify-send -h string:synchronous:launch-or-jump "${TITLE}" "${BODY}"
}

# If the workspace ID is not empty, jump to the workspace and focus the windo
if [ -n "$WS_ID" ]; then
  notify "${TITLE}" ""
  # notify-send -h string:synchronous:hyprctl-jump "${ICON}Jumping to $NAME_PRINT" "Workspace $WS_ID"
  hyprctl dispatch "hl.dsp.focus({ workspace=$WS_ID })"
  hyprctl dispatch "hl.dsp.focus({ window=\"class:$HYPR_CLASS\" })"
else # If the workspace ID is empty, launch the application
  # notify-send -h string:synchronous:hyprctl-jump "${ICON}Launching $NAME_PRINT"
  sh -c "$LAUNCH_CMD" &
fi
