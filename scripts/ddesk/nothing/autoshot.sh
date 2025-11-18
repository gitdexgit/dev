#!/bin/bash

# --- Configuration ---
SCREENSHOT_DIR='/home/dex/Pictures/Screenshots'
TMPSHOT_DIR='/home/dex/tmpshot'
SLEEP_DURATION=3

# --- JPEG Configuration ---
JPEG_QUALITY=85

# --- Monitor & Panel Configuration ---
PRIMARY_MONITOR_WIDTH=1920
PRIMARY_MONITOR_HEIGHT=1080
PANEL_HEIGHT=30

# --- Watermark Configuration ---
WATERMARK_FONT_SIZE=48
WATERMARK_TEXT_COLOR="rgba(255, 0, 0, 0.3)"
WATERMARK_STROKE_COLOR="rgba(0, 0, 0, 0.4)"
WATERMARK_PADDING=20

# NEW: Define a temporary file for the watermark overlay
# The $$ adds the process ID to make it unique
WATERMARK_TMP_FILE="/tmp/watermark_overlay_$$.png"

# NEW: Ensure the temporary file is cleaned up when the script exits
trap 'rm -f "$WATERMARK_TMP_FILE"' EXIT

# --- Initialization ---
count=1
last_hour_checked=$(date +"%H")
mkdir -p "$SCREENSHOT_DIR"
mkdir -p "$TMPSHOT_DIR"

echo "Starting JPEG screenshot service with watermarks."
echo "Interval: $SLEEP_DURATION seconds. JPEG Quality: $JPEG_QUALITY"

while true;
do
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

    # --- Take Screenshot (Unchanged) ---
    scrot --multidisp --quality $JPEG_QUALITY --silent "$FULL_PATH_FILENAME"

    # ================================================================= #
    # --- REVISED WATERMARK LOGIC (Overlay Method) ---
    # ================================================================= #

    # Step 1: Create a transparent "stamp" image the size of the primary monitor
    # with the watermark correctly placed on it.
    # The Y offset is calculated to place the text above the panel.
    WATERMARK_Y_OFFSET=$((WATERMARK_PADDING + PANEL_HEIGHT))
    convert -size "${PRIMARY_MONITOR_WIDTH}x${PRIMARY_MONITOR_HEIGHT}" xc:none \
            -gravity SouthEast \
            -pointsize $WATERMARK_FONT_SIZE \
            -fill "$WATERMARK_TEXT_COLOR" \
            -stroke "$WATERMARK_STROKE_COLOR" \
            -strokewidth 2 \
            -annotate "+${WATERMARK_PADDING}+${WATERMARK_Y_OFFSET}" "$count" \
            "$WATERMARK_TMP_FILE"

    # Step 2: Composite (overlay) the stamp onto the full screenshot at position 0,0.
    convert "$FULL_PATH_FILENAME" "$WATERMARK_TMP_FILE" \
            -geometry +0+0 \
            -composite \
            "$FULL_PATH_FILENAME"

    # ================================================================= #

    # --- Final Steps ---
    ln -s "$FULL_PATH_FILENAME" "$TMPSHOT_DIR/"

    echo "Screenshot #$count taken (JPEG). Saved to: $FULL_PATH_FILENAME"

    ((count++))

    sleep "$SLEEP_DURATION"
done
