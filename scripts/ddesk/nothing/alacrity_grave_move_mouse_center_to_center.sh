#!/bin/sh

# 1. Launch alacritty in the background.
alacritty &

# 2. Immediately get the Process ID (PID) of the alacritty process we just launched.
#    '$!' is a special shell variable that holds the PID of the last backgrounded command.
APP_PID=$!

# 3. Use 'xdotool' to search for a window belonging to that specific PID.
#    The '--sync' flag is the magic: it tells xdotool to wait until a
#    matching window is fully "mapped" (i.e., actually visible on screen).
WINDOW_ID=$(xdotool search --sync --pid "$APP_PID" | head -n 1)

# 4. (Optional but recommended) If a window was found, move the mouse.
#    This prevents errors if alacritty failed to launch for some reason.
if [ -n "$WINDOW_ID" ]; then
    xdotool mousemove --window "$WINDOW_ID" --polar 0 0
fi
