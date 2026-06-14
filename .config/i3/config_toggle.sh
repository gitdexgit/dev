#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_config"'; then
    i3-msg '[class="st_config"] scratchpad show'
else
    mkdir -p ~/work
    st -c "st_config" -t "config" -e tmux new-session -A -s config &
    sleep 0.3
    i3-msg '[class="st_config"] resize grow right 1 px'
fi
