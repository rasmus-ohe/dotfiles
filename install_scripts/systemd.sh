#!/bin/bash

# Link service file(s)
sudo ln -s ~/.config/hypr/services/ydotoold.service /etc/systemd/system/ 

systemctl --user enable --now hyprshade.timer
systemctl --user enable --now playerctld.service

sudo systemctl enable cups.socket
sudo systemctl enable docker.socket
sudo systemctl enable ufw.service
sudo systemctl enable ydotoold.service

sudo ufw enable
