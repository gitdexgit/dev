#!/bin/bash

PID_FILE="/tmp/record-area.pid"
OUTPUT="$HOME/Videos/record_$(date +%s).mp4"

start_recording() {
    GEOM=$(slop -f "%g") || exit 1
    SIZE=$(echo "$GEOM" | grep -oP '^\d+x\d+')
    X=$(echo "$GEOM" | grep -oP '(?<=\+)\d+' | sed -n '1p')
    Y=$(echo "$GEOM" | grep -oP '(?<=\+)\d+' | sed -n '2p')

    ffmpeg -f x11grab \
           -s "$SIZE" \
           -i ":0.0+${X},${Y}" \
           -c:v libx264 -preset ultrafast \
           "$OUTPUT" &

    echo $! > "$PID_FILE"
    dunstify -i media-record "Recording started" -u low
}

stop_recording() {
    PID=$(cat "$PID_FILE")
    kill -INT "$PID"
    rm "$PID_FILE"
    dunstify -i media-record-stop "Recording stopped" "Saved to ~/Videos/" -u normal
}

if [ -f "$PID_FILE" ]; then
    stop_recording
else
    start_recording
fi
