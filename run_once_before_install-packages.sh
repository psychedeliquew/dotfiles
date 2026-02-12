#!/bin/bash
set -e

# pacman
PACKAGES=(
  sway waybar fuzzel mako kitty nwg-look qt5ct qt6ct btop steam \
  base-devel git zsh nvim autotiling grim slurp polkit-gnome \
  wl-clipboard winetricks protontricks xdg-desktop-portal-wlr \
  wine wine-mono greetd-tuigreet fastfetch pavucontrol ufw \
  pipewire pipewire-pulse pipewire-alsa wireplumber libnotify \
  bluez bluez-utils blueman nvidia-open-dkms nvidia-utils \
  lib32-nvidia-utils linux-headers swaybg
)

sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"

# paru install
if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/paru
fi

# paru packages
paru -S --noconfirm zen-browser-bin ttf-jetbrains-mono-nerd

# oh-my-zsh install
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# oh-my-posh install
if ! command -v oh-my-posh &>/dev/null; then
  mkdir -p ~/.local/bin
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi
