#!/bin/sh

# Fail check if media is playing
# playerctl status | grep "Playing" && exit 1

if [ "$(playerctl status)" == "Playing" ]; then
  echo "Media is playing"
  exit 1
fi

# Successfull check
exit 0
