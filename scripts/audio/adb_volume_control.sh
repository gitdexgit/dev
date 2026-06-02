#!/bin/bash

# User environment
USER_NAME="dex"
USER_ID=$(id -u $USER_NAME)
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus

# Config
STEP=5
MAX_VOL=100
TAG="x-dunst-stack-tag:volume"
YAD_VOL_NAME="vol_mute_indicator"
# Change this to your preferred icon name
MUTE_ICON="audio-muted"

run_user() {
    sudo -u $USER_NAME DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus "$@"
}

case $1 in
    up)
        CUR=$(pamixer --get-volume)
        NEW=$((CUR + STEP))
        [ "$NEW" -gt "$MAX_VOL" ] && NEW=$MAX_VOL
        pamixer -u --set-volume "$NEW"
        adb shell 'for i in {1..3}; do input keyevent 24; done'
        ;;
    down)
        CUR=$(pamixer --get-volume)
        NEW=$((CUR - STEP))
        [ "$NEW" -lt 0 ] && NEW=0
        pamixer --set-volume "$NEW"
        adb shell 'for i in {1..3}; do input keyevent 25; done'
        ;;
    mute)
        pamixer -t
        adb shell input keyevent 164
        ;;
esac

VOL=$(pamixer --get-volume)
MUTE=$(pamixer --get-mute)

# Volume Tray Icon
if [ "$MUTE" = "true" ] || [ "$VOL" -eq 0 ]; then
    pgrep -f "$YAD_VOL_NAME" > /dev/null || \
    run_user yad --notification --image="$MUTE_ICON" --text="Speakers Muted" --name="$YAD_VOL_NAME" &
    ICON="audio-volume-muted"
    TEXT="Muted"
else
    pkill -f "$YAD_VOL_NAME"
    [ "$VOL" -lt 33 ] && ICON="audio-volume-low"
    [ "$VOL" -ge 33 ] && [ "$VOL" -lt 66 ] && ICON="audio-volume-medium"
    [ "$VOL" -ge 66 ] && ICON="audio-volume-high"
    TEXT="Volume: ${VOL}%"
fi

run_user dunstify -a "System" -u low -t 300 -i "$ICON" -h string:"$TAG" -h int:value:"$VOL" "$TEXT"
