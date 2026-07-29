#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_scratch"'; then
    i3-msg '[class="st_scratch"] scratchpad show'
else
    # mkdir -p ~/work
    st -c "st_scratch" -t "*scratch*" -e tmux new-session -A -s "*scratch*" -c ~/ &
fi
