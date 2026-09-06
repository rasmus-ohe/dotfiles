#!/bin/bash

packages=(
  texlive-basic
  texlive-latexrecommended
  texlive-latexextra
  texlive-fontsextra
  texlive-xetex
  texlive-bibtexextra
  texlive-binextra
  tex-fmt-bin
  biber
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"