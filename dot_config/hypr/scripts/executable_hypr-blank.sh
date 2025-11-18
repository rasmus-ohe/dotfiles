#!/usr/bin/env bash
set -euo pipefail

# Move each active monitor to its own high-numbered empty workspace
hyprctl -j monitors | jq -c '.[] | select(.disabled==false)' | \
while IFS= read -r mon; do
  id=$(jq -r '.id' <<<"$mon")
  name=$(jq -r '.name' <<<"$mon")
  idx=$((id + 100))
  hyprctl dispatch focusmonitor "$name" -q
  hyprctl dispatch workspace "$idx" -q
done
