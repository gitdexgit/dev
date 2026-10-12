#!/bin/bash

# Toggle mute
pactl set-source-mute @DEFAULT_SOURCE@ toggle
MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@)

# Unique name for yad process
ICON_NAME="mic_indicator"

if [[ $MUTE_STATUS == *"yes"* ]]; then
    # Muted: Kill icon
    pkill -f "yad --notification --name=$ICON_NAME"
    notify-send -t 250 -u critical "Microphone" "MUTED 🔇"
else
    # Live: Start icon if not running
    if ! pgrep -f "yad --notification --name=$ICON_NAME" > /dev/null; then
        yad --notification --name="$ICON_NAME" \
            --image="audio-input-microphone" \
            --text="Mic Live" &
    fi
    notify-send -t 250 "Microphone" "LIVE 🎤"
fi
