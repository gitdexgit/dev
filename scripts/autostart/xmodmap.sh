#!/bin/bash

# Start the xbindkeys hotkey daemon
# The '&' sends this command to the background
xbindkeys &

sleep 3m 

xmodmap "$HOME/.xmodmaprc" &

