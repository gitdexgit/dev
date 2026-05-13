#!/bin/sh

# Configuration
STEP=5
MAX_VOL=150
TAG="x-dunst-stack-tag:volume"

# 1. Get current volume before doing anything
CUR_VOL=$(pamixer --get-volume)

# 2. Perform Action with explicit math to prevent snapping to 100
case $1 in
    up)
        # Only increase if we are below the Max limit
        NEW_VOL=$((CUR_VOL + STEP))
        [ "$NEW_VOL" -gt "$MAX_VOL" ] && NEW_VOL=$MAX_VOL
        pamixer -u --set-volume "$NEW_VOL" --allow-boost
        ;;
    down)
        # Decrease from whatever the current number is
        NEW_VOL=$((CUR_VOL - STEP))
        [ "$NEW_VOL" -lt 0 ] && NEW_VOL=0
        # Adding --allow-boost here is the fix for the 140 -> 100 jump
        pamixer --set-volume "$NEW_VOL" --allow-boost
        ;;
    mute)
        pamixer -t
        ;;
esac

# 3. Get New Status for the notification
VOL=$(pamixer --get-volume)
MUTE=$(pamixer --get-mute)

# 4. Determine Icon and Text
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

# 5. Send Notification
dunstify -a "System" \
         -u low \
         -t 300 \
         -i "$ICON" \
         -h string:"$TAG" \
         -h int:value:"$VOL" \
         "$TEXT"
