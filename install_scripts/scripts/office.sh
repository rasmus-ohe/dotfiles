#!/bin/bash

packages=(
  libreoffice-fresh  # Office suite (fresh = latest version)
  libreoffice-extension-texmaths  # LaTeX equations in LibreOffice
  libreoffice-extension-writer2latex  # Export to LaTeX
  nuspell  # Used by libreoffice

  hunspell  # Spell checking
  hunspell-en_US  # American spell checking
  hunspell-en_GB  # British spell checking
  voikko-libreoffice # Finnish spell checking for libreoffice

  hyphen-en  # English hyphenation

  mythes-en  # English thesaurus

#   languagetool # Already included in libreoffice-fresh (since version 7.4)
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"