#!/bin/bash

packages=(
  btop  # System monitor
  fastfetch  # System info
  corectrl  # CPU/GPU overclocking
  mission-center  # GUI btop
  systemd-ui  # GUI for systemd units
  lm_sensors  # Hardware monitoring
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"