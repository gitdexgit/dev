#!/bin/bash
#
# This script intelligently syncs both system and user-level config files.
# It MUST be run with sudo, but it will correctly find the original user's
# home directory and fix repository permissions upon completion.

set -e

# --- Sudo & User Detection ---
if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run with sudo."
   exit 1
fi

if [ -n "$SUDO_USER" ]; then
    ORIGINAL_USER=$SUDO_USER
    HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    echo "❌ Could not determine the original user. Please run with 'sudo'."
    exit 1
fi

echo "🚀 Running as root, syncing files for user '$ORIGINAL_USER' from '$HOME_DIR'"

# --- Configuration ---
REPO_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
# --- CORRECTED: Use a bash array for rsync exclusion flags ---
EXCLUDE_ARRAY=(--exclude='*.dat' --exclude='.git')

# --- ### List of Targets to Sync ### ---

# --- 1. System-level files and directories (ABSOLUTE PATHS) ---
SYSTEM_TARGETS=(
    "/etc/fstab"
    "/etc/pacman.conf"
    "/etc/de"
    "/etc/sudoers"
    "/etc/nftables.conf"
    "/etc/hostname"
    "/etc/locale.gen"
    "/etc/vconsole.conf"
    "/etc/keyd" # Sync the whole directory
    "/usr/bin/keyd-application-mapper"
    "/usr/bin/keyd-application-mapper.bak"
    "/etc/sudoers.d"
    "/usr/local/bin"
)

# --- 2. Home directory files and directories (RELATIVE PATHS) ---
HOME_TARGETS=(
    ".zshrc"
    ".zshenv"
    ".gitconfig"
    ".tmux.conf"
    ".bashrc"
    ".vimrc"
    "scripts"
    ".oh-my-zsh/custom" # Syncs only the custom folder
    ".tmux"
    ".themes"
    "themes"
    ".config/yazi"
    "Desktop/zen.txt"
    "Desktop/zen-bookmarks.html"
    "Desktop/I_want_to_Do.maybe.md"
    ".config/alacritty"
    ".config/pipewire"
    ".config/wireplumber"
    ".config/mimeapps.list"
    ".config/picom/picom.conf"
    ".config/espanso"
    ".config/copyq"
    ".config/autostart"
    ".config/lxqt"
    ".config/gtk-3.0"
    ".config/Thunar"
    ".config/vlc"
    ".config/qterminal.org"
    ".config/mpv"
    ".config/nvim"
    ".config/nvim2"
    ".config/input-remapper-2"
    ".config/openbox"
    ".config/gh/config.yml"
    ".config/openrazer"
    ".config/rofi"
    ".config/skippy-xd"
    ".config/devilspie2"
    ".config/zsh"
    ".config/tmux-sessionizer"
    ".local/share/applications"
    ".local/share/fonts"
    ".local/scripts"
    ".local/bin"
)

# --- SCRIPT LOGIC ---

echo ""
echo "👤 Syncing user-level targets from $HOME_DIR..."
for target in "${HOME_TARGETS[@]}"; do
    source_path="$HOME_DIR/$target"
    dest_path="$REPO_DIR/$target"

    if [ -f "$source_path" ]; then
        echo "   - Syncing file: ~/$target"
        mkdir -p "$(dirname "$dest_path")"
        rsync -a "$source_path" "$dest_path"
    elif [ -d "$source_path" ]; then
        echo "   - Syncing dir:  ~/$target/"
        mkdir -p "$dest_path"
        # --- CORRECTED: Use the array expansion syntax ---
        rsync -a --delete "${EXCLUDE_ARRAY[@]}" "$source_path/" "$dest_path/"
    else
        echo "   - WARNING: Target ~/$target not found. Skipping."
    fi
done

echo ""
echo "⚙️  Syncing system-level targets..."
for target in "${SYSTEM_TARGETS[@]}"; do
    if [ -e "$target" ]; then
        echo "   - Syncing: $target"
        # --- CORRECTED: Use the array expansion syntax ---
        rsync -aR --delete "${EXCLUDE_ARRAY[@]}" "$target" "$REPO_DIR/"
    else
        echo "   - WARNING: Target $target not found. Skipping."
    fi
done

# --- Final Permission Fix ---
echo ""
echo "🔐 Fixing repository file ownership for user '$ORIGINAL_USER'..."
chown -R "$ORIGINAL_USER":"$(id -gn "$ORIGINAL_USER")" "$REPO_DIR"
echo "✅ All done. Repository is ready for you to use."
