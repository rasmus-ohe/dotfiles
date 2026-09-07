#!/bin/bash

yay -S --noconfirm --needed hyprpm

hyprpm update

# Add `hypr-dynamic-cursors`, and enable it
hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable dynamic-cursors
