#!/usr/bin/env bash

xdotool type "q:"

xdotool key Return
xdotool key Return

xdotool type "a:"

# move cursor back to middle (adjust as needed)
sleep 0.1
xdotool key Up Up
xdotool key End
