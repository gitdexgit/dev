#!/bin/sh

STEP=5
MAX_VOL=150
TAG="x-dunst-stack-tag:volume"
YAD_NAME="mute_indicator"

CUR_VOL=$(pamixer --get-volume)

case $1 in
    up)
        NEW_VOL=$((CUR_VOL + STEP))
        [ "$NEW_VOL" -gt "$MAX_VOL" ] && NEW_VOL=$MAX_VOL
        pamixer -u --set-volume "$NEW_VOL" --allow-boost
        ;;
    down)
        NEW_VOL=$((CUR_VOL - STEP))
        [ "$NEW_VOL" -lt 0 ] && NEW_VOL=0
        pamixer --set-volume "$NEW_VOL" --allow-boost
        ;;
    mute)
        # Toggle default
        pamixer -t
        # Sync state
        STATE=$(pamixer --get-mute)
        [ "$STATE" = "true" ] && VAL="1" || VAL="0"

        # Force all hardware sinks
        for s in $(pactl list short sinks | cut -f1); do
            pactl set-sink-mute "$s" "$VAL"
        done
        # Force all app playbacks (Firefox/ALSA/etc)
        for i in $(pactl list short sink-inputs | cut -f1); do
            pactl set-sink-input-mute "$i" "$VAL"
        done
        ;;
esac

VOL=$(pamixer --get-volume)
MUTE=$(pamixer --get-mute)

# Yad Logic
if [ "$MUTE" = "true" ] || [ "$VOL" -eq 0 ]; then
    pgrep -f "$YAD_NAME" > /dev/null || \
    yad --notification \
        --image="audio-volume-muted" \
        --text="System Muted" \
        --command="pamixer -t" \
        --name="$YAD_NAME" &
else
    pkill -f "$YAD_NAME"
fi

# Notification Logic
if [ "$MUTE" = "true" ] || [ "$VOL" -eq 0 ]; then
    ICON="audio-volume-muted"
    TEXT="Muted"
else
    if [ "$VOL" -lt 33 ]; then ICON="audio-volume-low"
    elif [ "$VOL" -lt 66 ]; then ICON="audio-volume-medium"
    elif [ "$VOL" -le 100 ]; then ICON="audio-volume-high"
    else ICON="audio-volume-overamplified"
    fi
    [ "$VOL" -gt 100 ] && TEXT="Volume: ${VOL}% (BOOST)" || TEXT="Volume: ${VOL}%"
fi

dunstify -a "System" -u low -t 300 -i "$ICON" -h string:"$TAG" -h int:value:"$VOL" "$TEXT"
