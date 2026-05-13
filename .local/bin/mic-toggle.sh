#!/bin/bash

# Toggle the mute status of the default source (microphone)
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Optional: Send a notification so you know the status
# Requires 'libnotify' package
MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@)

if [[ $MUTE_STATUS == *"yes"* ]]; then
    notify-send -t 1000 -u critical "Microphone" "MUTED 🔇"
else
    notify-send -t 1000 "Microphone" "LIVE 🎤"
fi
