#!/bin/bash
#
# This script performs the "select line and delete" macro.
# 1. Go to the end of the line.
# 2. Hold shift and go to the home of the line (selecting it).
# 3. Press delete twice (to handle different editor behaviors).

xdotool keyup shift

# 2. Wait for a tiny moment.
#    This gives the system a few milliseconds to process the "keyup" events
#    before we send new commands. 50ms (0.05s) is imperceptible to you
#    but ensures reliability.
sleep 0.01


xdotool key Home shift+Enter Up

# sleep 0.01

# xdotool keydown shift
