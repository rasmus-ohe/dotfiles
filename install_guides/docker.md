# Docker

## Installation

`yay -Syu --noconfirm docker docker-compose`

It is recommended to restart the machine for all installations to take effect

## Start docker daemon (recommended)

`sudo systemctl start docker.service`

### Start on boot

`sudo systemctl enable docker.service`

## Add user to docker group

`sudo usermod -aG docker $USER`

## Verify docker installation

`docker run hello-world`
