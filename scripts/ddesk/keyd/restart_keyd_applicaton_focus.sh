#!/bin/bash

# This is a good idea! It releases the modifier keys (Super and Shift)
# that you used to trigger the script in keyd, so they don't interfere
# with the keys we are about to simulate.
xdotool keyup Super Shift Alt Control

sleep 1
# Use the correct keysym for the Mail key.
xdotool key XF86Mail

sleep 1
# Send the 'q' key.
xdotool key q
