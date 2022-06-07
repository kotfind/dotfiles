#!/bin/bash

# Check if packages installed

NEEDED_PACKAGES="zsh \
    xorg-server xorg-xinit \
    xmonad xmonad-contrib rofi stalonetray xscreensaver scrot feh\
    alacritty xorg-xkbutils \
    python3 cmake \
    zsh-theme-powerlevel10k ttf-meslo-nerd-font-powerlevel10k"

pacman -Q $NEEDED_PACKAGES &> /dev/null
if ! [ $? -eq 0 ]; then
    echo -e "Error: All these packages should be installed:\n$NEEDED_PACKAGES"
    exit 1
fi

# Install zsh, oh-my-zsh and powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

find . \
    -not -path "./.git*" \
    -not -path "." \
    -type d \
    -exec echo Creating directory  ~/\{\} \;\
    -exec mkdir ~/\{\} \;

find . \
    -not -path "./.git*" \
    -not -path "./install.sh" \
    -type f \
    -exec echo Linking \{\} \; \
    -exec ln -sf $(readlink -f \{\}) ~/\{\} \;

# Oh-My-Zsh Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p ~/.vim/undodir
vim -c ":PluginInstall" -c ":qa"
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
