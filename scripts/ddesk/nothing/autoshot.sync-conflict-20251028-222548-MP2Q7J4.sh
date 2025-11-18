#!/bin/bash

# The main directory where screenshots will be temporarily saved.
SCREENSHOT_DIR='/home/dex/Pictures/Screenshots/'

# A counter to keep track of how many screenshots have been taken (minutes).
count=0
WEEK=$(date +"W%V")
# Ensure the main screenshot directory exists.
mkdir -p "$SCREENSHOT_DIR"


echo "Starting hierarchical screenshot service."
echo "Screenshots will be archived into daily and hourly folders."

while true; do
    # Take a screenshot of all connected displays and save it to the main directory.
	scrot --multidisp --silent "$SCREENSHOT_DIR"screenshot_"$WEEK"_%Y-%m-%d_%H-%M-%S.png

    # Increment the counter.
    ((count++))
    
    echo "Screenshot #$count taken. Next one in 1 minute."

    # Check if 60 minutes have passed.
    if [ "$count" -ge 240 ]; then
        echo "One hour has passed. Archiving screenshots..."
        WEEK=$(date "+%V")

        # --- NEW HIERARCHICAL LOGIC ---

        # 1. Define the names for the day and hour folders.
        TODAYS_FOLDER_NAME=$(date +"W%V_%Y-%m-%d")      # e.g., "2025-09-16"
        HOURLY_FOLDER_NAME="hour_$(date +"%H")"     # e.g., "hour_10"

        # 2. Define the full, final path for the archive.
        #    This will look like: /home/dex/Pictures/Screenshots/2025-09-16/hour_10
        FINAL_ARCHIVE_PATH="$SCREENSHOT_DIR/$TODAYS_FOLDER_NAME/$HOURLY_FOLDER_NAME"
        # 3. Create the entire directory structure (e.g., create both the day and hour folder if they don't exist).
        #    The '-p' flag is essential here as it creates parent directories as needed.
        mkdir -p "$FINAL_ARCHIVE_PATH"
        
        # This option makes the script not complain if there are no .png files to move.
        shopt -s nullglob

        # 4. Move all the loose .png files from the main screenshot directory into the final hourly folder.
        mv "$SCREENSHOT_DIR"*.png "$FINAL_ARCHIVE_PATH/"
        
        echo "Successfully moved screenshots to: $FINAL_ARCHIVE_PATH"

        # 5. Reset the counter back to 0 for the next hour.
        count=0
    fi

    # Wait for 1 minute before the next loop.
	sleep 15s

done
