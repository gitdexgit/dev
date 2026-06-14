#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_sync"'; then
    i3-msg '[class="st_sync"] scratchpad show'
else
    mkdir -p ~/work
    st -c "st_sync" -t "sync" -e tmux new-session -A -s sync &
fi
