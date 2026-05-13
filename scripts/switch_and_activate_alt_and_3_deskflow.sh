#!/bin/bash


# ----- it was an experement  ---

# --- Configuration ---

# --- Configuration for this specific check ---


# TRIGGER_MOUSE_X=2400
# TRIGGER_MOUSE_Y=480
# TRIGGER_WINDOW_WIDTH=3000
# TRIGGER_WINDOW_HEIGHT=999
# KEY_COMBINATION="alt+shift+2"

# --- End Configuration ---

# echo "Performing initial mouse and window check 3..."

# sleep 1

# echo "Performing initial mouse and window check 2..."

# sleep 1

# echo "Performing initial mouse and window check 1..."

# sleep 1

# 1. Get current mouse location and the window ID under the mouse
# Store original mouse X and Y as xdotool getwindowgeometry will overwrite X and Y
# eval $(xdotool getmouselocation --shell)
# CURRENT_MOUSE_X=${X:-1} # Default to 1 if unset to ensure -eq 0 check is specific
# CURRENT_MOUSE_Y=${Y:-1} # Default to 1 if unset
# WINDOW_UNDER_MOUSE=$WINDOW

# echo "Mouse at: X=$CURRENT_MOUSE_X, Y=$CURRENT_MOUSE_Y"
# echo "Window ID under mouse: $WINDOW_UNDER_MOUSE"

# # Initialize window dimension variables (in case no valid window is found)
# CURRENT_WINDOW_WIDTH=0
# CURRENT_WINDOW_HEIGHT=0

# 2. Check window dimensions IF a valid window is under the mouse
#    Window ID 0 and 1 are often the root window or desktop.
# if [ -n "$WINDOW_UNDER_MOUSE" ] && [ "$WINDOW_UNDER_MOUSE" != "0" ] && [ "$WINDOW_UNDER_MOUSE" != "1" ]; then
#     # Get window geometry (position and dimensions)
#     # Suppress errors in case the window is transient or uncooperative
#     WINDOW_GEOMETRY_OUTPUT=$(xdotool getwindowgeometry --shell "$WINDOW_UNDER_MOUSE" 2>/dev/null)

#     if [ -n "$WINDOW_GEOMETRY_OUTPUT" ]; then
#         # 'eval' will set X, Y (window's top-left), WIDTH, and HEIGHT
#         eval "$WINDOW_GEOMETRY_OUTPUT"
#         CURRENT_WINDOW_WIDTH=${WIDTH:-0}   # Default to 0 if WIDTH is unset
#         CURRENT_WINDOW_HEIGHT=${HEIGHT:-0} # Default to 0 if HEIGHT is unset
#         echo "Window under mouse dimensions: Width=$CURRENT_WINDOW_WIDTH, Height=$CURRENT_WINDOW_HEIGHT"
#     else
#         echo "Could not get geometry for window ID: $WINDOW_UNDER_MOUSE."
#     fi
# else
#     echo "No specific application window under mouse, or mouse is over root/desktop."
# fi

# # 3. Check all conditions
# echo "Checking conditions: "
# echo "  - Mouse X == $TRIGGER_MOUSE_X ? ($CURRENT_MOUSE_X)"
# echo "  - Mouse Y == $TRIGGER_MOUSE_Y ? ($CURRENT_MOUSE_Y)"
# echo "  - Window Width > $TRIGGER_WINDOW_WIDTH ? ($CURRENT_WINDOW_WIDTH)"
# echo "  - Window Height > $TRIGGER_WINDOW_HEIGHT ? ($CURRENT_WINDOW_HEIGHT)"

# if [ "$CURRENT_MOUSE_X" -gt "$TRIGGER_MOUSE_X" ] && \
#    [ "$CURRENT_MOUSE_Y" -gt "$TRIGGER_MOUSE_Y" ] && \
#    [ "$CURRENT_WINDOW_WIDTH" -gt "$TRIGGER_WINDOW_WIDTH" ] && \
#    [ "$CURRENT_WINDOW_HEIGHT" -gt "$TRIGGER_WINDOW_HEIGHT" ]; then

#     echo "All conditions MET. Sending keys '$KEY_COMBINATION' and exiting."
#     xdotool key "$KEY_COMBINATION"
#     exit 0 # Exit the entire script
# else
#     echo "Conditions NOT met. Continuing with the rest of the script..."
#     echo # Add a blank line for separation
# fi

# # ----------------------------------------------------
# # --- PUT THE REST OF YOUR OTHER SCRIPT CODE BELOW ---
# # ----------------------------------------------------

# echo "This is the rest of your script executing."
# # Example:
# # ls -la
# # echo "Done."


# ----- it was an experement END ---

TARGET_WINDOW_NAME="kali on QEMU/KVM"


# --- Functions ---
die() { echo "Error: $*" >&2; exit 1; }

get_primary_position() {
    xrandr | awk '/ connected.*primary/ {
        split($4, pos, "+")
        print pos[2], pos[3]
        exit
    }'
}

# --- Main Execution ---

# 1. Find window
WINDOW_ID=$(xdotool search --sync --name "$TARGET_WINDOW_NAME" 2>/dev/null | head -n1)
[ -n "$WINDOW_ID" ] || die "Window not found"

# 2. Get position
read X Y < <(get_primary_position)
[ -n "$X" ] || die "Could not get monitor position"

# 3. Move and prepare window
(
    xdotool set_desktop_for_window "$WINDOW_ID" $(xdotool get_desktop)
    xdotool windowstate "$WINDOW_ID" remove fullscreen maximized_vert maximized_horz
    xdotool windowmove --sync "$WINDOW_ID" "$X" "$Y"
    # xdotool windowactivate --sync "$WINDOW_ID"
) 2>/dev/null

# 4. Set fullscreen and send keys
# (
#     xdotool windowstate "$WINDOW_ID" add fullscreen
#     # xdotool windowactivate --sync "$WINDOW_ID"
# ) 2>/dev/null

# sleep 0.1
xdotool key alt+ctrl+shift+3

exit 0
