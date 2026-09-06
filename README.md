# Minimalistic dotfiles

A very minimalistic dotfile design.

## Installation

### Install chezmoi

```bash
sudo pacman -Syu chezmoi
```

### Initialize chezmoi

```bash
chezmoi init
```

This should create a `.local/share/chezmoi` directory.

### Git clone dotfiles

```bash
git clone git@github.com:rasmus-ohe/minimialist-dotfiles.git ~/.local/share/chezmoi
```

### Install dotfiles

```bash
chezmoi apply
```

## Install scripts (directory)

For ease of installation, just run the `master-install.sh` script. \
This will run all the scripts in the `scripts` directory.

Optionally, you can individually run the `.sh` files in the `scripts` directory.

## Install guides (directory)

These markdown files are just guides on how to install the the programs.\
You don't have to follow them, but it is highly recommended.

## Other directories

The `etc` and `bin` are not part of the chezmoi, therefore they have to be installed manually. \
Just copy the files into the corresponding directories.

```bash
sudo cp etc/* /etc/
sudo cp bin/* /usr/local/bin/
```

## Making changes

When changes are made on the original files, DO NOT run `chezmoi apply`! \
This will overwrite the file changes with the chezmoi files. \
Instead, you need to `add` the file/directory to chezmoi again.

```bash
chezmoi add <file/directory path>
```

But when the changes are made on the chezmoi files, you can run `chezmoi apply` to apply the changes to the original files on the system.
