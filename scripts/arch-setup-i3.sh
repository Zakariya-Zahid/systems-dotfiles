#!/bin/bash

# Exit on error
set -e

# Detect script directory for relative referencing
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT=$(dirname "$SCRIPT_DIR")
PKGLIST_DIR="$REPO_ROOT/pkglist"
ARCH_DIR="$REPO_ROOT/arch"

echo "--- Arch Linux Setup Script ---"

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "Error: This script is intended for Arch Linux only."
    exit 1
fi

# Dependency check
for cmd in git base-devel; do
    if ! pacman -Qi $cmd &> /dev/null; then
        echo "Installing missing dependency: $cmd"
        sudo pacman -S --needed --noconfirm $cmd
    fi
done

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install official packages
echo "Installing official packages..."
if [ -f "$PKGLIST_DIR/pacman.txt" ]; then
    sudo pacman -S --needed --noconfirm - < "$PKGLIST_DIR/pacman.txt"
else
    echo "Warning: pacman.txt not found."
fi

# Install AUR helper (yay) if missing
if ! command -v yay &> /dev/null; then
    echo "Installing yay (AUR helper)..."
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"
    pushd "$TEMP_DIR/yay" > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf "$TEMP_DIR"
fi

# Install AUR packages
echo "Installing AUR packages..."
if [ -f "$PKGLIST_DIR/aur.txt" ]; then
    yay -S --needed --noconfirm - < "$PKGLIST_DIR/aur.txt"
else
    echo "Warning: aur.txt not found."
fi

# Copy config files
echo "Syncing configuration files..."
# Folders to sync (added check for directory existence)
CONFIG_FOLDERS=("i3" "hypr" "neovim" "kitty" "picom" "polybar" "rofi" "dunst" "spicetify")

for folder in "${CONFIG_FOLDERS[@]}"; do
    if [ -d "$ARCH_DIR/$folder" ]; then
        echo "  -> Syncing $folder..."
        mkdir -p "$HOME/.config/$folder"
        # Use rsync if available for cleaner syncing, otherwise cp
        if command -v rsync &> /dev/null; then
            rsync -av --delete "$ARCH_DIR/$folder/" "$HOME/.config/$folder/"
        else
            cp -rf "$ARCH_DIR/$folder/"* "$HOME/.config/$folder/"
        fi
    else
        echo "  -> Skipping $folder (source directory missing)."
    fi
done

echo "Setup complete! Please restart your session or source your shell config."
