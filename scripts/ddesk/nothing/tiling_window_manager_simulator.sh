#!/bin/bash

# --- CONFIGURATION ---
MAIN_MONITOR_X_START=0
MAIN_MONITOR_X_END=1920
DIRECTION="forward" # Default direction

# The "memory" file. Stores the ID of the last window we activated.
STATE_FILE="/tmp/window_cycler.state"

# --- SCRIPT LOGIC ---

# Check for 'reverse' argument
if [ "$1" == "reverse" ]; then
    DIRECTION="reverse"
fi

# 1. Get the current desktop's number
CURRENT_DESKTOP=$(xdotool get_desktop)

# 2. Get and filter window data
WINDOWS_DATA=$(wmctrl -lxG | awk \
    -v desk="$CURRENT_DESKTOP" \
    -v mxs="$MAIN_MONITOR_X_START" \
    -v mxe="$MAIN_MONITOR_X_END" \
    '$2==desk && $3!="-1" && $7!~ /desktop_window|Dock|dmenu|lxqt-panel|pcmanfm-desktop/ && $4>=mxs && $4<mxe {print}')

# 3. Sort the windows and create the final array of IDs
SORTED_WINDOWS=$(echo "$WINDOWS_DATA" | sort -k4 -n | awk '{print $1}')
WINDOW_ARRAY=($SORTED_WINDOWS)
NUM_WINDOWS=${#WINDOW_ARRAY[@]}

# This variable will hold the ID of the window we decide to switch to.
NEXT_WINDOW_ID=""


# --- UNIFIED CYCLING LOGIC ---

if [ "$NUM_WINDOWS" -eq 0 ]; then
    # Case 1: No windows found. Do nothing.
    exit 0

elif [ "$NUM_WINDOWS" -eq 1 ]; then
    # Case 2: Only one window exists. Just activate it.
    NEXT_WINDOW_ID="${WINDOW_ARRAY[0]}"

elif [ "$NUM_WINDOWS" -ge 2 ]; then
    # Case 3: Two or more windows. Use the state file for predictable cycling.
    
    # Read the ID from our "memory" file.
    if [ -f "$STATE_FILE" ]; then
        LAST_ACTIVATED_ID=$(cat "$STATE_FILE")
    else
        LAST_ACTIVATED_ID=""
    fi

    # Find the index of the last window we activated.
    CURRENT_INDEX=-1
    for i in "${!WINDOW_ARRAY[@]}"; do
        if [ "${WINDOW_ARRAY[$i]}" = "$LAST_ACTIVATED_ID" ]; then
            CURRENT_INDEX=$i
            break
        fi
    done

    # Calculate the next index based on our memory.
    if [ "$DIRECTION" == "forward" ]; then
        if [ "$CURRENT_INDEX" -eq -1 ]; then # If memory is invalid (e.g., window closed)
            NEXT_INDEX=0 # Start from the beginning
        else
            NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WINDOWS ))
        fi
    else # reverse
        if [ "$CURRENT_INDEX" -eq -1 ]; then
            NEXT_INDEX=$(( NUM_WINDOWS - 1 )) # Start from the end
        else
            NEXT_INDEX=$(( (CURRENT_INDEX - 1 + NUM_WINDOWS) % NUM_WINDOWS ))
        fi
    fi
    
    NEXT_WINDOW_ID="${WINDOW_ARRAY[$NEXT_INDEX]}"
fi


# --- FINAL ACTIVATION STEP ---

if [ -n "$NEXT_WINDOW_ID" ]; then
    xdotool windowactivate "$NEXT_WINDOW_ID"
    xdotool windowraise "$NEXT_WINDOW_ID"
    xdotool mousemove --window "$NEXT_WINDOW_ID" --polar 0 0

    # If we are in a cycling scenario (2+ windows), we MUST update our "memory" file.
    if [ "$NUM_WINDOWS" -ge 2 ]; then
        echo "$NEXT_WINDOW_ID" > "$STATE_FILE"
    fi
fi
