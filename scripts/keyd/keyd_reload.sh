#!/bin/bash
keyd reload

# Faster timeout (400ms)
sudo -u dex DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
    notify-send -t 400 \
    -h string:bgcolor:#FFFF00 \
    -h string:fgcolor:#000000 \
    "Keyd" "Config Reloaded" &

sudo -u dex XDG_RUNTIME_DIR=/run/user/1000 systemctl --user restart keyd-indicator.service
