#!/bin/bash

# This script cycles through all windows of the same class as the active window.
# It can cycle both forward and in reverse.

# --- CONFIGURATION ---
# The "memory" file stores the last-used window class to enable smart cycling.
STATE_FILE="/tmp/class_cycler.state"
DIRECTION="forward"

# --- VALIDATION ---
# 1. Ensure necessary tools are installed before proceeding.
if ! command -v wmctrl &> /dev/null || ! command -v xdotool &> /dev/null; then
    echo "Error: Please install 'wmctrl' and 'xdotool' to use this script." >&2
    exit 1
fi

# 2. Handle the 'reverse' argument to determine cycling direction.
if [ "$1" == "reverse" ]; then
    DIRECTION="reverse"
fi

# --- SCRIPT LOGIC ---

# 3. Get the active window's ID and its class.
ACTIVE_WINDOW_ID=$(xdotool getactivewindow)
if [ -z "$ACTIVE_WINDOW_ID" ]; then
    # Exit if there's no active window.
    exit 0
fi

# Convert the ID to the hexadecimal format used by wmctrl.
ACTIVE_WINDOW_HEX_ID=$(printf "0x%08x" "$ACTIVE_WINDOW_ID")

# Get the class of the active window.
CURRENT_CLASS=$(wmctrl -lx | awk -v id="$ACTIVE_WINDOW_HEX_ID" '$1==id {print $3}')

# Exit if the window has no class or is the desktop itself.
if [ -z "$CURRENT_CLASS" ] || [[ "$CURRENT_CLASS" == *".pcmanfm-desktop"* ]] || [[ "$CURRENT_CLASS" == *"kdesktop"* ]]; then
    exit 0
fi

# 4. Smart Reset: If we switch to a new application, reset the cycle memory.
if [ -f "$STATE_FILE" ]; then
    # Read the first line of the state file to get the last known class.
    LAST_CLASS=$(head -n 1 "$STATE_FILE" 2>/dev/null)
    if [ "$CURRENT_CLASS" != "$LAST_CLASS" ]; then
        # If the class has changed, remove the old state file.
        rm -f "$STATE_FILE"
    fi
fi

# 5. Find all windows matching the current class.
# The window list is fetched from bottom to top.
WINDOW_IDS=($(wmctrl -lx | awk -v class="$CURRENT_CLASS" '$3==class {print $1}'))
NUM_WINDOWS=${#WINDOW_IDS[@]}

# If there's only one window (or none), there's nothing to cycle to.
if [ "$NUM_WINDOWS" -le 1 ]; then
    exit 0
fi

# 6. Stateful Cycling Logic (using the memory file)
LAST_ACTIVATED_ID=""
if [ -f "$STATE_FILE" ]; then
    # Get the ID of the last window we cycled to from the state file.
    LAST_ACTIVATED_ID=$(tail -n 1 "$STATE_FILE" 2>/dev/null)
fi

CURRENT_INDEX=-1
# Find the index of the last activated window in our current list.
for i in "${!WINDOW_IDS[@]}"; do
    if [ "${WINDOW_IDS[$i]}" == "$LAST_ACTIVATED_ID" ]; then
        CURRENT_INDEX=$i
        break
    fi
done

# If the last activated window wasn't found (e.g., it was closed),
# fall back to using the currently active window as the starting point.
if [ "$CURRENT_INDEX" -eq -1 ]; then
    for i in "${!WINDOW_IDS[@]}"; do
        if [ "${WINDOW_IDS[$i]}" == "$ACTIVE_WINDOW_HEX_ID" ]; then
            CURRENT_INDEX=$i
            break
        fi
    done
fi

# If we're still without a valid index (which should be rare), default to the first window.
if [ "$CURRENT_INDEX" -eq -1 ]; then
    CURRENT_INDEX=0
fi

# 7. Calculate the index of the next window to activate.
if [ "$DIRECTION" == "forward" ]; then
    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WINDOWS ))
else # reverse
    NEXT_INDEX=$(( (CURRENT_INDEX - 1 + NUM_WINDOWS) % NUM_WINDOWS ))
fi

NEXT_WINDOW_HEX_ID="${WINDOW_IDS[$NEXT_INDEX]}"

# 8. Activate the new window, move the mouse, and update our memory file.
if [ -n "$NEXT_WINDOW_HEX_ID" ]; then
    # CRITICAL: xdotool needs decimal IDs, but wmctrl gives hex. We must convert.
    DECIMAL_ID=$(printf "%d" "$NEXT_WINDOW_HEX_ID")

    # Activate the window and move the mouse to its center.
    xdotool windowactivate "$DECIMAL_ID"
    xdotool windowraise "$DECIMAL_ID"
    xdotool mousemove --window "$DECIMAL_ID" --polar 0 0

    # Write the current class and the newly activated window's ID to our state file.
    # This robust state management is crucial for the "smart reset" feature.
    echo "$CURRENT_CLASS" > "$STATE_FILE"
    echo "$NEXT_WINDOW_HEX_ID" >> "$STATE_FILE"
fi
