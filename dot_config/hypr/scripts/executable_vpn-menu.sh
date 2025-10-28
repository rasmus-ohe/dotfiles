#!/usr/bin/env bash

WG_DIR="/etc/wireguard"
MENU_TOOL="fuzzel"       # invoking fuzzel (Wayland launcher)  
# (assuming it’s installed via yay/pacman)

# Build list of options
opts=()

# “Turn Off” option always
opts+=("Turn Off")

# scan for .conf files
for f in $(pkexec ls "${WG_DIR}"/); do
  # strip directory and suffix
  name=$(basename "$f" .conf)
  opts+=("$name")
done

choice=$(printf '%s\n' "${opts[@]}" | fuzzel --dmenu --prompt="VPN > " --minimal-lines) || exit 1

if [ "$choice" = "Turn Off" ]; then
  iface=$(pkexec wg show | awk '/^interface:/ { print $2; exit }')

  if [ -n "$iface" ]; then
    pkexec wg-quick down "${iface}"
    notify-send "VPN Menu" "${iface} turned off"
  else
    notify-send "VPN Menu" "No active WireGuard interface found."
    exit 1
  fi
else
  pkexec wg-quick up "${choice}"
  notify-send "VPN Menu" "${choice} enabled"
fi
