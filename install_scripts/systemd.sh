#!/bin/bash

sudo systemctl enable cups.socket
sudo systemctl enable ufw.service

sudo ufw enable
