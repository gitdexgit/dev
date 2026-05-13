#!/bin/bash

sleep 0.1

# Script to make selected txt into UPPER.
SELECTED_TEXT=$(xclip -o -selection primary)

if [ -n "$SELECTED_TEXT" ]; then
    UPPER_TEXT=$(echo -n "$SELECTED_TEXT" | tr '[:upper:]' '[:lower:]')
    echo -n "$UPPER_TEXT" | xclip -selection clipboard
    # xdotool key ctrl+v
    # xdotool key --delay 100 --clearmodifiers ctrl+v

    # 3. Wait a tiny bit to give you time to start lifting your fingers
    sleep 0.15

    # 4. MANUALLY FORCE KEY-UP
    # This kills the "Pressed" state of Mod4, Shift, and Control
    xdotool keyup Super_L Super_R Shift_L Shift_R Control_L Control_R Alt_L Alt_R

    # 5. Paste
    xdotool key ctrl+v


fi

