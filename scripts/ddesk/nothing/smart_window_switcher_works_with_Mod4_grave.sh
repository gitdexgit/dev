#!/bin/bash

# This script intelligently switches desktops and prepares the 'last_desktop'
# cache file for a toggle-back script.

# ---CONFIGURATION---
# This file must be the SAME as the one used in your 'move_to_last_desktop.sh'
LAST_DESKTOP_FILE="$HOME/.cache/last_desktop"
# ---END CONFIGURATION---


# 1. Check if a desktop number was provided as an argument.
if [ -z "$1" ]; then
    echo "Error: No desktop number provided." >&2
    echo "Usage: $0 <desktop_number>" >&2
    exit 1
fi

TARGET_DESKTOP="$1"

# 2. Get the desktop number we are on right now.
CURRENT_DESKTOP=$(xdotool get_desktop)

# 3. THE CORE LOGIC:
#    Only act if the target desktop is DIFFERENT from our current one.
if [ "$CURRENT_DESKTOP" -ne "$TARGET_DESKTOP" ]; then
    # Since we are about to move, save our CURRENT desktop number.
    # This is what allows the 'grave' key to toggle back to where we came from.
    echo "$CURRENT_DESKTOP" > "$LAST_DESKTOP_FILE"

    # Now, perform the switch to the target desktop.
    xdotool set_desktop "$TARGET_DESKTOP"
fi

# If we were already on the target desktop, the script simply does nothing and exits.
# This prevents the LAST_DESKTOP_FILE from being incorrectly overwritten.
