#!/bin/bash
set -e
# installing dependencies
PACKAGES=(
  sway
  waybar
  fuzzel
  mako
  kitty
  nwg-look
  qt5ct
  qt6ct
  btop
  steam
  discord
  base-devel
  git
  zsh
  nvim
  autotiling
  grim
  slurp
  wl-clipboard
)
sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"

# installing paru
if ! command -v paru &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
fi

# installing paru packages
paru -S zen-browser ttf-jetbrains-mono-nerd

# greetd config
if [ -f "/etc/greetd/config.toml" ]; then
  sudo cp {{ .chezmoi.sourceDir }}/path/to/your/config.toml /etc/greetd/config.toml
  sudo systemctl restart greetd
fi
