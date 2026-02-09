#!/bin/bash

# installing core packages
sudo pacman -Syu
sudo pacman -S --needed --noconfigm sway waybar fuzzel mako kitty nwg-look qt5ct qt6ct btop steam discord base-devel git

# installing paru
TEMP_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/paru.git "$TEMP_DIR"
cd "$TEMP_DIR"
makepkg -si --noconfirm
rm -rf "$TEMP_DIR"

# installing paru packages
paru -S zen-browser
