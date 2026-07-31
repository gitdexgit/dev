#!/bin/bash
#
# Get current title. Get prompted in rofi. Put current title in the prompt.
# Manage the prompt manually. Hit ok. changes the title of the current window

CURRENT=$(xdotool getactivewindow getwindowname)

# Pre-fill rofi using -filter
NEW_TITLE=$(rofi -dmenu -p "Rename Window:" -filter "$CURRENT")

# Apply if changed
[ -n "$NEW_TITLE" ] && wmctrl -r :ACTIVE: -T "$NEW_TITLE"
