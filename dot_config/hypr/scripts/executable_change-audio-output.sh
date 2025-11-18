#!/bin/sh

list=$(pactl list sinks | awk '
  /^Sink #/ {
    if (id) printf "[%s] %s\n", id, desc;
    id = substr($2, 2);
    desc = "";
    next
  }
  /^[[:space:]]*Description:/ {
    desc = $0;
    sub(/^[[:space:]]*Description:[[:space:]]*/, "", desc);
    next
  }
  END {
    if (id) printf "[%s] %s\n", id, desc
  }
')

[ -z "$list" ] && exit 0

choice=$(printf "%s\n" "$list" | fuzzel --dmenu)
[ -z "$choice" ] && exit 0

sid=$(printf "%s" "$choice" | cut -d']' -f1 | tr -d '[' | tr -d ' ')
pactl set-default-sink "$sid"
