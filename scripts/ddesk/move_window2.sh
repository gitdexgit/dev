#!/bin/sh

# --- The Calculator Logic ---

# 1. ASK: "Where is the window right now?"
# This gets the ID of the window you have clicked on (the active one).
ID=$(xdotool getactivewindow)
if [ -z "$ID" ]; then exit 1; fi

# This is the most important part. It gets the current X, Y, Width, and Height
# of that window and puts them into shell variables named $X, $Y, $WIDTH, $HEIGHT.
# This is how you "get the current position".
eval $(xdotool getwindowgeometry --shell "$ID")

# 2. CALCULATE: "What is the new coordinate?"
# This 'case' block checks if you want to change the 'x' or 'y' coordinate.
case "$1" in
    x)
        # It takes the current $X and adds the number you provided ($2).
        X=$((X + $2))
        ;;
    y)
        # It takes the current $Y and adds the number you provided ($2).
        Y=$((Y + $2))
        ;;
esac

# 3. COMMAND: "Move the window to the new coordinate."
# It uses the NEW calculated $X and the OLD $Y (or vice-versa)
# to move the window to its new absolute position.
xdo move -x "$X" -y "$Y" "$ID"
