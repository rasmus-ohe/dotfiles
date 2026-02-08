# Trelby

## Step 1: Packages

Install required packages

```sh
flatpak install org.trelby.Trelby

yay -Syu --noconfirm --needed flatseal zathura zathura-pdf-mupdf
```

## Step 2: Allow file acces

Open flatseal, and add access to the `/tmp` directory from: `Trelby -> Filesystem -> Other files -> Add`

## Step 3: Change PDF viewer

Launch `Trelby` and change the PDF viewer.

`Settings -> Misc -> Path` set it to `/usr/bin/xdg-open` and press `Apply`.

## Step 4: Try it out

Write something on the page, then press `CTRL + P` to preview the PDF.
