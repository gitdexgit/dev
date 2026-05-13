#!/bin/bash



a_lockfile="/tmp/keyd_window_is_moving.lock"

a_move_command="/home/dex/scripts/ddesk/nothing/capslock_movewindow_to_mouse_pos"


touch "$a_lockfile"


while [[ -f $a_lockfile ]]; do

    $a_move_command
    sleep 0.02
done
