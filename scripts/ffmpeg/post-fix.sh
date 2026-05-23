#!/bin/bash
#
# Category: Social media:
# Discription:
# A script meant to take a video and output it to the appropriate platform aspect
# ratio to be posted on social media to share with people
#
#                                 MADE BY AI, gemni-3-flash on google ai studio

# 1. Get Path
read -p "Video path: " IN_PATH
IN_PATH="${IN_PATH/#\~/$HOME}"

# 2. Output Dir
OUT_DIR="$HOME/Videos/output"
mkdir -p "$OUT_DIR"
FILENAME=$(basename "$IN_PATH")

# 3. Prompt Platform
echo "Select Target: 1) X (16:9) 2) IG (4:5) 3) FB (1:1) 4) Custom"
read -p "> " CHOICE

case $CHOICE in
    1) TARGET="1280:720" ;;
    2) TARGET="1080:1350" ;;
    3) TARGET="1080:1080" ;;
    4) read -p "Enter W:H (e.g. 1920:1080): " TARGET ;;
    *) echo "Invalid"; exit 1 ;;
esac

# 4. Transcode
ffmpeg -i "$IN_PATH" -vf "scale=$TARGET:force_original_aspect_ratio=decrease,pad=$TARGET:(ow-iw)/2:(oh-ih)/2:color=black" -c:v libx264 -pix_fmt yuv420p -c:a aac -b:a 128k "$OUT_DIR/$FILENAME"

echo "Done: $OUT_DIR/$FILENAME"
