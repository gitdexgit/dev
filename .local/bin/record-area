#!/bin/bash
PID_FILE="/tmp/record-area.pid"
SCRIPT_DIR="$(dirname $(realpath $0))"
SEGMENT_DIR="/tmp/record-segments"
SEGMENT_FILE="/tmp/record-area.segment"

[ -f "$PID_FILE" ] && exit 1

GEOM=$(slop -f "%g") || exit 1
SIZE=$(echo "$GEOM" | grep -oP '^\d+x\d+')
X=$(echo "$GEOM" | grep -oP '(?<=\+)\d+' | sed -n '1p')
Y=$(echo "$GEOM" | grep -oP '(?<=\+)\d+' | sed -n '2p')

mkdir -p "$SEGMENT_DIR"
rm -f "$SEGMENT_DIR"/*.mp4
echo "0" > "$SEGMENT_FILE"

SEG="$SEGMENT_DIR/seg_0.mp4"
ffmpeg -f x11grab -s "$SIZE" -i ":0.0+${X},${Y}" \
    -c:v libx264 -preset ultrafast "$SEG" \
    > /dev/null 2>&1 &
echo $! > "$PID_FILE"
echo "$SIZE $X $Y" > /tmp/record-area.geom

setsid yad --notification \
    --image="media-record" \
    --text="Recording" \
    --command="$SCRIPT_DIR/record-pause.sh" \
    --menu="Pause/Resume!$SCRIPT_DIR/record-pause.sh|Stop!$SCRIPT_DIR/record-stop.sh" \
    > /dev/null 2>&1 &
disown $!
