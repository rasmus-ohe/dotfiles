#!/bin/bash

systemctl --user enable --now hyprshade.timer

sudo systemctl enable cups.socket
sudo systemctl enable docker.socket
sudo systemctl enable ufw.service

sudo ufw enable
