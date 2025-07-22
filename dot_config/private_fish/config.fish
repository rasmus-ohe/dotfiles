if status is-interactive
  # Commands to run in interactive sessions can go here
  set -g fish_greeting ""    
end

## Abbreviations
# Neovim
abbr vi 'nvim'
abbr nv 'nvim'
abbr nh 'nvim ~/.config/hypr/'
abbr nc 'nvim ~/.local/share/chezmoi/'
abbr ns 'nvim ~/.config/spicetify/'
abbr nf 'nvim ~/.config/fish/config.fish'

# Package managers
abbr pi 'sudo pacman -Syu --noconfirm'
abbr pr 'sudo pacman -Rcns'
abbr pc 'sudo pacman -Rcns $(pacman -Qdtq)'
abbr yi 'yay -Syu --noconfirm'
abbr yr 'yay -Rns'

# Hyprland
abbr rh 'hyprctl reload'  # Reload hyprland

# FastFetch
abbr ff 'fastfetch'

# Color picker
abbr picker 'hyprpicker'

# Other
abbr lsa 'ls -a'
abbr lg 'ls -a | grep'

fish_add_path /home/rasmus/.spicetify
fish_add_path /home/rasmus/.local/bin/
