#!/bin/bash

PID_FILE="/tmp/record-area.pid"

if [ ! -f "$PID_FILE" ]; then
    dunstify -i dialog-warning "Record" "No active recording" -u low
    exit 1
fi

PID=$(cat "$PID_FILE")
PAUSE_FILE="/tmp/record-area.paused"

if [ -f "$PAUSE_FILE" ]; then
    kill -CONT "$PID"
    rm "$PAUSE_FILE"
    dunstify -i media-playback-start "Recording resumed" "" -u low
else
    kill -STOP "$PID"
    touch "$PAUSE_FILE"
    dunstify -i media-playback-pause "Recording paused" "" -u low
fi
