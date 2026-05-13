#!/bin/bash

get_active_window=$(xdotool getactivewindow)
window_class=$(xdotool getwindowclassname "$get_active_window")

echo The active window is "$get_active_window"
sleep 5
echo The window class is "$window_class"
sleep 5
echo "Now I'm going to run the 'skippy-xd --desktop -1 --wm-status sticky,shaded,maximized_vert,maximized_horz,maximized --wm-class "$window_class" --config ~/.config/skippy-xd/skippy-xd2.rc' command"
sleep 1
echo "in 3.."
sleep 1
echo "in 2.."
sleep 1
echo "in 1.."
sleep 1
echo "in now"
sleep 1
skippy-xd --desktop -1 --wm-status sticky,shaded,maximized_vert,maximized_horz,maximized --wm-class "$window_class"

