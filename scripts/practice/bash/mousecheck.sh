#!/bin/bash

echo "--- Mouse Position Check ---"
# Get current mouse location and the window ID under the mouse
# The 'eval' command executes the output of xdotool,
# which sets shell variables X, Y, SCREEN, WINDOW

sleep 1

echo "checking in 3.."

sleep 1
echo "checking in 2.."
sleep 1
echo "checking in 1.."
sleep 1
echo "checking in now"

eval $(xdotool getmouselocation --shell)



# Check Mouse X coordinate
if [ "${X:-1}" -eq 0 ]; then # Default to 1 if X is unset to avoid false positive with -eq 0
    echo "Mouse X matches 0 (Current X: $X)"
else
    echo "Mouse X is $X (does not match 0)"
fi

# Check Mouse Y coordinate
if [ "${Y:-1}" -eq 0 ]; then # Default to 1 if Y is unset
    echo "Mouse Y matches 0 (Current Y: $Y)"
else
    echo "Mouse Y is $Y (does not match 0)"
fi

echo # Newline for better readability
echo "--- Window Under Mouse Check ---"

# Check if the WINDOW variable is set and refers to a typical application window
# Window ID 0 and 1 are often the root window or desktop.
if [ -n "$WINDOW" ] && [ "$WINDOW" != "0" ] && [ "$WINDOW" != "1" ]; then
    echo "Info for Window ID: $WINDOW"

    # Get window title and class (suppress errors if window vanishes or properties are unreadable)
    WINDOW_TITLE=$(xdotool getwindowname "$WINDOW" 2>/dev/null || echo "[Could not get title]")
    WINDOW_CLASS=$(xdotool getwindowclassname "$WINDOW" 2>/dev/null || echo "[Could not get class]")

    echo "Window Title: $WINDOW_TITLE"
    echo "Window Class: $WINDOW_CLASS"

    # Get window geometry (position and dimensions)
    # Suppress errors in case the window is transient or uncooperative
    WINDOW_GEOMETRY_OUTPUT=$(xdotool getwindowgeometry --shell "$WINDOW" 2>/dev/null)

    if [ -n "$WINDOW_GEOMETRY_OUTPUT" ]; then
        # IMPORTANT: 'eval' will overwrite X and Y with the window's top-left coordinates.
        # WIDTH and HEIGHT will be the window's dimensions.
        eval "$WINDOW_GEOMETRY_OUTPUT"

        echo "Window Position: Top-Left X=${X}, Top-Left Y=${Y}" # These are now window's coords
        echo "Window Dimensions: Width=${WIDTH}, Height=${HEIGHT}"

        # Check window width
        if [ "${WIDTH:-0}" -gt 3000 ]; then # Default to 0 if WIDTH is unset
            echo "RESULT: Window width ($WIDTH) IS MORE than 3000."
        else
            echo "RESULT: Window width ($WIDTH) is NOT more than 3000."
        fi

        # Check window height
        if [ "${HEIGHT:-0}" -gt 999 ]; then # Default to 0 if HEIGHT is unset
            echo "RESULT: Window height ($HEIGHT) IS MORE than 999."
        else
            echo "RESULT: Window height ($HEIGHT) is NOT more than 999."
        fi
    else
        echo "Could not get geometry (width/height) for window ID: $WINDOW."
        echo "It might be a special window type (e.g., a tooltip, menu, or desktop element)."
    fi
else
    if [ -z "$WINDOW" ]; then
        echo "Mouse is not over any detectable window."
    else
        echo "Mouse is over the root window or a desktop element (Window ID: $WINDOW)."
    fi
    echo "Skipping window dimension checks as no specific application window is targeted."
fi

echo # Newline
echo "--- Check Complete ---"
