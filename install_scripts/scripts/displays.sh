#!/bin/bash

packages=(
  nwg-displays  # Display manager
  brightnessctl  # Brightness control
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"