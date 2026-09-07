#!/bin/bash

packages=(
  scrcpy  # Mirror Android device to desktop
  android-tools  # ADB and Fastboot
  waydroid  # Android in a container
  better-adb-sync-git # Sync files between Android and Linux
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# UFW for Waydroid
sudo ufw allow 67
sudo ufw allow 53
sudo ufw default allow FORWARD