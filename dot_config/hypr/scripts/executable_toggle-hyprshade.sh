#!/usr/bin/env bash

current="$(hyprshade current)"
filter="warm-blue-light-filter"

if [ -z "$current" ]; then
  args=(on "$filter")
else
  args=(off)
fi

hyprshade "${args[@]}"
notify-send -t 2000 -h string:synchronous:hyprshade-toggle "Hyprshade" "${args^^}"

