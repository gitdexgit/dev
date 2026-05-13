#!/bin/bash
TARGET="autoshot.sh"

if pgrep -f "$TARGET" > /dev/null; then
    pkill -f "$TARGET"
    dunstify -i media-record -u low "Autoshot" "⏹ Killed (Reset)"
else
    "$TARGET" &
    dunstify -i media-record -u low "Autoshot" "▶ Started"
fi
