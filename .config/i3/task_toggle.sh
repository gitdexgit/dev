#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_task"'; then
    i3-msg '[class="st_task"] scratchpad show'
else
    mkdir -p ~/work
    st -c "st_task" -t "session" -e tmux new-session -A -s session -c ~/work &
fi
