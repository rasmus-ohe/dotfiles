#!/bin/bash

# Keyd service
yay -S --noconfirm --needed keyd

echo "Copying keyd config file..."

sudo mkdir -p /etc/keyd
sudo cp $HOME/.local/share/chezmoi/etc/keyd/default.conf /etc/keyd/default.conf

sudo systemctl enable --now keyd