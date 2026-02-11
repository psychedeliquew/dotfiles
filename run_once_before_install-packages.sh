#!/bin/bash
set -e

# pacman
PACKAGES=(
  sway waybar fuzzel mako kitty nwg-look qt5ct qt6ct btop steam
  discord base-devel git zsh nvim autotiling grim slurp
  wl-clipboard zsh-syntax-highlighting winetricks protontricks
  wine wine-mono greetd-tuigreet
)

sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"

# paru install
if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
fi

# paru packages
paru -S --noconfirm zen-browser-bin ttf-jetbrains-mono-nerd

# greetd config
CONFIG_SRC="$CHEZMOI_SOURCE_DIR/home/.config/greetd/config.toml"
CONFIG_DEST="/etc/greetd/config.toml"

if [ -f "$CONFIG_SRC" ]; then
    sudo mkdir -p /etc/greetd
    sudo cp "$CONFIG_SRC" "$CONFIG_DEST"
    sudo systemctl daemon-reload
    sudo systemctl enable --now greetd
fi

# oh-my-zsh install
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# oh-my-posh install
if ! command -v oh-my-posh &>/dev/null; then
  mkdir -p ~/.local/bin
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi
