#!/bin/bash

# Get the new title from the user using rofi
NEW_TITLE=$(rofi -dmenu -p "Rename Window To:")

# If the user entered a title and didn't cancel
if [ -n "$NEW_TITLE" ]; then
    # Use wmctrl to set the title of the currently active window.
    # This is more robust and notifies the window manager properly.
    wmctrl -r :ACTIVE: -T "$NEW_TITLE"
fi
