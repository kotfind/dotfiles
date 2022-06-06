# Install zsh, oh-my-zsh and powerlevel10k
pacman -S --needed zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo -u $USER yay -S --needed zsh-theme-powerlevel10k ttf-meslo-nerd-font-powerlevel10k

# Install graphics (with xmonad, alacrity and rofi)
pacman -S --needed xorg-server xorg-init xmonad xmonad-contrib rofi alacritty xorg-xkbutils

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
sudo pacman -S --needed python3 cmake
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
