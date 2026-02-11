#!/bin/bash
set -e

# pacman
PACKAGES=(
  sway waybar fuzzel mako kitty nwg-look qt5ct qt6ct btop steam
  base-devel git zsh nvim autotiling grim slurp
  wl-clipboard winetricks protontricks
  wine wine-mono greetd-tuigreet fastfetch
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

# greetd config
CONFIG_SRC="{{ .chezmoi.sourceDir }}/home/.config/greetd/config.toml"
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

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# oh-my-posh install
if ! command -v oh-my-posh &>/dev/null; then
  mkdir -p ~/.local/bin
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi

# changeing shell to zsh
chsh -s /bin/zsh
