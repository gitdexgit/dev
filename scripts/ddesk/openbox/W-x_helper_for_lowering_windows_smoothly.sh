#!/bin/bash
sleep 0.1
xdotool click 1
sleep 0.1
xdotool mousemove --window $(xdotool getactivewindow) --polar 0 0
exit
