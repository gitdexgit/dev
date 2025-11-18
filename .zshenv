# ~/.zshenv

# ================= !!!!!!!!! =====================
# ================= !!!!!!!!! =====================

# [Manual] run `keychain --eval --agents ssh id_ed25519` or whatever on first terminal of the day


# Esentials
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

# Only set TERM if we are NOT running inside tmux
if [[ -z "$TMUX" ]]; then
  export TERM=xterm-256color
fi




export LS_COLORS="$LS_COLORS:ow=30;44:"

# if you need this 
# export QT_QPA_PLATFORMTHEME=qt6ct

# If you need to run KDE apps 
# get plasma-meta get systemsettings and get breeze dark or whatever and change them and add this and that's it dolphin is now dark theme
# export QT_QPA_PLATFORMTHEME=kde


# better support here for kali nethutner for nvim :checkhealth
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


# ---Discription:
# This makes fzf default scrolling alt-k and alt-j which will work for
# the default zi previewer ![](https://i.imgur.com/ps25IpG.png) move without 
# needing to use mouse. But you could also use mouse if you want.
#
# ---Attention: 
# keep in mind that you can't remove the
# `--bind 'alt-j:preview-down,alt-k...etc'` in the fzf_opts...etc
# becuase I tried that and it didn't work. so this only works in 
# the default fzf preview... this is also nice overall for other fzf
# previewers. I have it in the zshenv just in case I don't have zoxide on other
# systems. I originally made this inside this block in zshrc:
#
# ```
# if command -v zoxide > /dev/null; then
# eval "$(zoxide init zsh)"
#
# zi() {
#   local fzf_opts=""
#   case "$1" in
#   -l)
#       fzf_opts="--preview ls -l .......(rest of the code)"
#       .
#       .
#   .
#   .
#   ...(rest of the code)
# }
# ```
#
# but it was moved to here because it makes sense to the whole system and workflow
export FZF_DEFAULT_OPTS="--bind 'alt-j:preview-down,alt-k:preview-up'"

# --------------------------------------------------------------------
# ""exports""
# ---END--------------------------------------------------------------

# Define XDG directories early if you use them for other configs
export XDG_CONFIG_HOME=$HOME/.config
export DEV_ENV_HOME="$HOME/personal/dev" # if this is meant as an env var

# --- Helper functions to safely add to PATH ---
# Adds a directory to the end of the PATH if it's not already there.
addToPath() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

# Adds a directory to the beginning of the PATH if it's not already there.
addToPathFront() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# --- Pyenv Initialization ---
# The pyenv init command handles its own PATH logic, so we just run it.
export PYENV_ROOT="$HOME/.pyenv"
addToPathFront "$PYENV_ROOT/bin" # Prepend pyenv bin first



# _)
# W40 Tue, 30 at 05:20
# ---START------------------------------------------------------------
# ""termux config""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION:

# Why?:

# Solution?:

# --------------------------------------------------------------------


if [[ ! -v TERMUX_VERSION ]]; then
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
fi

# --------------------------------------------------------------------
# ""termux config""
# ---END--------------------------------------------------------------





# --- Add Other Custom Directories to PATH ---
# Order matters: frequently used binaries usually go first.

# Prepend frequently used user binaries
addToPathFront "$HOME/.local/bin"
addToPathFront "$HOME/.local/bin"
addToPathFront "$HOME/go/bin"
addToPathFront "$HOME/.cargo/bin" # Rust's cargo binaries
# addToPathFront "$HOME/.deno/bin"   # Deno binaries
# addToPathFront "$HOME/.local/go/bin" # User's Go binaries
# addToPathFront "$HOME/.local/apps"   # Generic local applications

# For NVM/N: if you use NVM/N, their initialization scripts will manage their PATH.
# If you manually install 'n', you might need this:
# addToPathFront "$HOME/.local/n/bin/"

# Specific script/project directories (often appended or placed where needed)
addToPath "$HOME/scripts/ddesk"
addToPath "$HOME/scripts/ddesk/]]"
addToPath "$HOME/scripts/ddesk/]"
addToPath "$HOME/scripts/ddesk/["
addToPath "$HOME/scripts/ddesk/nothing"
addToPath "$HOME/scripts/ddesk/obsidian"
addToPath "$HOME/git/goodnight-mouse/builddir/"
# addToPath "$HOME/personal/ghostty/zig-out/bin" # Example of project-specific bin
# addToPath "$HOME/.sst/bin" # Example of framework-specific bin

# Other common paths you might need to prepend or append depending on preference
# addToPathFront "$HOME/.zig" # Zig compiler
# addToPathFront "$HOME/.local/.npm-global/bin" # Global NPM packages
# addToPathFront "$HOME/.local/odin" # Odin compiler
addToPathFront "$HOME/.local/scripts" # Your general purpose scripts

# Example of a system-wide Go path (if you installed Go system-wide)
# addToPathFront "/usr/local/go/bin"

# Example of a language server path
# addToPathFront "$HOME/personal/sumneko/bin"

# [Run] pleaes run the [Manual]
# removed the key chain bs bellow I had
# [Optimization] This is slow and gives me a lot of performance loss
# --- Keychain SSH Agent Initialization ---
# if [ -z "$SSH_AUTH_SOCK" ]; then
#     eval $(keychain --eval --quiet id_ed25519)
#     eval $(keychain --eval --quiet ssh)
# fi

# [Optimization] This is slow and gives me a lot of performance loss
#
# if command -v keychain > /dev/null; then
#     eval $(keychain --eval --quiet id_ed25519)
#     eval $(keychain --eval --quiet ssh)
# fi



# Clean up the helper functions so they don't pollute the shell
unset -f addToPath
unset -f addToPathFront
export PATH="$HOME/.npm-global/bin:$PATH"

# --- PASTE THIS BLOCK IN ITS PLACE ---

# --------------------------------------------------------------------
# Luarocks - Path configuration for locally installed Lua packages
# --------------------------------------------------------------------
# Set the search paths for Lua modules
export LUA_PATH='/usr/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;/home/dex/.luarocks/share/lua/5.1/?.lua;/home/dex/.luarocks/share/lua/5.1/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/lib/lua/5.1/loadall.so;./?.so;/home/dex/.luarocks/lib/lua/5.1/?.so'

# Safely add the luarocks executable path to the FRONT of the PATH variable
# We need to re-define the function here since it was unset earlier in the script.
addToPathFront() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

addToPathFront "/home/dex/.luarocks/bin"
unset -f addToPathFront



# _)
# W40 Mon, 29 at 06:49
# ---START------------------------------------------------------------
# ""functions in zshenv""

# [[]]

# DESCRIPTION:

# Why?:

# --------------------------------------------------------------------


# the yazi function recommended in the doc: this one y helps you when you are deep in a location when you exit yazi you are in that location in terminal
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}




# --------------------------------------------------------------------
# ""functions in zshenv""
# ---END--------------------------------------------------------------


