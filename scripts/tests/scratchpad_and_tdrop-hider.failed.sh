#!/usr/bin/env bash
# scratchpad-hide.sh — mass/smart scratchpad hiding for i3
# Usage: scratchpad-hide.sh hide      → hide focused window (if it's a visible scratchpad)
#        scratchpad-hide.sh hide-all  → hide ALL currently visible scratchpad windows

tree=$(i3-msg -t get_tree)

# Is the focused window a scratchpad that is currently VISIBLE?
# scratchpad_state == "changed" means: it's a scratchpad AND it's shown on screen.
focused_scratch_state=$(echo "$tree" | jq -r '
  .. | select(.focused? == true) | .scratchpad_state // "none"
')

# --- FUNCTION 1: hide_current ---
# Hides the focused window only if it is a visible scratchpad.
hide_current() {
    if [[ "$focused_scratch_state" == "changed" ]]; then
        i3-msg "move scratchpad"
    else
        # Not a scratchpad window — do nothing (or log for debugging)
        echo "Focused window is not a visible scratchpad (state: $focused_scratch_state)" >&2
    fi
}

# --- FUNCTION 2: hide_all ---
# Hides ALL currently visible scratchpad windows in one shot.
# [scratchpad_state="changed"] targets only visible scratchpads — not hidden ones.
hide_all() {
    i3-msg '[scratchpad_state="changed"] move scratchpad'
}

case "$1" in
    "hide")     hide_current ;;
    "hide-all") hide_all ;;
    *)          echo "Usage: $0 {hide|hide-all}" >&2; exit 1 ;;
esac
