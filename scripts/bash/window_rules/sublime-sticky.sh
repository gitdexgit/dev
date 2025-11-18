#!/bin/bash





# Set the path to your Sublime Text executable (as discovered by 'which subl')
SUBLIME_PATH="/usr/bin/subl"

# Launch Sublime Text in the background, passing all arguments
"$SUBLIME_PATH" "$@" &

# --- Robustly find the window and make it sticky ---

# We will poll for up to 5 seconds for the window to appear.
# This is much more reliable than a fixed 'sleep'.
for _ in {1..20}; do
    # Search for a window using its class, which is always "Sublime_text".
    # 'tail -1' gets the most recently created one if there are multiple.
    WINDOW_ID=$(xdotool search --class "Sublime_text" | tail -1)
    
    # If we found an ID, we're done polling.
    [ -n "$WINDOW_ID" ] && break
    
    # Otherwise, wait a moment and try again.
    sleep 0.25
done

# If a window ID was successfully found, set it to appear on all desktops.
# The desktop number '-1' is the special value for "all desktops".
if [ -n "$WINDOW_ID" ]; then
    xdotool set_desktop_for_window "$WINDOW_ID" -1
fi
