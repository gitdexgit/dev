#!/bin/bash

# This is a good idea! It releases the modifier keys (Super and Shift)
# that you used to trigger the script in keyd, so they don't interfere
# with the keys we are about to simulate.
xdotool keyup Super Shift alt control

# Use the correct keysym for the Mail key.
xdotool key XF86Mail

# Wait for a brief moment.
sleep 0.15

# Send the 'q' key.
xdotool key q
