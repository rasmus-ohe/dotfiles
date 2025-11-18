#!/usr/bin/env sh

if rfkill list all | grep -q "Soft blocked: no"; then
  status="🚫 Off"
else
  status="✔️ On"
fi

notify-send -t 2000 -h string:synchronous:airplane-mode "Airplane mode" "${status}"