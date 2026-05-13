# --- [0] AUTO-TMUX STARTUP ---
if [[ -z "$TMUX" ]] && [[ $- == *i* ]] && command -v tmux >/dev/null 2>&1; then
    exec tmux new-session
fi

# 1. CORE BASH OPTIONS
shopt -s autocd          # Change directory by typing name
shopt -s globstar        # Support for ** recursive globbing
shopt -s histappend      # Append to history instead of overwriting
shopt -s checkwinsize    # Update lines/cols after each command
shopt -s interactive_comments

# 2. HISTORY CONFIG
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=50000
export HISTFILESIZE=50000
# Update history after every command
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# 3. KEYBINDINGS (Readline uses 'bind' instead of 'bindkey')
# Set editing mode to emacs (since you unsetopt vi in zsh)
set -o emacs
export KEYTIMEOUT=1

# Editing & Navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[H": beginning-of-line'
bind '"\e[F": end-of-line'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
bind '"\C-u": backward-kill-line'
bind '"\C-k": kill-line'
bind '"\C-h": backward-delete-char'

# Custom Widgets / Macros
# Alt+Z for fg
bind '"\ez": "fg\n"'
# Alt+E to edit command in Nvim
export EDITOR=nvim
bind -x '"\ee": edit-and-execute-command'
# Alt+T for tmux-sessionizer
bind '"\et": "tmux-sessionizer\n"'

# 4. CACHED BINARIES (Zoxide & Dircolors)
if [[ -f ~/.cache/zoxide.bash ]]; then
    source ~/.cache/zoxide.bash
else
    command -v zoxide > /dev/null && zoxide init bash > ~/.cache/zoxide.bash && source ~/.cache/zoxide.bash
fi

if [[ -f ~/.cache/dircolors ]]; then
    eval "$(cat ~/.cache/dircolors)"
else
    command -v dircolors > /dev/null && dircolors -b > ~/.cache/dircolors && eval "$(cat ~/.cache/dircolors)"
fi

# 5. ALIASES (Mostly identical)
alias mpvg='mpv --player-operation-mode=pseudo-gui'
alias mpvyt='mpv --ytdl-format='
alias ]]r='source ~/.bashrc'
alias md='mkdir -p'
alias ll='ls -alhF --color=auto'
alias la='ls -AlhF --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias nvrc='nvim ~/.bashrc'
alias c='clear'
alias f='cd ~/fleet'
alias s='cd ~/scripts'
alias v='cd ~/fleet/vaults'
alias q='qalc'

# 6. FUNCTIONS

# xo (Open default apps)
xo() { xdg-open "$@" ; }

# lsg (ls + grep)
lsg() {
  if [ -z "$1" ]; then
    ls -l --color=always
  else
    ls -la --color=always | grep "$1"
  fi
}

# xxc (Copy file content/images to clipboard)
xxc() {
  if [ ! -f "$1" ]; then echo "File not found" >&2; return 1; fi
  local mimetype=$(file -b --mime-type "$1")
  if [ -n "$WAYLAND_DISPLAY" ]; then
    wl-copy -t "$mimetype" < "$1"
  else
    xclip -selection clipboard -t "$mimetype" < "$1"
  fi
}

# Ecat (Copy all text files recursively)
Ecat() {
  shopt -s globstar
  for f in **/*; do
    if [ -f "$f" ] && [[ $(file -b --mime-type "$f") == text/* ]]; then
      cat "$f"
    fi
  done | xclip -selection clipboard
}

# Timer
]timer() {
  date "+%T %a, %d-%m"
  local start=$(date +%s)
  while true; do
    local elapsed=$(( $(date +%s) - start ))
    printf "\r%02d:%02d" $((elapsed / 3600)) $(( (elapsed / 60) % 60 ))
    sleep 1
  done
}

# 7. PROMPT (PS1)
# Bash doesn't have vcs_info, so we use a small git helper
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ git:(\1)/'
}
# Green arrow, Cyan Dir, Yellow Git
export PS1="\[\e[32m\]→ \[\e[36m\]\W\[\e[33m\]\$(parse_git_branch)\[\e[37m\] × \[\e[0m\]"

# 8. EXTERNAL TOOLS
# Load FZF bash integration
eval "$(fzf --bash)"

# Alacritty Title Logic
if [[ "$TERM" == "alacritty" ]]; then
    trap 'echo -ne "\e]0;$BASH_COMMAND\a"' DEBUG
    PROMPT_COMMAND='echo -ne "\e]0;${PWD/#$HOME/~}\a";'"$PROMPT_COMMAND"
fi

source /home/dex/.config/broot/launcher/bash/br
. "$HOME/.cargo/env"
