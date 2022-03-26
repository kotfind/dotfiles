# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Zsh options
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(git pass sudo web-search zsh-autosuggestions zsh-syntax-highlighting)

# Global variables
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"
export MANPAGER="vim -c MANPAGER -"

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls="ls --group-directories-first --color=auto"
alias p3="python3"
alias e="exec"
alias lock="i3lock-fancy-multimonitor -b=0x8"
alias far="wineconsole ~/.wine/drive_c/Program\ Files/Far/Far.exe"
alias tmx="exec sh -c \"tmux attach -t 0 || tmux\""
