#!/bin/bash

packages=(
  keepassxc  # Offline password manager
  bitwarden  # Password manager

  gnome-keyring ## Required by ente-auth-bin
  libsecret ## Required by ente-auth-bin
  seahorse # Keyring GUI
  ente-auth-bin  # 2FA manager
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"
