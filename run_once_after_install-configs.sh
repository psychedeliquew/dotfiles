#!/bin/bash
set -e

# greetd config
if [ -d "$HOME/.config/greetd" ]; then
    sudo cp -r "$HOME/.config/greetd" /etc/
    sudo systemctl enable greetd
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

# changing shell to zsh
chsh -s /bin/zsh

# reboot
reboot
