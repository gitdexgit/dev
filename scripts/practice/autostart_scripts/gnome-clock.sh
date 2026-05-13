#!/bin/bash

# --- Configuration ---

# Window Class (from WM_CLASS(STRING) = "copyq", "copyq")
WINDOW_CLASS="org.gnome.clocks"

sleep 0.1

gnome-clocks &

sleep 0.5
sleep 0.5
sleep 0.5
sleep 0.5

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
    echo "Error: gnome-lock window not found after launch."
    exit 1
fi


# -i: Target by Window ID
# 3. Set the size and position of the window
xdotool set_desktop_for_window "$WINDOW_ID" 8


echo "sublime positioned on eDP-1 and set to 'On All Desktops' (Sticky)."
