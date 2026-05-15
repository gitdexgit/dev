# --- ESSENTIALS ---
export EDITOR=nvim
export PAGER="bat"
export MANPAGER="nvim +Man!"
export VISUAL=nvim
export TERMINAL=alacritty
export ZK_NOTEBOOK_DIR="$HOME/work/"
export ZK_NOTE_LINK_FORMAT="wiki"
export XDG_CONFIG_HOME="$HOME/.config"
export DEV_ENV_HOME="$HOME/personal/dev"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PYENV_ROOT="$HOME/.pyenv"



# Just getting essential keys so that it just makes sense.
export FZF_DEFAULT_OPTS="--bind 'ctrl-left:backward-word,ctrl-right:forward-word,ctrl-delete:kill-word,ctrl-k:kill-line'"

# --- GLOBAL FZF CONFIG ---
# export FZF_DEFAULT_OPTS="
#   --layout=default
#   --preview-window='up:65%:wrap'
#   --preview 'bat --color=always --style=numbers --line-range=:500 {}'
#   --bind 'alt-w:toggle-wrap'
#   --bind 'alt-j:preview-page-down,alt-k:preview-page-up'
#   --bind 'alt-J:preview-down,alt-K:preview-up'
# "


# --- LUA PATHS (Static is fastest) ---
export LUA_PATH='/usr/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;/home/dex/.luarocks/share/lua/5.1/?.lua;/home/dex/.luarocks/share/lua/5.1/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/lib/lua/5.1/loadall.so;./?.so;/home/dex/.luarocks/lib/lua/5.1/?.so'

# --- THE "TSODING" PATH (Native Zsh Array) ---
# 'typeset -U' means "Unique": if a path is added twice, Zsh ignores the second one.
# This is 100x faster than calling addToPath functions with [ -d ] checks.
typeset -U path
path=(
    "$PYENV_ROOT/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/.cargo/bin"
    "$HOME/.luarocks/bin"
    "$HOME/.npm-global/bin"
    "$HOME/scripts/ddesk"
    "$HOME/scripts/ddesk/]]"
    "$HOME/scripts/ddesk/]"
    "$HOME/scripts/ddesk/["
    "$HOME/scripts/ddesk/nothing"
    "$HOME/scripts/ddesk/obsidian"
    "$HOME/git/goodnight-mouse/builddir"
    "$HOME/.local/scripts"
    $path # Keep existing system paths
)

# Only set TERM if not in tmux
[[ -z "$TMUX" ]] && export TERM=xterm-256color
. "$HOME/.cargo/env"
