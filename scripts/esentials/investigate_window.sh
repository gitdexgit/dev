#!/bin/bash

echo "--- Window Inspector ---"
echo "This script will help diagnose why a window's PID cannot be found."
echo ""
echo "INSTRUCTIONS:"
echo "1. The cursor will change to a crosshair."
echo "2. Please click directly on the main part of a known application window."
echo "   >>> Good example: The middle of your terminal window or a web browser. <<<"
echo "   >>> Bad example: The desktop background, a panel, or a window's title bar. <<<"
echo ""

# Get the Window ID from the user's click
WINDOW_ID=$(xdotool selectwindow)

# Check if we got an ID
if [ -z "$WINDOW_ID" ]; then
    echo "ERROR: Did not get a window ID. Please try again."
    exit 1
fi

echo "================================================================="
echo "Investigation Results for Window ID: $WINDOW_ID"
echo "================================================================="

echo ""
echo "--- 1. Checking PID with xdotool ---"
xdotool getwindowpid "$WINDOW_ID"
echo "(If the above is blank or shows an error, xdotool failed to find the PID.)"

echo ""
echo "--- 2. Checking Window Name with xdotool ---"
xdotool getwindowname "$WINDOW_ID"

echo ""
echo "--- 3. Dumping ALL properties with xprop ---"
echo "(We are looking for a line that says '_NET_WM_PID(CARDINAL) = ...')"
xprop -id "$WINDOW_ID"

echo ""
echo "================================================================="
echo "Analysis complete. Please copy and paste all the output above."
echo "================================================================="
