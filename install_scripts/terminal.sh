#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if a package is installed
is_installed() {
  pacman -Q "$1" &>/dev/null
}

# Install foot terminal if not already installed
if ! is_installed foot; then
  echo "Installing foot terminal..."
  sudo pacman -S --noconfirm foot foot-terminfo
else
  echo "Foot terminal is already installed."
fi


# Foot wrapper
echo "Copying foot wrapper..."
sudo cp ../bin/foot-wrapper.fish /usr/local/bin/


# Install fish shell
if ! is_installed fish; then
  echo "Installing fish shell..."
  sudo pacman -S --noconfirm fish
else
  echo "fish shell is installed."
fi

# Install Meslo Nerd font
if ! is_installed ttf_meslo_nerd; then
  echo "Installing Meslo Nerd font..."
  sudo pacman -S --noconfirm ttf-meslo-nerd
else
  echo "Meslo Nerd font already installed"
fi


# Set fish as default shell
chsh -s "$(which fish)"

# Install Fisher plugin-manager
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install Tide theme (similiar to p10k for zsh)
fisher install IlanCosman/tide@v6

# Restart shell
echo "Please restart shell to start configuring the Tide theme!"
