#!/bin/bash

# This script intelligently saves the last desktop number only when
# switching windows with Rofi causes a desktop change.

# 1. Define the file where we store the last desktop number.
LAST_DESKTOP_FILE="$HOME/.cache/last_desktop"

# 2. Get the desktop number we are on BEFORE running Rofi.
#    This is the number we want to save if we move.
ORIGINAL_DESKTOP=$(xdotool get_desktop)

# 3. Launch Rofi and WAIT for the user to select a window.
#    The script pauses here until Rofi closes.

# 4. IMPORTANT: Wait for a fraction of a second to give the
#    window manager time to complete the desktop switch.
#    This prevents a "race condition" where the script is too fast.
sleep 0.2
# 5. Get the desktop number we are on AFTER Rofi has finished.
CURRENT_DESKTOP=$(xdotool get_desktop)

# 6. THE LOGIC: Compare the original and current desktops.
if [ "$ORIGINAL_DESKTOP" -ne "$CURRENT_DESKTOP" ]; then
    # The desktop has changed! Save the ORIGINAL desktop number
    # so we can toggle back to it later.
    echo "$ORIGINAL_DESKTOP" > "$LAST_DESKTOP_FILE"
fi

# If the desktops are the same, the script simply ends, doing nothing.
