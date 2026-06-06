#!/bin/bash
PID_FILE="/tmp/record-area.pid"
PAUSE_FILE="/tmp/record-area.paused"
SEGMENT_FILE="/tmp/record-area.segment"
SEGMENT_DIR="/tmp/record-segments"
SCRIPT_DIR="$(dirname $(realpath $0))"

[ -f "$PID_FILE" ] || exit 1

if [ -f "$PAUSE_FILE" ]; then
    # Resume — start new segment
    SEG_N=$(cat "$SEGMENT_FILE")
    SEG_N=$((SEG_N + 1))
    echo "$SEG_N" > "$SEGMENT_FILE"

    GEOM=$(cat /tmp/record-area.geom)
    SIZE=$(echo "$GEOM" | awk '{print $1}')
    X=$(echo "$GEOM" | awk '{print $2}')
    Y=$(echo "$GEOM" | awk '{print $3}')

    SEG="$SEGMENT_DIR/seg_${SEG_N}.mp4"
    ffmpeg -f x11grab -s "$SIZE" -i ":0.0+${X},${Y}" \
        -c:v libx264 -preset ultrafast "$SEG" \
        > /dev/null 2>&1 &
    echo $! > "$PID_FILE"
    rm -f "$PAUSE_FILE"

    pkill -f "yad --notification"
    sleep 0.2
    setsid yad --notification \
        --image="media-record" \
        --text="Recording" \
        --command="$SCRIPT_DIR/record-pause.sh" \
        --menu="Pause/Resume!$SCRIPT_DIR/record-pause.sh|Stop!$SCRIPT_DIR/record-stop.sh" \
        > /dev/null 2>&1 &
    disown $!
else
    # Pause — kill current ffmpeg segment
    kill -INT "$(cat $PID_FILE)" 2>/dev/null
    sleep 0.5
    touch "$PAUSE_FILE"

    pkill -f "yad --notification"
    sleep 0.2
    setsid yad --notification \
        --image="media-playback-pause" \
        --text="Paused" \
        --command="$SCRIPT_DIR/record-pause.sh" \
        --menu="Pause/Resume!$SCRIPT_DIR/record-pause.sh|Stop!$SCRIPT_DIR/record-stop.sh" \
        > /dev/null 2>&1 &
    disown $!
fi
