# ~/.bashrc

# Stop if not interactive
[[ $- != *i* ]] && return

# Options
shopt -s histappend checkwinsize
set -o emacs

# History
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=50000
PROMPT_COMMAND='history -a'

# Prompt
PS1='\[\e[36m\]\W\[\e[0m\] \$ '

# Color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
