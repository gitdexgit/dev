#!/bin/bash

# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_CLASS="code-oss.code-oss"

# The command to launch the application.
APP_COMMAND="code"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=13

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching Obsidian..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_CLASS"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -x -r "$APP_CLASS" -t $TARGET_DESKTOP

echo "Done."
