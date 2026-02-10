#!/bin/bash
set -e

PACKAGES=(
  sway waybar fuzzel mako kitty nwg-look qt5ct qt6ct btop steam
  discord base-devel git zsh nvim autotiling grim slurp
  wl-clipboard zsh-syntax-highlighting winetricks protontricks
  wine wine-mono
)

sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"

if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
fi

paru -S --noconfirm zen-browser-bin ttf-jetbrains-mono-nerd

if [ -f "/etc/greetd/config.toml" ]; then
  sudo cp ~/.config/greetd/config.toml /etc/greetd/config.toml
  sudo systemctl enable --now greetd
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

if ! command -v oh-my-posh &>/dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi
