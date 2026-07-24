#!/bin/bash
export DISPLAY=:0
export XAUTHORITY=/home/dex/.Xauthority

WID=$(xdotool getactivewindow)
/home/dex/scripts/ddesk/nothing/flameshotdelayed.sh
xdotool windowfocus "$WID"
