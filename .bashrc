# --- 1. BASH DEFAULTS & OPTIONS ---
[[ $- != *i* ]] && return # Stop if not interactive

shopt -s autocd globstar histappend checkwinsize
set -o emacs

# --- 2. HISTORY ---
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=50000
export HISTFILESIZE=50000
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# # Bind Ctrl+x End to edit-and-execute (opens Emacs)
# bind '"\C-x\e[4~": edit-and-execute-command'


# Basic Navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[H": beginning-of-line'
bind '"\e[F": end-of-line'

# --- 4. PROMPT (Matches your Zsh style) ---
parse_git() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ git:(\1)/'
}
export PS1="\[\e[32m\]→ \[\e[36m\]\W\[\e[33m\]\$(parse_git)\[\e[37m\] × \[\e[0m\]"

# --- 5. ALIASES ---
alias ll='ls -alhF --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias py='python'
alias c='clear'
alias ..='cd ..'
alias ]]r='source ~/.bashrc'

# --- 6. EXTERNAL TOOLS (Standard Init) ---

# Zoxide (Better cd)
if command -v zoxide >/dev/null; then
    eval "$(zoxide init bash)"
fi

# FZF (Search)
if [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
elif command -v fzf >/dev/null; then
    eval "$(fzf --bash)"
fi

# --- 7. AUTO-TMUX (Optional - uncomment if desired) ---
# if [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
#     exec tmux new-session
# fi
