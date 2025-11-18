#!/bin/bash

# 1. Get the current desktop ID.
CURRENT_DESKTOP=$(xdotool get_desktop)

# 2. Get and format window list for Rofi
# We use awk to filter by desktop and format the output for Rofi.
WINDOWS=$(wmctrl -lx | awk -v desktop="$CURRENT_DESKTOP" '
$2 == desktop {
    win_id=$1
    app_class=$3

    # Reconstruct the title, which starts from the 5th field, to handle spaces
    title=""
    for (i=5; i<=NF; i++) {
        title = title (i==5 ? "" : " ") $i
    }
    
    # Prepare app_class for icon name (e.g., "Navigator.firefox" -> "firefox")
    sub(/.*\./, "", app_class)

    # Use printf for robust output to prevent syntax errors. The format is:
    # WIN_ID FULL_TITLE\0icon\x1fICON_NAME
    printf "%s %s\0icon\x1f%s\n", win_id, title, tolower(app_class)
}')

# 3. If no windows are found on the current desktop, exit gracefully.
if [ -z "$WINDOWS" ]; then
    exit 0
fi

# 4. Use Rofi to present the list of windows to the user.
# The user will see the WIN_ID and the title. The icon part is handled by rofi.
SELECTED=$(echo -e "$WINDOWS" | rofi -dmenu -i -p "Switch to:" -show-icons)

# 5. If the user made a selection...
if [ -n "$SELECTED" ]; then
    # 6. Extract the window ID from the selected line (it is always the first field).
    WIN_ID=$(echo "$SELECTED" | awk '{print $1}')

    # 7. Activate the selected window and wait for it to be active.
    # xdotool windowactivate --sync "$WIN_ID"

    # 8. Get the ID of the currently active window.
    ACTIVE_WIN_ID=$(xdotool getactivewindow)
    
    xdotool mousemove --window "$ACTIVE_WIN_ID" --polar 0 0

    # 9. Output the active window ID.
    echo "Active Window ID: $ACTIVE_WIN_ID"
    
    # # 10. NEW: Move the mouse to the center of the newly active window.
    # # We use the ACTIVE_WIN_ID we just retrieved to ensure we are targeting the correct window.
    # xdotool mousemove --window "$ACTIVE_WIN_ID" --polar 0 0
fi
