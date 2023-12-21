if not status is-interactive
    exit 0
end

# Variables
set -gx EDITOR nvim

# Path
fish_add_path /usr/lib/qt6/
fish_add_path /usr/lib/qt6/bin
fish_add_path /opt

# Reset abbreviations
set -g fish_user_abbreviations

# Abbreviations
alias l 'exa --group-directories-first --color=always -hl'
alias L 'exa --group-directories-first --color=always -ahl'
alias p3 'python3'
alias e 'exec'
alias vim 'nvim'

# Git Abbreviations
alias gs 'git status'
alias ga 'git add'
alias gc 'git commit'
alias gca 'git commit --amend'
alias gp 'git push'
alias gd 'git diff --word-diff=color'
alias gdc 'git diff --cached --word-diff=color'
alias gl 'git log'
alias gt 'git log --graph --all --oneline --decorate'
alias gch 'git checkout'
alias gb 'git branch'

# Functions
function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

function fish_greeting
end

function fish_prompt
    set -l last_status $status

    # PWD
    set -l pwd (string replace $HOME \~ $PWD)
    set -l prompt_pwd (string split -- / $pwd | tail -n 2 | string join /)

    set_color $fish_color_cwd
    echo -n $prompt_pwd

    # Git
    set -g __fish_git_prompt_show_informative_status true
    set_color normal
    echo -n (fish_git_prompt)

    # Status
    if [ $last_status -ne 0 ]
        set_color --bold $fish_color_error
        echo -n ' ['$last_status']'
    end

    # Suffix
    set -l suffix "\$"
    if fish_is_root_user
        set suffix "#"
    end

    set_color normal
    echo -n ' '$suffix' '
end

function fish_right_prompt
    set_color normal
    echo -n (prompt_login)
    set_color normal
end

function mkcd
    mkdir -p -- "$1" &&
       cd -P -- "$1"
end
