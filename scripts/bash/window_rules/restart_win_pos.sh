#!/bin/bash

# ==============================================================================
# = The Ultimate Openbox Workspace Arrangement Script                          =
# ==============================================================================
#
# This script finds predefined windows by title or class and arranges them
# into a fixed layout. This is intended to be bound to a single hotkey.
#

# --- Define Layout Geometries (Gravity,X,Y,Width,Height) ---
GEOMETRY_MAIN="0,1920,220,1364,732"
GEOMETRY_MEDIUM="0,2532,545,752,407"
GEOMETRY_MINI="0,2733,548,749,403"

# --- Helper function to find a window by its TITLE and arrange it ---
arrange_by_title() {
    local title="$1"
    local geometry="$2"
    local make_sticky="$3" # Expects "yes" or "no"

    # Use grep -F to treat the title as a fixed string (safer).
    # head -n 1 ensures we only act on the first match.
    local WINDOW_ID=$(wmctrl -l | grep -F -- "$title" | awk '{print $1}' | head -n 1)
    
    if [ -n "$WINDOW_ID" ]; then
        echo "Positioning by Title: $title"
        wmctrl -i -r "$WINDOW_ID" -e "$geometry"
        
        # Only make the window "sticky" if requested
        if [ "$make_sticky" == "yes" ]; then
            xdotool set_desktop_for_window "$WINDOW_ID" -1
        fi
    fi
}

# --- Helper function to find a window by its CLASS and arrange it ---
arrange_by_class() {
    local class="$1"
    local geometry="$2"

    # wmctrl -lx lists class in column 3 (e.g., sublime_text.Sublime_text)
    local WINDOW_ID=$(wmctrl -lx | awk -v id="$class" '$3 == id {print $1; exit}')
    
    if [ -n "$WINDOW_ID" ]; then
        echo "Positioning by Class: $class"
        wmctrl -i -r "$WINDOW_ID" -e "$geometry"
        xdotool set_desktop_for_window "$WINDOW_ID" -1
    fi
}

# --- Main Execution Logic ---
echo "Arranging workspace..."

# 1. Arrange main windows by title prefix (and make them sticky)
for prefix in "_a_" "_f_" "_l_" "_j_"; do
    arrange_by_title "$prefix" "$GEOMETRY_MAIN" "yes"
done

# 2. Arrange main applications by class (and make them sticky)
arrange_by_class "sublime_text.Sublime_text" "$GEOMETRY_MAIN"
arrange_by_class "copyq.copyq" "0,1922,220,1362,732"
# for some reaosn keepassxc cannot be moved
# arrange_by_class "KeePassXC" "$GEOMETRY_MAIN"

# 3. Arrange medium and mini windows (and make them sticky)
arrange_by_title "_m_" "0,1922,541,1363,412" "yes"
arrange_by_title "_mi_" "$GEOMETRY_MINI" "yes"
arrange_by_title "_tmux_" "$GEOMETRY_MAIN" "yes"

# 4. Arrange "DesktopSwitch Settings" (and DO NOT make it sticky)
arrange_by_title "Recent - Thunar" "0,1922,207,1361,718" "yes"
arrange_by_title "Virtual Machine Manager" "0,2606,220,678,731" "yes"
# for some reaosn keepassxc cannot be moved
# arrange_by_title "KeePassXC" "0,2606,220,678,731" "yes"
wmctrl -x -r keepassxc.KeePassXC -e 0,1921,220,1364,732
arrange_by_title "DesktopSwitch Settings" "0,1921,-313,279,1310" "yes"
arrange_by_title "Artha" "0,1922,221,737,730" "yes"
arrange_by_title "Kazam" "0,2419,395,370,292" "yes"

echo "Arrangement complete."
