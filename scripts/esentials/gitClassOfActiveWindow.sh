#!/bin/sh

# This script gets the class name of the active window and
# displays it in a pop-up box, ready for you to copy.

# Get the ID and Class Name of the currently active window.
ID=$(xdotool getactivewindow)
if [ -z "$ID" ]; then
    zenity --error --text="Could not find an active window."
    exit 1
fi
CLASS_NAME=$(xdotool getwindowclassname "$ID")

echo "the class is $CLASS_NAME"

# Display the class name in a Zenity message box.
# The <tt> tags make the text monospace, which is easy to copy.
zenity --info \
       --title="Window Class Finder" \
       --width=300 \
       --text="<b>Window Class Name:</b>\n\n<tt>$CLASS_NAME</tt>\n\n(You can now copy this text and add it to the script's list)"
