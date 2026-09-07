#!/bin/bash

packages=(
  cups  # Pringing system
  cups-pdf  # "pring" into PDF
  simple-scanner  # Gnome GUI for scanning
  system-config-printer  # Printer setup GUI
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
sudo systemctl enable --now cups.service