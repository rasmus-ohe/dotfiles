#!/bin/bash

packages=(
  nemo  # File manager
  nemo-fileroller # Compression settings
  nemo-terminal   # Terminal within nemo
  nemo-preview    # Quick preview files with `space`
  nemo-image-converter  # Rotate and resize images
  bulky # Bulk renamer (for Nemo)
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk

  yazi  # Terminal file manager
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
systemctl --user enable --now xdg-desktop-portal-hyprland.service
systemctl --user enable --now xdg-desktop-portal-gtk.service

# Make Nemo the default file manager
xdg-mime default nemo.desktop inode/directory