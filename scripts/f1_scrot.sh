#!/bin/bash
export DISPLAY=:0
export XAUTHORITY=/home/dex/.Xauthority


# No need
# WID=$(xdotool getactivewindow)

scrot -s /tmp/s.png && xclip -selection clipboard -t image/png -i /tmp/s.png && rm /tmp/s.png


# No need ok
# xdotool windowfocus "$WID"
