#!/bin/bash

#======== Solution 1 by ai ==============
# best solution does exactly what I want
alacritty &
ALACRITTY_PID=$!

echo "Launched Alacritty with PID: $ALACRITTY_PID"

# 1. CRITICAL: Wait for the window to be created and mapped.
# We must wait until the Alacritty application has started and
# created its window, setting the _NET_WM_PID property.
sleep 1 

# --- Reliable WID Discovery using PID (NET_WM_PID) ---
# We use 'xdotool search --pid' which is specifically designed 
# to look up windows using the _NET_WM_PID property. This is 
# much more efficient and reliable than manual looping.

ALACRITTY_WID=$(xdotool search --pid "$ALACRITTY_PID")

# Note on --pid search: If multiple windows share the same PID (e.g., if
# a program spawns child windows), this might return multiple WIDs. Since
# Alacritty typically only has one main window, this is usually safe.
# If multiple are found, we just take the first one.
if [[ "$ALACRITTY_WID" =~ " " ]]; then
    ALACRITTY_WID=$(echo "$ALACRITTY_WID" | awk '{print $1}')
fi
# --- End WID Discovery Logic ---


echo "Found WID: $ALACRITTY_WID"

# 2. Set the window to sticky
if [ -n "$ALACRITTY_WID" ]; then
    echo "Setting window $ALACRITTY_WID to sticky mode (-1)."
    # The command for sticky is setting the desktop to -1 (all desktops)
    xdotool set_desktop_for_window "$ALACRITTY_WID" -1
else
    echo "Error: Could not find WID for PID $ALACRITTY_PID."
fi


#======== Solution 2 by ai ==============
# ========= this is a sick solution that solves it but makes title temporary ========
# the temporary title is reset and it's reset to Alacritty and it screws the titles
# when i'm in a new dir it doesn't update. but this solves it so yeah

# 1. Define a unique identifier for this specific Alacritty instance.
# UNIQUE_TITLE="AlacrittyTempID_$(date +%s)_$$"
# DEFAULT_TITLE="Alacritty" # Or whatever your desired default title is
#
# echo "Launching Alacritty with temporary unique title: $UNIQUE_TITLE"
#
# # 2. Launch Alacritty, setting the unique title (-T).
# alacritty -T "$UNIQUE_TITLE" &
# ALACRITTY_PID=$!
#
# echo "Launched Alacritty with PID: $ALACRITTY_PID"
#
# # 3. CRITICAL: Wait for the window to be created and the title to be set.
# sleep 0.5 
#
# # 4. Reliable WID Discovery using the unique temporary title.
# # --onlyvisible is sometimes helpful, but --limit 1 ensures we get only the first match.
# ALACRITTY_WID=$(xdotool search --limit 1 --name "$UNIQUE_TITLE")
#
# echo "Found WID: $ALACRITTY_WID"
#
# if [ -n "$ALACRITTY_WID" ]; then
#     # 5. Reset the window title back to the default/desired title.
#     echo "Resetting window title to: $DEFAULT_TITLE"
#     xdotool set_window --name "$DEFAULT_TITLE" "$ALACRITTY_WID"
#
#     # 6. Set the window to sticky (-1 means 'all desktops')
#     echo "Setting window $ALACRITTY_WID to sticky mode (all desktops)."
#     xdotool set_desktop_for_window "$ALACRITTY_WID" -1
# else
#     echo "Error: Could not find WID using temporary title $UNIQUE_TITLE."
# fi




