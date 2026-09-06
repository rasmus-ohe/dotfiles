#!/bin/bash

packages=(
  gtk3-demos
  gtk4-demos
  gnome-themes-extra
  qt5-wayland
  qt6-wayland
  nwg-look  # GTK settings manager
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"