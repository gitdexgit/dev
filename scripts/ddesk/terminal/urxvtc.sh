#!/bin/bash

# 1. Warm up the daemon if it's not running (Essential for speed)
if ! pgrep -u "$USER" urxvtd >/dev/null; then
    urxvtd -q -f -o
fi

# 2. Optimized tdrop command
# -n: The window name (instance) stays "dropdown_terminal" so tdrop identifies it correctly
# -s main: This tells tmux to create or attach to the session named 'main'
# -A: This is the "magic" flag that attaches if 'main' exists, or creates it if it doesn't.
CMD='urxvtc -name "dropdown_terminal" -e tmux new-session -A -s main'

tdrop -ma -w 90% -h 85% -x 5% -y 4% -n "dropdown_terminal" $CMD
