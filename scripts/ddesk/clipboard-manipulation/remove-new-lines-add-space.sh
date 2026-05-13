#!/bin/bash

# 1. Get the current clipboard content
RAW_TEXT=$(xclip -selection clipboard -o)

# 2. Process the text:
# - 'tr -s "[:space:]" " "' replaces all newlines, tabs, and multiple spaces with a single space
# - 'sed' trims the very first and very last space if they exist
CLEAN_TEXT=$(echo "$RAW_TEXT" | tr -s "[:space:]" " " | sed 's/^ //;s/ $//')

# 3. Put the cleaned text back into the clipboard (without a trailing newline)
echo -n "$CLEAN_TEXT" | xclip -selection clipboard

# 4. "The Handshake" (Ensures keys are released before pasting)
# This prevents the script from failing if you are holding down a hotkey
sleep 0.1
xdotool keyup --all
sleep 0.1

# 5. Paste it
# xdotool key ctrl+v
