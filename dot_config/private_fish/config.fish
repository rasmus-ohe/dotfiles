if status is-interactive
  # Commands to run in interactive sessions can go here
  set -g fish_greeting ""    
end

## Abbreviations
# Neovim
alias vi='nvim'
abbr nv 'nvim'
abbr nh 'nvim ~/.config/hypr/'
abbr nc 'nvim ~/.local/share/chezmoi/'
abbr ns 'nvim ~/.config/spicetify/'
abbr nf 'nvim ~/.config/fish/config.fish'
abbr nn 'nvim ~/.config/nvim/'

# VSCode
abbr ch 'code ~/.config/hypr/'
abbr cc 'code ~/.local/share/chezmoi/'
abbr cs 'code ~/.config/spicetify/'
abbr cf 'code ~/.config/fish/config.fish'
abbr cn 'code ~/.config/nvim/'

# cd (move to directory)
abbr cdh 'cd ~/.config/hypr/'
abbr cdhs 'cd ~/.config/hypr/scripts/'
abbr cdc 'cd ~/.local/share/chezmoi/'
abbr cds 'cd ~/.config/spicetify/'
abbr cdf 'cd ~/.config/fish/config.fish'
abbr cdn 'cd ~/.config/nvim/'
abbr cdb 'cd ~/Documents/Blender/'
abbr cdbp 'cd ~/Documents/Blender/Projects/'

# Package managers
## Pacman
abbr pi 'sudo pacman -Syu --noconfirm'
abbr pr 'sudo pacman -Rcns'
abbr pc 'sudo pacman -Rcns $(pacman -Qdtq)'
## yay
abbr yi 'yay -Syu --noconfirm'
abbr yin 'yay -Syu --noconfirm --needed'
abbr yr 'yay -Rns'
abbr yq 'yay -Qu'

# Git
abbr gp 'git push'
abbr gf 'git fetch'
## checkout
abbr gcm 'git checkout master'
abbr gcc 'git checkout combined'
abbr gcl 'git checkout laptop'
abbr gcd 'git checkout desktop'
## merge
abbr gmm 'git merge master'
abbr gmc 'git merge combined'
abbr gml 'git merge laptop'
abbr gmd 'git merge desktop'
## Lazygit
abbr lz 'lazygit'

# Hyprland
abbr rh 'hyprctl reload'  # Reload hyprland

# Hyprshade
abbr hsn 'hyprshade on warm-blue-light-filter'
abbr hsf 'hyprshade off'

# Systemctl
abbr sys 'systemctl'
abbr syse 'systemctl enable'
abbr syss 'systemctl status'
abbr sysr 'systemctl restart'
abbr sysd 'systemctl disable'
abbr sysu 'systemctl --user'
abbr sysue 'systemctl --user enable'
abbr sysus 'systemctl --user status'
abbr sysur 'systemctl --user restart'
abbr sysud 'systemctl --user disable'
abbr sysudr 'systemctl --user daemon-reexec && systemctl --user daemon-reload'

# FastFetch
abbr ff 'fastfetch'

# Color picker
abbr picker 'hyprpicker'

# Trash
alias rm='trashy'
abbr tr 'trashy'
abbr rmc 'trashy ~/.cache/yay/'  # Remove yay cache

# Ping test
abbr pa 'ping -c 3 aur.archlinux.org'
abbr pi 'ping -c 3 aur.archlinux.org'

# `ls` command
alias ls='lsd'
abbr lsa 'ls -a'
abbr lg 'ls -a | grep'

# man/tldr
abbr man 'tldr'
alias mann='man'

# Rust (cargo)
abbr cb 'cargo build'
abbr cr 'cargo run'
abbr cbr 'cargo build --release'
abbr crr 'cargo run --release'
abbr cw 'cargo watch -x run'
abbr ca 'cargo add'

# Wireguard
abbr wu 'sudo wg-quick up'
abbr wd 'sudo wg-quick down'

# Transtale
abbr tef 'trans en:fi'
abbr tes 'trans en:swe'
abbr tsf 'trans swe:fi'
abbr tfs 'trans fi:swe'

# Chezmoi
abbr chs 'chezmoi status'
abbr cha 'chezmoi add'
abbr chf 'chezmoi forget'
abbr chap 'chezmoi apply'
abbr chapd 'chezmoi apply --dry-run'

# Other
abbr cl 'clear'
abbr yz 'yazi'

fish_add_path /home/rasmus/.spicetify
fish_add_path /home/rasmus/.local/bin/
fish_add_path /home/rasmus/.cargo/bin/
