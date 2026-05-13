#!/bin/bash

# Get the ID of the currently active window
ID=$(xdotool getactivewindow)

# Get the current window geometry (X, Y, Width, Height)
# The 'eval' command makes them available as shell variables $X, $Y, etc.
eval $(xdotool getwindowgeometry --shell $ID)

# Calculate the new X and Y coordinates based on the script's arguments
# $1 is the first argument (x or y)
# $2 is the second argument (the pixel amount)
case "$1" in
    x)
        X=$((X + $2))
        ;;
    y)
        Y=$((Y + $2))
        ;;
esac

# Command xdotool to move the window to the new ABSOLUTE coordinates
xdotool windowmove $ID $X $Y
