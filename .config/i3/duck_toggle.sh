#!/bin/bash
# Check if window exists anywhere
if i3-msg -t get_tree | grep -q '"class":"st_duck"'; then
    # Found -> Toggle (Show if hidden / Hide if visible)
    i3-msg '[class="st_duck"] scratchpad show'
else
    # Not found -> Launch
    # Ensure ~/work exists or tmux fail
    mkdir -p ~/work
    st -c "st_duck" -t "duck" -e tmux new-session -A -s duck -c ~/work &
    sleep 0.3
    i3-msg '[class="st_duck"] resize grow right 1 px'
fi
