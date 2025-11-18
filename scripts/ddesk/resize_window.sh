#!/bin/bash

# The amount to resize by in pixels
STEP=40

# Get the ID of the currently active window
ID=$(xdotool getactivewindow)

# First, un-maximize the window, otherwise resizing might fail
wmctrl -ir $ID -b remove,maximized_vert,maximized_horz

# Get the current window geometry (X, Y, Width, Height)
eval $(xdotool getwindowgeometry --shell $ID)

# Calculate the new dimensions based on the input arguments
case "$1" in
    h)
        WIDTH=$((WIDTH + $2))
        ;;
    v)
        HEIGHT=$((HEIGHT + $2))
        ;;
esac

# Apply the new size using xdotool
xdotool windowsize $ID $WIDTH $HEIGHT
