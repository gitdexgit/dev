#!/bin/bash

# --- CONFIGURATION ---
# Define the geometry (gravity,X,Y,width,height) for each window type.
# Your original geometry for normal windows:
DEFAULT_GEOMETRY="0,1922,207,1362,745"

# Define a different geometry for terminal windows.
# (Example: smaller, more centered, you can change this!)
TERMINAL_GEOMETRY="0,2000,250,1200,600"
# --- END CONFIGURATION ---


# Get the ID of the currently active window in decimal format.
# Requires `xdotool` to be installed (`sudo apt install xdotool` or similar).
ACTIVE_WIN_ID=$(xdotool getactivewindow)

# Get the WM_CLASS property of that window. wmctrl -lx is great for this.
# We convert the decimal ID to the hex format that wmctrl uses.
HEX_WIN_ID=$(printf "0x%08x" "$ACTIVE_WIN_ID")
WIN_CLASS=$(wmctrl -lx | grep "$HEX_WIN_ID" | awk '{print $3}')

# Check if the window class matches any of our known terminals.
# A 'case' statement is perfect for matching against a list.
case "$WIN_CLASS" in
    # Add your terminal's WM_CLASS here.
    # Format is often "Instance.Class". Use wildcards if needed.
    "xterm.XTerm"|\
        # It's a terminal, apply terminal geometry
        wmctrl -i -r "$HEX_WIN_ID" -e "$TERMINAL_GEOMETRY"
        ;;
    *)
        # It's not a terminal (or not in our list), apply default geometry
        wmctrl -i -r "$HEX_WIN_ID" -e "$DEFAULT_GEOMETRY"
        ;;
esac
