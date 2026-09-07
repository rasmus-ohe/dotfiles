#!/bin/bash

# Install packages
yay -S --noconfirm --needed blueman bluez bluez-utils

# Enable services
sudo systemctl enable --now bluetooth