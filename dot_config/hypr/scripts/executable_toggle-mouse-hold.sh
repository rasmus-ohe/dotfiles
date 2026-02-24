#!/bin/sh

STATE_FILE="/tmp/.mouse_left_hold"
BTN_DOWN=40
MOUSE_UP=80

if [ -f "$STATE_FILE" ]; then
  notify-send "Mouse toggle" "release"
  ydotool click 80
  rm -f "$STATE_FILE"
else
  notify-send "Mouse toggle" "hold"
  ydotool click 40
  touch "$STATE_FILE"
fi
