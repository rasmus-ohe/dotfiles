#!/bin/sh

# Directory containing your .sh scripts
SCRIPT_DIR="$HOME/.config/hypr/scripts"
# Destination directory for symlinks
BIN_DIR="$HOME/.local/bin"

# Ensure the destination directory exists
mkdir -p "$BIN_DIR"

# Loop through all .sh files in SCRIPT_DIR
for script in "$SCRIPT_DIR"/*.sh; do
  # Extract the base filename without extension
  script_name=$(basename "$script" .sh)

  # Create a symbolic link in BIN_DIR
  ln -sf "$script" "$BIN_DIR/$script_name"
  echo "Linked $script_name → $BIN_DIR/$script_name"
done

echo "All .sh scripts have been linked to $BIN_DIR."

