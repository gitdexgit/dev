#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_learn"'; then
    i3-msg '[class="st_learn"] scratchpad show'
else
    mkdir -p ~/learn
    st -c "st_learn" -t "learn" -e tmux new-session -A -s learn &
    sleep 0.3
    i3-msg '[class="st_learn"] resize grow right 1 px'
fi
