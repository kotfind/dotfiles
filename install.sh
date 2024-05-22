#!/bin/sh

# Install packages
NEEDED_PACKAGES="fish ripgrep fd git \
    xorg-server xorg-xinit \
    dmenu exa scrot xclip light pamixer \
    ttf-fira-code \
    xss-lock batsignal notification-daemon \
    mold \
    stow"

yay -S --needed $NEEDED_PACKAGES

# Symlink dotfiles
fd -t d -d 1 --strip-cwd-prefix=always -x stow

# Clone suckless config repos
mkdir -p ~/suckless
pushd ~/suckless > /dev/null
    for tool in dwm slock slstatus st; do
        if [ ! -d $tool ]; then
            git clone git@github.com:kotfind/${tool}-config.git $tool
        fi
        cd $tool
        make && sudo make install
        cd ..
    done
popd > /dev/null
