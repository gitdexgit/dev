#!/bin/bash
#
# A simple script to rename the current virtual desktop using rofi and wmctrl.
#
# Dependencies: rofi, wmctrl

# 1. Use rofi to prompt the user for a new desktop name.
#    -dmenu: Run in dmenu mode (one line input/output)
#    -p: Set the prompt text
NEW_NAME=$(rofi -dmenu -p "Rename Desktop:")

# 2. Check if the user actually entered a name (and didn't just press Esc).
#    If NEW_NAME is not an empty string, then proceed.
if [[ -n "$NEW_NAME" ]]; then
    # 3. Use wmctrl to rename the current desktop.
    #    -N <NAME>: Sets the name of the CURRENT desktop.
    wmctrl -N "$NEW_NAME"
fi
