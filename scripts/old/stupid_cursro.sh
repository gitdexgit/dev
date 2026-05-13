#!/bin/bash

# --- Configuration ---
SIZE=20             # Diameter of the laser dot (pixels)
COLOR="red"         # Color (can be any CSS color name or hex code)
DELAY=0.01          # Refresh rate (0.01 = 10ms)

# Use an invisible character for the title to help find the window later
TITLE="LaserDot_YAD_$$"

# 1. Start the YAD window in the background
# --undecorated: Removes title bar and borders.
# --fixed: Prevents resizing.
# --geometry: Sets size (X and Y are the width/height).
# --skip-taskbar: Hides it from task manager/panel.
# --on-top: Keeps it above other windows.
# --no-buttons: No OK/Cancel buttons.
yad --undecorated --fixed --geometry ${SIZE}x${SIZE} \
    --skip-taskbar --on-top --no-buttons \
    --title="$TITLE" \
    --text=" " &  # Need some content, even a space

LASER_PID=$!
sleep 0.5

# Find the Window ID (WID)
LASER_WID=$(xdotool search --pid "$LASER_PID" --name "$TITLE" 2>/dev/null | tail -n 1)

if [ -z "$LASER_WID" ]; then
    echo "Error: Could not find the YAD LaserDot window."
    kill $LASER_PID 2>/dev/null
    exit 1
fi

echo "Laser running. Press Ctrl+C in this terminal to stop the laser."

# 2. Add an extra layer of style: make it a circle!
# We set the 'corner-radius' property via wmctrl or similar window property tools.
# This part is highly dependent on your window manager (KDE/GNOME/etc.)
# We will skip complex WM styling for maximum compatibility and rely on the square dot.

# 3. Main Loop: Move the dot to the cursor position
while true; do
    MOUSE_POS=$(xdotool getmouselocation --shell)
    eval "$MOUSE_POS"
    
    # Reposition the laser dot window, centered on the cursor tip.
    NEW_X=$((X - SIZE / 2))
    NEW_Y=$((Y - SIZE / 2))
    
    xdotool windowmove "$LASER_WID" "$NEW_X" "$NEW_Y"

    sleep "$DELAY"
done

# --- Cleanup ---
kill $LASER_PID 2>/dev/null
