#!/bin/bash

export PS1="\[$(tput bold)\]\[$(tput setaf 4)\]\W\[$(tput sgr0)\] \\$ \[$(tput sgr0)\]"

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)

alias p3=python3
