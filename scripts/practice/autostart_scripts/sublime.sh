#!/bin/bash

# --- Configuration ---

# Window Class (from WM_CLASS(STRING) = "copyq", "copyq")
WINDOW_CLASS="sublime_text"

# Target Coordinates (Top-Left of eDP-1 screen)
# X coordinate: 1920
# Y coordinate: 152
TARGET_X=1920
TARGET_Y=152

# Target Size (Using laptop resolution)
TARGET_WIDTH=1366
TARGET_HEIGHT=768

# ---------------------


sleep 0.1
sleep 0.1
subl &

sleep 0.1
sleep 0.1
sleep 0.1
sleep 0.1
sleep 0.1
sleep 0.1

sleep 0.1
sleep 0.1
sleep 0.1
sleep 0.1
# Loop until wmctrl finds the window with the matching class
WINDOW_ID=""
for i in {1..10}; do
    WINDOW_ID=$(wmctrl -lx | grep -i "$WINDOW_CLASS\.$WINDOW_CLASS" | awk '{print $1}' | head -n 1)
    if [ -n "$WINDOW_ID" ]; then
        break
    fi
    sleep 0.2
done

if [ -z "$WINDOW_ID" ]; then
    echo "Error: sublime window not found after launch."
    exit 1
fi

echo "sublime Window ID found: $WINDOW_ID"

# -i: Target by Window ID
# 3. Set the size and position of the window
xdotool set_desktop_for_window "$WINDOW_ID" -1


echo "sublime positioned on eDP-1 and set to 'On All Desktops' (Sticky)."
