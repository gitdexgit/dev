#!/bin/bash

# Define the menu options
options="Move to Workspace 1
Move to Workspace 2
Move to Workspace 3
Move to Workspace 4
Move to Workspace 5
Move to Workspace 6
Move to Workspace 7
Move to Workspace 8
Move to Workspace 9
Move to Workspace 10
---
Toggle Floating
Toggle Sticky
Toggle Fullscreen
---
Kill Window"

# Show the menu using rofi
# -dmenu makes rofi act like a list picker
# -i makes it case-insensitive
# -p is the prompt
selection=$(echo -e "$options" | rofi -dmenu -i -p "Window Actions:" -lines 14)

# Execute the i3-msg command based on selection
case "$selection" in
    "Move to Workspace 1") i3-msg move container to workspace number 1 ;;
    "Move to Workspace 2") i3-msg move container to workspace number 2 ;;
    "Move to Workspace 3") i3-msg move container to workspace number 3 ;;
    "Move to Workspace 4") i3-msg move container to workspace number 4 ;;
    "Move to Workspace 5") i3-msg move container to workspace number 5 ;;
    "Move to Workspace 6") i3-msg move container to workspace number 6 ;;
    "Move to Workspace 7") i3-msg move container to workspace number 7 ;;
    "Move to Workspace 8") i3-msg move container to workspace number 8 ;;
    "Move to Workspace 9") i3-msg move container to workspace number 9 ;;
    "Move to Workspace 10") i3-msg move container to workspace number 10 ;;
    "Toggle Floating") i3-msg floating toggle ;;
    "Toggle Sticky") i3-msg sticky toggle ;;
    "Toggle Fullscreen") i3-msg fullscreen toggle ;;
    "Kill Window") i3-msg kill ;;
esac
