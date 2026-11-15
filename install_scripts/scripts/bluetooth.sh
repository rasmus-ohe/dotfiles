#!/bin/bash

packages = (
  blueman
  bluez
  bluez-utils
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
sudo systemctl enable --now bluetooth
