#!/bin/bash


xdotool click 1

skippy-xd --expose --wm-class $(xdotool getwindowclassname $(xdotool getactivewindow))

