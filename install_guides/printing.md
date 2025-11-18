# Printing

## Installation

`yay -Syu --noconfirm cups cups-filters system-config-printer`

## Service

`sudo systemctl enable --now cups.service`

## Add printer

### Option 1 (recommended)

Launch the `Print settings` software (system-config-printer), and add from there.

### Option 2

Visit `http://localhost:631/` and do some dark magic

## Print

Open the PDF (or some other printable file) in a browser (like Firefox) and press the pring button and choose the printer previously added.
