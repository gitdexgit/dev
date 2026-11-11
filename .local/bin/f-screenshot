#!/bin/bash
# Get the currently active window ID
WID=$(xdotool getactivewindow)

# Launch flameshot
# Note: flameshot gui usually blocks until the screenshot is taken or cancelled
flameshot gui

# Refocus the original window
if [ -n "$WID" ]; then
    xdotool windowfocus "$WID"
fi
