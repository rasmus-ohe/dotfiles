#!/bin/bash

packages=(
  flatpak  # Flatpak package manager
  flatseal  # Flatpak permissions manager
)

# Install AUR packages
yay -S --noconfirm --needed "${packages[@]}"

# Install Flatpaks
flatpak install flathub us.zoom.Zoom
flatpak install flathub org.trelby.Trelby
flatpak install flathub org.kde.kdenlive
flatpak install flathub com.discordapp.Discord
