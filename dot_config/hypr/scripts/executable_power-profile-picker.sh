#!/usr/bin/env sh

# Profile list
profiles="balanced
power-saver
performance"

# Current profile
current=$(powerprofilesctl get)

# Build list with markers
menu=$(printf '%s\n' "$profiles" | while read -r p; do
  if [ "$p" = "$current" ]; then
    state="●"
  else
    state="○"
  fi

  printf "%s\t%s\n" "$state $p" "$p"
done)

# Choose profile
chosen=$(printf '%s\n' "$menu" | \
  fuzzel --dmenu --placeholder="Power profile" \
  --with-nth=1 --accept-nth=2 --minimal-lines -R)

# Exit if none chosen
[ -z "$chosen" ] && exit 0

# Set profile
powerprofilesctl set "$chosen"

notify-send -t 2000 -h string:synchronous:power-profile-picker "Power profile" "Selected: $chosen"
