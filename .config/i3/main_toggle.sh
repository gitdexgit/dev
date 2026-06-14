#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_main"'; then
    i3-msg '[class="st_main"] scratchpad show'
else
    mkdir -p ~/work
    st -c "st_main" -t "main" -e tmux new-session -A -s main &
    sleep 0.3
    i3-msg '[class="st_main"] resize grow right 1 px'
fi
