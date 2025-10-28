# SDDM theme (login screen)

Easy to follow guide on how to install a custom theme for SDDM.

## Installation

Install the theme

```bash
git clone https://github.com/stepanzubkov/where-is-my-sddm-theme.git
cd where-is-my-sddm-theme
sudo ./install.sh
```

Create a config file for sddm

```bash
sudo sddm --example-config | sudo tee /etc/sddm.conf
```

Change the default theme

```bash
sudoedit /etc/sddm.conf
```

```ini
[Theme]
Current=where_is_my_sddm_theme
```

Restart the sddm service

```bash
sudo systemctl restart sddm
```

## Additional tips

To change the theme config, the `.conf` file is located at `/usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf`. \
My recommendations:

```conf
passwordFontSize=48
passwordCursorColor=white
```

## Remove git dir

If the sddm theme is fully working, you can remove the installed git directory (during ##Installation)

## More information

- [https://github.com/sddm/sddm](https://github.com/sddm/sddm)
- [https://github.com/stepanzubkov/where-is-my-sddm-theme](https://github.com/stepanzubkov/where-is-my-sddm-theme)
