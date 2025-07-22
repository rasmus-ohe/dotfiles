# Low battery alert notification

## Software installation

Install `batsignal`

`yay -Syu --noconfirm batsignal`

## Enable and start the service

```
# Quick reload of daemon
systemctl --user daemon-reload

# Then activation
systemctl --user enable batsignal.service
systemctl --user start batsignal.service
```

## Check if service is running

`systemctl --user status batsignal.service`
