HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt inc_append_history hist_ignore_all_dups hist_ignore_space interactive_comments

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

bindkey -e
bindkey '^[[3~' delete-char
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

PROMPT='%F{cyan}%1~%f %# '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
