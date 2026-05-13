#!/bin/sh

# Get the ID of the currently active window.
ID=$(xdotool getactivewindow)

# If no window is active, do nothing.
if [ -z "$ID" ]; then
    exit
fi

# 3. Move the active window to a known, absolute position.
#    This is the step you correctly pointed out was missing.
xdo move -x 200 -y 200 "$ID"

# Get the geometry output as a plain string of text.
GEOMETRY_OUTPUT=$(xdotool getwindowgeometry --shell "$ID")

# Display the Window ID and the raw geometry output in a Zenity message box.
zenity --info \
       --title="Window Geometry Test" \
       --text="<b>Window ID:</b> $ID\n\n<b>xdotool output:</b>\n$GEOMETRY_OUTPUT"
