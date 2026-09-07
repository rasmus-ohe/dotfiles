#!/bin/bash

install() {
    source "$install_dir_path/$1.sh"
}

# Directory with the install scripts
install_dir_path="$HOME/.local/share/chezmoi/install_scripts/scripts"

# Update system, and update package cache
sudo pacman -Syu --noconfirm

# Remove unwanted packages
sudo pacman -Rns --noconfirm vim

# System
install "yay"
install "keyd"
install "network"
install "bluetooth"
install "hyprland-tools"
install "system-monitoring"
install "clipboard"
install "displays"
install "hyprpm"

# Look and feel
install "notifications"
install "fonts"
install "themes"

# Development
install "git"
install "docker"
install "python"

# Files
install "disks"
install "cups"
install "latex"
install "file-editors"
install "file-managers"
install "file-viewing"
install "file-sharing"
install "file-tools"
install "office"

# Other
install "security"
install "web-browsers"
install "mail-message"
install "keyboard"
install "logitech"
install "audio"
install "android"
install "awatcher"
install "miscellaneaous"

# Flatpaks
install "flatpaks"

# Terminal
install "terminal"
install "terminal-tools"