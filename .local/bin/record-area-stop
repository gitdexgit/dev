#!/bin/bash
PID_FILE="/tmp/record-area.pid"
PAUSE_FILE="/tmp/record-area.paused"
SEGMENT_DIR="/tmp/record-segments"
OUTPUT="$HOME/Videos/record_$(date +%s).mp4"

[ -f "$PID_FILE" ] || exit 1

# Stop ffmpeg if still running
kill -INT "$(cat $PID_FILE)" 2>/dev/null
sleep 0.5
pkill -f "yad --notification" 2>/dev/null

# Concat all segments
CONCAT_FILE="/tmp/record-concat.txt"
ls "$SEGMENT_DIR"/seg_*.mp4 | sort -V | while read f; do
    echo "file '$f'"
done > "$CONCAT_FILE"

SEG_COUNT=$(wc -l < "$CONCAT_FILE")
if [ "$SEG_COUNT" -gt 1 ]; then
    ffmpeg -f concat -safe 0 -i "$CONCAT_FILE" -c copy "$OUTPUT" > /dev/null 2>&1
else
    # Single segment, just move it
    mv "$SEGMENT_DIR/seg_0.mp4" "$OUTPUT"
fi

rm -f "$PID_FILE" "$PAUSE_FILE" "$CONCAT_FILE" /tmp/record-area.geom /tmp/record-area.segment
rm -rf "$SEGMENT_DIR"

dunstify -i media-record-stop "Recording stopped" "Saved to ~/Videos/" -u normal
