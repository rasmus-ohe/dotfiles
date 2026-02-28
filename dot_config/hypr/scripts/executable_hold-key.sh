#!/bin/sh

#printf "W\t17\nLeft mouse" | fuzzel -d --minimal-lines

# Clear key
ydotool key 17:0
sleep 0.5

# Hold key
ydotool key 17:1

notify-send "Holding" "Key: W"
