#!/bin/bash

if command -v yay &>/dev/null; then
  echo "yay is already installed."
  exit 0
fi

echo "Installing yay..."

packages=(
  git
  base-devel
  reflector  # Arch mirrorlist updater
)

# Install dependencies for yay
sudo pacman -S --noconfirm --needed "${packages[@]}"

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -si
cd ..
rm -rf yay