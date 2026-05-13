#!/bin/bash
# Get the ID of the window that currently has focus
ID=$(xdotool getactivewindow)

# Toggle the skip_taskbar state
wmctrl -i -r "$ID" -b toggle,skip_taskbar
