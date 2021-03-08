export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/kotfind/.oh-my-zsh"

ZSH_THEME="robbyrussell" #"agnoster"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
setopt rmstarsilent
setopt HIST_IGNORE_DUPS

# Plugins
plugins=(git sudo web-search zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# set global variables
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='vim'
export ARCHFLAGS="-arch x86_64"

# aliases
alias god="sudo su"
alias gimme="sudo pacman -S "
alias ls="ls --group-directories-first --color=auto"
alias p3="python3"
alias nt="sakura . &> /dev/null &!"

# keyboard layout
xkbcomp ~/.config/xkb/my $DISPLAY > /dev/null 2>&1
