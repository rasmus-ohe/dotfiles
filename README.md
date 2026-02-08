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

These scripts are used to install the programs. \
Opening the files will give you a better understanding of what packages will be installed.

**PLEASE** run the `install.sh` script first to minimize the risk of errors.

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
