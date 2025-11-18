#!/bin/bash
# this is a toggle it's sick

# Get the ID of the currently active window
ACTIVE_WIN_ID=$(xdotool getactivewindow)

# Check if the window already has the "skip_taskbar" property
# We use xprop to read the window's state and grep to check for the property.
# The -q flag makes grep "quiet" - it just returns a success/fail code.
if xprop -id "$ACTIVE_WIN_ID" _NET_WM_STATE | grep -q "_NET_WM_STATE_SKIP_TASKBAR"; then
    # If it's already hidden, REMOVE the property to unhide it
    wmctrl -i -r "$ACTIVE_WIN_ID" -b remove,skip_taskbar
else
    # If it's visible, ADD the property to hide it
    wmctrl -i -r "$ACTIVE_WIN_ID" -b add,skip_taskbar
fi
