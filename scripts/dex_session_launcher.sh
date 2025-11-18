#!/bin/sh

# ===================================================================
# Part 1: Recreate the Graphical Session Context
# ===================================================================
export DISPLAY=:0
export LANG='en_US.UTF-8'
export XAUTHORITY='/home/dex/.Xauthority'
export DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/1000/bus'
export QT_QPA_PLATFORMTHEME='qt6ct'
export XDG_CURRENT_DESKTOP='LXQt'
export XDG_SESSION_DESKTOP='lxqt'
export XDG_SESSION_TYPE='x11'
export XDG_SEAT='seat0'
export XDG_SESSION_CLASS='user'
export XDG_SESSION_ID='2' # Note: This might change, but is usually fine.
export XDG_CONFIG_DIRS='/etc:/etc/xdg:/usr/share'
export XDG_DATA_DIRS='/home/dex/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share'
export XDG_RUNTIME_DIR='/run/user/1000' # CRITICAL FIX: Define this variable.

# let's just start fresh, idk I'm new to sudo and sudo might start with minimal paths
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin"



# ===================================================================
# Part 2: Load the User's Defined Environment from .zshenv
# ===================================================================
if [ -f "$HOME/.zshenv" ]; then
  # Sourcing this file loads your PATH, EDITOR, pyenv, and keychain.
  . "$HOME/.zshenv"
fi






# ===================================================================
# Part 3: Execute the final command
# ===================================================================
exec "$@"
