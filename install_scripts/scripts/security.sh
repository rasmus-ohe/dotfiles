#!/bin/bash

packages=(
  keepassxc  # Offline password manager
  bitwarden  # Password manager
  pass  # CLI password store

  gnome-keyring ## Required by ente-auth-bin
  libsecret ## Required by ente-auth-bin
  ente-auth-bin  # 2FA manager
  seahorse # Keyring GUI
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"
