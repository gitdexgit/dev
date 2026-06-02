#!/bin/bash

# User info
USER_NAME="dex"
USER_ID=$(id -u $USER_NAME)

# Export environment for user tools
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus

FLAG="/tmp/phone_mic_muted"
ICON_NAME="phone_mic_indicator"

# Function to run as user
run_user() {
    sudo -u $USER_NAME DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus "$@"
}

# Kill existing icon to refresh
pkill -f "yad --notification --name=$ICON_NAME"

if [ -f "$FLAG" ]; then
    # ACTION: UNMUTE
    adb shell cmd sensor_privacy disable 0 microphone
    rm "$FLAG"

    # Tray Icon - LIVE
    run_user yad --notification --name="$ICON_NAME" \
        --image="microphone-sensitivity-high" \
        --text="Phone Mic LIVE" \
        --command="bash $0" &

    run_user notify-send -t 1000 "Phone Mic" "LIVE 🎤"
else
    # ACTION: MUTE
    adb shell cmd sensor_privacy enable 0 microphone
    touch "$FLAG"

    # Tray Icon - MUTED
    run_user yad --notification --name="$ICON_NAME" \
        --image="microphone-sensitivity-muted" \
        --text="Phone Mic MUTED" \
        --command="bash $0" &

    run_user notify-send -t 1000 -u critical "Phone Mic" "MUTED 🔇"
fi
