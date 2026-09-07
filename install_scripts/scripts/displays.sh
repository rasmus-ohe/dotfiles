#!/bin/bash

packages=(
  hyprmoncfg-bin  # Monitor configuration
  brightnessctl  # Brightness control
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
systemctl --user enable --now hyprmoncfg.service