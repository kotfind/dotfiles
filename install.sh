#!/bin/bash

# Check if packages installed

NEEDED_PACKAGES="zsh \
    xorg-server xorg-xinit \
    xmonad xmonad-contrib rofi stalonetray xsecurelock xss-lock scrot feh\
    kitty\
    python3 cmake ctags\
    ttf-fira-code\
    nvim-packer-git"

pacman -Q $NEEDED_PACKAGES &> /dev/null
if ! [ $? -eq 0 ]; then
    echo -e "Error: All these packages should be installed:\n$NEEDED_PACKAGES"
    exit 1
fi

# Install zsh and oh-my-zsh
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
git clone https://github.com/redxtech/zsh-kitty ~/.oh-my-zsh/custom/plugins/zsh-kitty
git clone https://github.com/anatolykopyl/doas-zsh-plugin.git ~/.oh-my-zsh/custom/plugins/doas
