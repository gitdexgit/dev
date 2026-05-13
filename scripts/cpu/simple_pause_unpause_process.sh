#!/bin/bash
# status: [not working] [got alternatives] [xcontrol and xkill] [control+alt+z/c]


# ======================= this was an old attempt instead of ahving control + alt + z and c why not make them a toggle
# could be useful but for now it's not working
#
#
#







# pause-toggle.sh
# A script to pause and resume an application by clicking on its window.
# It acts as a toggle: run once to pause, run again to resume.
#

# Exit immediately if a command exits with a non-zero status.
set -e

# This file will store the PID of the paused process.
# Its existence tells the script we are in "resume mode".
PID_FILE="/tmp/paused_process.txt"

# --- Main Logic ---

# Check if the PID file exists. If it does, we need to RESUME.
if [ -f "$PID_FILE" ]; then
    
    # --- RESUME LOGIC ---
    
    # Read the PID from the file. We know exactly which process to target.
    PID=$(cat "$PID_FILE")

    # Check if the PID is valid and the process is still running.
    # The process might have been closed while it was paused.
    if [ -n "$PID" ] && ps -p "$PID" > /dev/null; then
        echo "Found paused process. Resuming PID: $PID"
        
        # Send the "continue" signal to the entire process group.
        # This ensures all related windows/tabs of the app also resume.
        kill -CONT -- "-$PID"
        
        # IMPORTANT: Remove the file so the next run will be a "pause" action.
        rm "$PID_FILE"
        echo "Process resumed successfully."
    else
        echo "Error: The paused process (PID: $PID) is no longer running."
        echo "Removing stale PID file."
        rm "$PID_FILE"
        exit 1
    fi

else

    # --- PAUSE LOGIC ---
    
    echo "Please click on the window you want to pause..."
    
    # Use xdotool to get the window ID from the user's click.

    
    WINDOW_ID=$(xdotool selectwindow)
    
    # If the user cancelled (e.g., by pressing Esc), xdotool returns nothing.
    if [ -z "$WINDOW_ID" ]; then
        echo "No window selected. Aborting."
        exit 1
    fi
    
    # Initialize the PID variable as empty.
    PID=""

    # --- PID Discovery Method 1: The Best Way (_NET_WM_PID) ---
    # We ask the window directly for its Process ID. This is the most reliable method.
    FOUND_PID=$(xprop -id "$WINDOW_ID" _NET_WM_PID 2>/dev/null | awk '{print $3}')

    # Check if the result is a valid number.
    if [[ "$FOUND_PID" =~ ^[0-9]+$ ]]; then
        echo "INFO: Found PID $FOUND_PID using the reliable _NET_WM_PID method."
        PID="$FOUND_PID"
    fi

    # --- PID Discovery Method 2: The Fallback (WM_CLASS) ---
    # This runs only if the first method failed (e.g., for apps like Zen Browser).
    if [ -z "$PID" ]; then
        echo "INFO: _NET_WM_PID not found. Falling back to using the window's class name."
        # Get the class name (e.g., "zen" or "Navigator") from the window properties.
        CLASS_NAME=$(xprop -id "$WINDOW_ID" WM_CLASS 2>/dev/null | awk -F '"' '{print $4}')

        if [ -n "$CLASS_NAME" ]; then
            echo "INFO: Searching for a process matching class name: '$CLASS_NAME'"
            # Find the first process that matches the class name.
            PID=$(pgrep -if "$CLASS_NAME" | head -n 1)
        fi
    fi
    
    # --- Execute the Pause Action ---
    # Check if we successfully found a valid, running PID.
    if [ -n "$PID" ] && ps -p "$PID" > /dev/null; then
        echo "Successfully found PID: $PID. Pausing the process group..."
        
        # Send the "stop" signal to the entire process group.
        kill -STOP -- "-$PID"
        
        # IMPORTANT: Save the PID to our file so we know what to resume next time.
        echo "$PID" > "$PID_FILE"
        echo "Process paused. Run this script again to resume."
    else
        echo "ERROR: Could not find a running process for the selected window."
        echo "Please try again and be sure to click directly on the application window itself."
        exit 1
    fi
fi
