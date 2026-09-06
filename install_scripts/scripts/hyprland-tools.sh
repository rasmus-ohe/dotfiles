#!/bin/bash

packages=(
  hyprshot  # Hyprland screenshot tool
  hyprshade  # Hyprland night light daemon
  hyprlock  # Session lock
  hyprpicker  # Color picker
  hypr-zoom  # Zoom-tool
  hyprpolkitagent  # Popup for root password
)

# Install packages
yay -S --noconfirm "${packages[@]}"

# Enable services
systemctl --user enable --now hyprshade.timer