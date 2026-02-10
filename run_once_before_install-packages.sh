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
  zsh-syntax-highlighting
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

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# install oh my posh
if ! command -v oh-my-posh &>/dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi
