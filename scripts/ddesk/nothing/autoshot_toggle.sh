#!/bin/bash
#
# This script is a wrapper for the autoshot.sh script. It's a button that you click on and off
# The autoshot.sh script doesn't give notifcations or anything you just run it and kill it via
# kill or pkill. This wrapper is convenient because it gives you visuals but it is not needed.

# /home/dex/scripts/ddesk/nothing/autoshot.sh
TARGET="autoshot.sh"
ID=9910
TIME=400

# Use -9 (SIGKILL) so it dies even if it is currently Paused (T)
if pkill -9 -f "$TARGET"; then
    dunstify -r $ID -t $TIME -u low "Autoshot" "<span color='#ff5555'>⏹ Killed (Reset)</span>"
else
    # Start the script
    "/home/dex/scripts/ddesk/nothing/autoshot.sh" &
    dunstify -r $ID -t $TIME -u low "Autoshot" "<span color='#50fa7b'>▶ Started</span>"
fi
