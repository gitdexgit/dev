#!/bin/sh

# make sure you have https://imgur.com/a/s1wPArz a setup to save like cache so this woorks 

# Define the file where we store the number of the last desktop.
# Using the .cache directory is good practice for temporary data.
LAST_DESKTOP_FILE="$HOME/.cache/last_desktop"

    
CURRENT_DESKTOP_FILE="$HOME/.cache/current_desktop"

if [ ! -f "$CURRENT_DESKTOP_FILE" ]; then
    echo "0" > "$CURRENT_DESKTOP_FILE"
fi

if [ -s "$LAST_DESKTOP_FILE" ]; then

    PREV_DESKTOP=$(cat "$LAST_DESKTOP_FILE")
    
    xdotool get_desktop > "$LAST_DESKTOP_FILE"

    # Go to the previously saved desktop.
    xdotool set_desktop "$PREV_DESKTOP"
    sleep 0.2
    xdotool get_desktop > "$CURRENT_DESKTOP_FILE"

fi
