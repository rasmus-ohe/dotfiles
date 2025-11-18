# Docker

## Installation

`yay -Syu --noconfirm docker docker-compoes`

It is recommended to restart the machine for all installations to take effect

## Start docker daemon

`sudo systemctl start docker.service`

### Start on boot

`sudo systemctl enable docker.service`

## Add user to docker group

`sudo usermod -aG docker $USER`

## Verifry docker installation

`docker run hello-world`
