# Prompt
autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
add-zsh-hook precmd vcs_info
precmd () {
    vcs_info
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}u%f'
zstyle ':vcs_info:*' stagedstr ' %F{green}s%f'
zstyle ':vcs_info:git:*' formats '%F{blue}(%b%f%u%c%F{blue})%f'

PROMPT='%B%F{green}%2~%f%b ${vcs_info_msg_0_} %F{blue}%#%f '
RPROMPT='%(?.%F{green}OK%f.%F{red}%?%f) %F{yellow}%n@%m%f'

# Zsh options
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(git pass doas zsh-autosuggestions zsh-syntax-highlighting zsh-kitty)

# Global variables
export PATH="/usr/lib/qt6/:/usr/lib/qt6/bin/:$HOME/.cabal/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR="nvim"
export ARCHFLAGS="-arch x86_64"
export MANPAGER="less"

source $ZSH/oh-my-zsh.sh

# Aliases
unalias -m '*'
alias ls="ls --group-directories-first --color=auto"
alias l="ls -hl"
alias L="l -a"
alias p3="python3"
alias e="exec"
alias tmx="exec sh -c \"tmux attach -t 0 || tmux\""
alias vim="nvim"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git push"
alias gd="git diff --word-diff=color"
alias gdc="git diff --cached --word-diff=color"
alias gr="git restore"
alias gl="git log"
alias gt="git log --graph --all --oneline --decorate" # git tree
