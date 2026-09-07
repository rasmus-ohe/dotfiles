#!/bin/bash

packages=(
  zathura   # PDF/image viewer
  zathura-cb  # Comic books support
  zathura-pdf-mupdf # EPUB, PDF and XPS support based on MuPDF
  gwenview  # Image viewer
  glow  # Markdown viewer in terminal
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Make zathura the default PDF viewer
xdg-mime default org.pwmt.zathura.desktop application/pdf