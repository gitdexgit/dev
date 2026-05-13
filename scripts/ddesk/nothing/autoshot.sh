#!/bin/bash
# --- Configuration ---
SCREENSHOT_DIR='/home/dex/Pictures/Screenshots'
TMPSHOT_DIR='/home/dex/tmpshot'
SLEEP_DURATION=1
# --- JPEG Configuration ---
JPEG_QUALITY=85
# --- Monitor & Panel Configuration ---
PRIMARY_MONITOR_WIDTH=1440
PRIMARY_MONITOR_HEIGHT=900
PANEL_HEIGHT=30
# --- Watermark Configuration ---
WATERMARK_FONT_SIZE=48
WATERMARK_TEXT_COLOR="rgba(255, 0, 0, 0.3)"
WATERMARK_STROKE_COLOR="rgba(0, 0, 0, 0.4)"
WATERMARK_PADDING=20
WATERMARK_TMP_FILE="/tmp/watermark_overlay_$$.png"
trap 'rm -f "$WATERMARK_TMP_FILE"' EXIT
# --- Initialization ---
count=1
last_hour_checked=$(date +"%H")
mkdir -p "$SCREENSHOT_DIR"
mkdir -p "$TMPSHOT_DIR"
echo "Starting JPEG screenshot service with watermarks."
echo "Interval: $SLEEP_DURATION seconds. JPEG Quality: $JPEG_QUALITY"
while true; do
    # --- Check for New Hour to Reset Counter ---
    current_hour=$(date +"%H")
    if [ "$current_hour" != "$last_hour_checked" ]; then
        echo "-----------------------------------------------------"
        echo "New hour ($current_hour) detected. Resetting screenshot counter to 1."
        echo "-----------------------------------------------------"
        count=1
        last_hour_checked=$current_hour
    fi
    # --- Define Paths and Filename ---
    WEEK=$(date +"%V")
    TODAYS_FOLDER_NAME="W${WEEK}_$(date +"%Y-%m-%d-%A")"
    HOURL_FOLDER_NAME="hour_${current_hour}"
    FINAL_ARCHIVE_PATH="$SCREENSHOT_DIR/$TODAYS_FOLDER_NAME/$HOURL_FOLDER_NAME"
    mkdir -p "$FINAL_ARCHIVE_PATH"
    SCREENSHOT_FILENAME="screenshot_W$(date +"%V_%Y-%m-%d_%H-%M-%S").jpg"
    FULL_PATH_FILENAME="$FINAL_ARCHIVE_PATH/$SCREENSHOT_FILENAME"
    # --- Take Screenshot ---
    # FIX 1: --monitor 0 is the primary display (HDMI-1). You only have one active monitor.
    scrot --monitor 0 --quality $JPEG_QUALITY --silent "$FULL_PATH_FILENAME"
    # --- Wait for file to exist before compositing (race condition fix) ---
    timeout 5 bash -c "until [ -f '$FULL_PATH_FILENAME' ]; do sleep 0.1; done"
    if [ ! -f "$FULL_PATH_FILENAME" ]; then
        echo "ERROR: Screenshot file not created: $FULL_PATH_FILENAME"
        ((count++))
        sleep "$SLEEP_DURATION"
        continue
    fi
    # --- Watermark Logic ---
    WATERMARK_Y_OFFSET=$((WATERMARK_PADDING + PANEL_HEIGHT))
    # FIX 2: Use 'magick' instead of deprecated 'convert' (ImageMagick v7)
    magick -size "${PRIMARY_MONITOR_WIDTH}x${PRIMARY_MONITOR_HEIGHT}" xc:none \
        -gravity SouthEast \
        -pointsize $WATERMARK_FONT_SIZE \
        -fill "$WATERMARK_TEXT_COLOR" \
        -stroke "$WATERMARK_STROKE_COLOR" \
        -strokewidth 2 \
        -annotate "+${WATERMARK_PADDING}+${WATERMARK_Y_OFFSET}" "$count" \
        "$WATERMARK_TMP_FILE"
    magick "$FULL_PATH_FILENAME" "$WATERMARK_TMP_FILE" \
        -geometry +0+0 \
        -composite \
        "$FULL_PATH_FILENAME"
    # --- Final Steps ---
    ln -sf "$FULL_PATH_FILENAME" "$TMPSHOT_DIR/"
    echo "Screenshot #$count taken (JPEG). Saved to: $FULL_PATH_FILENAME"
    ((count++))
    sleep "$SLEEP_DURATION"
done
