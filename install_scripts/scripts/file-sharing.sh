#!/bin/bash

packages=(
  syncthing  # File sharing
  syncthing-gtk  # GUI for Syncthing
  localsend-bin  # Open-source AirDrop alternative
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
systemctl --user enable --now syncthing.service