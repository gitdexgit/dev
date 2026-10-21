#!/bin/bash

echo "--- Detecting OS and Package Manager... ---"

# 1. Detect Package Manager and Define Package Lists
if command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
    # Arch Names
    needed_packages=(
        git rsync fzf neovim lua luarocks clang
        gcc inetutils openssh base-devel tmux unzip
        rust deno nodejs npm python
        xorg-server xorg-xinit i3-wm alacritty dmenu xterm
        xdotool xbindkeys wmctrl jq
    )
    INSTALL_CMD="pacman -S --needed --noconfirm"
    UPDATE_CMD="pacman -Sy"

elif command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
    # Debian/Ubuntu Names (Note: some packages like 'deno' may require extra repos on apt,
    # but we will list the standard available ones)
    needed_packages=(
        git rsync fzf neovim lua5.4 luarocks clang
        gcc inetutils-ping openssh-client build-essential tmux unzip
        rustc nodejs npm python3
        xserver-xorg xinit i3 alacritty dmenu xterm
        xdotool xbindkeys wmctrl jq
    )
    INSTALL_CMD="apt install -y"
    UPDATE_CMD="apt update"
else
    echo "Error: Neither pacman nor apt found. This script only supports Arch or Debian/Ubuntu based systems."
    exit 1
fi

# 2. Check for sudo/root
if [ "$EUID" -eq 0 ]; then
    SUDO=""
else
    SUDO="sudo"
fi

echo "--- Updating system and installing dependencies via $PKG_MANAGER... ---"
$SUDO $UPDATE_CMD
$SUDO $INSTALL_CMD "${needed_packages[@]}"

# 3. Directory & Repo Logic
if [ "$(basename "$PWD")" != "dev" ]; then
    if [ ! -d "dev" ]; then
        echo "--- Cloning dev repository... ---"
        git clone https://www.github.com/gitdexgit/dev
    fi
    cd dev || exit 1
fi

# 4. Oh My Zsh & Plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "--- Installing Oh My Zsh... ---"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ] && git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"

# 5. Dotfile, Script, and Config Sync
echo "--- Syncing files... ---"
mkdir -p ~/.config ~/.local/share
rsync -a .zshrc .zshenv .tmux.conf .tmux .Xresources ~/ 2>/dev/null
[ -f ".xbindkeysrc" ] && rsync -a .xbindkeysrc ~/
[ -f ".xbindkeys" ] && rsync -a .xbindkeys ~/
[ -d "scripts" ] && rsync -a scripts/ ~/scripts/
[ -d ".config" ] && rsync -a .config/ ~/.config/
[ -d ".local/share/fonts" ] && rsync -a .local/share/fonts ~/.local/share/

# 6. Hardcoded Path Fixer (dex -> current user)
echo "--- Fixing hardcoded home paths... ---"
# Added safety: target the files specifically to avoid recursive errors
targets=(~/.config ~/.zshrc ~/.zshenv ~/.xinitrc ~/scripts)
for target in "${targets[@]}"; do
    if [ -e "$target" ]; then
        find "$target" -type f -exec sed -i "s|/home/dex|$HOME|g" {} + 2>/dev/null
    fi
done

# 7. Neovim Config Check
if [ ! -d "$HOME/.config/nvim" ] || [ -z "$(ls -A "$HOME/.config/nvim")" ]; then
    echo "--- Cloning Neovim config... ---"
    git clone https://www.github.com/gitdexgit/nvim "$HOME/.config/nvim"
fi

# 8. Create/Update .xinitrc
if [ ! -f "$HOME/.xinitrc" ]; then
    echo "--- Creating .xinitrc... ---"
    cat <<EOF > "$HOME/.xinitrc"
#!/bin/sh
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources &
export TERMINAL=alacritty
export EDITOR=nvim
command -v spice-vdagent > /dev/null && spice-vdagent &
[ -f ~/.xbindkeysrc ] && xbindkeys &
[ -f ~/.xbindkeys ] && xbindkeys -f ~/.xbindkeys &
exec i3
EOF
    chmod +x "$HOME/.xinitrc"
fi

echo "--- Setup Complete! ---"
echo "Hostname IP: $(hostname -i || echo 'unknown')"
echo "Type 'startx' to begin (if GUI packages installed correctly)."
