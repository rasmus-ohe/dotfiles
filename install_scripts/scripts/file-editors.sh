#!/bin/bash

packages=(
  gvim  # vim + plugins
  neovim  # vim on steroids
  tree-sitter-cli ## Required for nvim
  visual-studio-code-bin  # VSCode
  obsidian-bin  # Note-taking
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"