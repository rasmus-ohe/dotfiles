#!/bin/sh

notify () {
    notify-send -t 3000 -h string:synchronous:easyeffects "EasyEffects" "$1"
}

# Get output presets
output_presests="$(easyeffects -p | awk '/^Output presets:/{f=1;next} f{if (NF==0) exit; print}' | cut -f2-)"

# Exit if no presets
if [ -z "$output_presests" ]; then
    notify "No output presets"
    exit 0
fi

# Current preset
current_preset="$(easyeffects -s | sed -n 's/^output: //p')"

# Build list with state indicator
menu=$(printf '%s\n'  "$output_presests" | while read -r p; do
    if [ "$p" = "$current_preset" ]; then
        state="●"
    else
        state="○"
    fi

    printf "%s\t%s\n" "$state $p" "$p"
done)

# Choose preset
chosen_preset=$(printf '%s\n' "$menu" | \
  fuzzel --dmenu --placeholder="Output preset" \
  --with-nth=1 --accept-nth=2 --minimal-lines -R)

# Exit if none chosen
[ -z "$chosen_preset" ] && exit 0

# Exit if current preset
if [ "$chosen_preset" = "$current_preset" ]; then
    notify "Already active: $chosen_preset"
    exit 0
fi

# Set preset
if ! easyeffects -l "$chosen_preset"; then
    notify "Could not set preset"
    exit 1
fi

notify "Activated: $chosen_preset"