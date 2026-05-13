#!/bin/bash

# Function to check if we are running i3
is_i3() {
    # Check if i3-msg exists and if it can successfully communicate with i3
    command -v i3-msg >/dev/null && i3-msg -t get_version >/dev/null 2>&1
}

if is_i3; then
    # ============================================================
    # i3wm STRATEGY: Use internal Marks
    # ============================================================
    MARK_NAME="hidden_from_switcher"

    # Check if the focused window already has the mark using jq
    if i3-msg -t get_tree | jq -e ".. | select(.focused? == true and (.marks | contains([\"$MARK_NAME\"])))" > /dev/null; then
        i3-msg unmark "$MARK_NAME"
        notify-send "i3: Window Visible" "Removed $MARK_NAME mark."
    else
        i3-msg mark "$MARK_NAME"
        notify-send "i3: Window Hidden" "Added $MARK_NAME mark. (Hidden from custom Rofi)"
    fi

else
    # ============================================================
    # GENERIC WM STRATEGY: Use EWMH skip_taskbar (Openbox, Xfce, etc)
    # ============================================================

    # Get the ID of the currently active window
    ACTIVE_WIN_ID=$(xdotool getactivewindow)

    if [ -z "$ACTIVE_WIN_ID" ]; then
        notify-send "Error" "Could not get active window ID"
        exit 1
    fi

    # Check if the window already has the "skip_taskbar" property
    if xprop -id "$ACTIVE_WIN_ID" _NET_WM_STATE | grep -q "_NET_WM_STATE_SKIP_TASKBAR"; then
        # Remove the property to unhide it
        wmctrl -i -r "$ACTIVE_WIN_ID" -b remove,skip_taskbar
        notify-send "WM: Window Visible" "Removed skip_taskbar property."
    else
        # Add the property to hide it
        wmctrl -i -r "$ACTIVE_WIN_ID" -b add,skip_taskbar
        notify-send "WM: Window Hidden" "Added skip_taskbar property."
    fi
fi
