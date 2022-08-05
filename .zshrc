# Prompt
autoload -Uz vcs_info # for git
precmd () { vcs_info } # for git
zstyle ':vcs_info:git*' formats '%F{blue}(%s)%f ' # git format
PROMPT='%B%F{green}%2~%f%b ${vcs_info_msg_0_}'
RPROMPT='%(?.%F{green}OK%f.%F{red}%?%f) %F{yellow}%n@%m%f'

# Zsh options
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(git pass doas zsh-autosuggestions zsh-syntax-highlighting)

# Global variables
export PATH=$HOME/.cabal/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"
export MANPAGER="vim -c MANPAGER -"

source $ZSH/oh-my-zsh.sh

# Aliases
unalias -m '*'
alias ls="ls --group-directories-first --color=auto"
alias l="ls -hl"
alias L="l -a"
alias p3="python3"
alias e="exec"
alias tmx="exec sh -c \"tmux attach -t 0 || tmux\""
