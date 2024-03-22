#!/bin/sh

# Check if packages installed

NEEDED_PACKAGES="fish \
xorg-server xorg-xinit \
dmenu exa scrot xclip light pamixer \
ttf-fira-code \
xss-lock batsignal notification-daemon \
mold"

pacman -Q $NEEDED_PACKAGES &> /dev/null
if ! [ $? -eq 0 ]; then
    echo -e "Error: All these packages should be installed:\n$NEEDED_PACKAGES"
    exit 1
fi

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

# Clone suckless config repos
mkdir -p ~/suckless
cd ~/suckless
for tool in dwm slock slstatus st; do
    git clone git@github.com:kotfind/${tool}-config.git $tool
    cd $tool
    make && sudo make install
    cd ..
done
