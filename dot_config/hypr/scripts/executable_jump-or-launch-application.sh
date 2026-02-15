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
   exit 1
}

while getopts "c:l:p:h:" opt; do
   case "$opt" in
      c ) HYPR_CLASS="$OPTARG" ;;
      l ) LAUNCH_CMD="$OPTARG" ;;
      p ) NAME_PRINT="$OPTARG" ;;
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
if [ -z "$NAME_PRINT" ]; then
   NAME_PRINT=${HYPR_CLASS^}
fi

# Get the workspace ID of the application with the given class name
WS_ID="$(hyprctl clients -j \
  | jq -r --arg cls "$HYPR_CLASS" \
    '.[] | select(.class == $cls) | .workspace.id' \
  | head -n1)"


# If the workspace ID is not empty, jump to the workspace and focus the windo
if [ -n "$WS_ID" ]; then
  notify-send -h string:synchronous:hyprctl-jump "Jumping to $NAME_PRINT" "Workspace $WS_ID"
  hyprctl dispatch workspace "$WS_ID"
  hyprctl dispatch focuswindow "class:$HYPR_CLASS"
else # If the workspace ID is empty, launch the application
  notify-send -h string:synchronous:hyprctl-jump "Launching $NAME_PRINT"
  sh -c "$LAUNCH_CMD" &
fi
