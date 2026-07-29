#!/bin/bash
if i3-msg -t get_tree | grep -q '"class":"st_btop"'; then
    i3-msg '[class="st_btop"] scratchpad show'
else
    mkdir -p ~/work
    st -c "st_btop" -t "btop" -e tmux new-session -A -s "*btop*" &
fi
