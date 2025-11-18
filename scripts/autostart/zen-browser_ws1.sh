#!/bin/bash

# --- Configuration ---
# The WM_CLASS is "Navigator.zen", based on your xprop output.
APP_CLASS="Navigator.zen"

# The exact command to launch the application.
APP_COMMAND="/opt/zen-browser-bin/zen-bin"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=0

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching Zen Browser with dedicated GPU..."
eval "$APP_COMMAND" &

# 2. Wait for the window to appear
echo "Waiting for the Zen Browser window (Class: $APP_CLASS)..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists
    if wmctrl -lx | grep -q "$APP_CLASS"; then
        echo "Zen Browser window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Zen Browser."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
    sleep 1
    sleep 1
    sleep 1
done

    sleep 1
    sleep 1
    sleep 1
# 3. Move the window to the target desktop
echo "Moving Zen Browser to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -x -r "$APP_CLASS" -t $TARGET_DESKTOP -e 0,52,86,1865,992
# wmctrl -r :ACTIVE: -e 0,1,42,1917,1036

echo "Done."
