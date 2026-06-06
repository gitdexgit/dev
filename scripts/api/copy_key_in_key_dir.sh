#!/bin/bash
KEY_DIR="$HOME/.key"

# Select file
CHOICE=$(ls "$KEY_DIR" | rofi -dmenu -p "Select Key:")
[[ -z "$CHOICE" ]] && exit

# Copy key
cat "$KEY_DIR/$CHOICE" | tr -d '\n' | xclip -selection clipboard

# Background cleanup
(
    sleep 10
    # Wipe system clipboard
    xclip -selection clipboard /dev/null
    # Delete top item from CopyQ history
    copyq remove 0
) &
