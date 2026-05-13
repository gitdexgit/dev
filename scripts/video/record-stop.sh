#!/bin/bash

PID_FILE="/tmp/record-area.pid"
PAUSE_FILE="/tmp/record-area.paused"

if [ ! -f "$PID_FILE" ]; then
    dunstify -i dialog-warning "Record" "No active recording" -u low
    exit 1
fi

PID=$(cat "$PID_FILE")
kill -INT "$PID"
rm -f "$PID_FILE" "$PAUSE_FILE"
dunstify -i media-record-stop "Recording stopped" "Saved to ~/Videos/" -u normal
