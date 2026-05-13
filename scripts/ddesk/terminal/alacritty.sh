#!/bin/bash

# We use -n "dropdown_terminal" so tdrop knows which specific window to manage
# We use --class "dropdown_terminal" so the Window Manager can identify it
if tmux has-session -t dropdown 2>/dev/null; then
    tdrop -ma -w 90% -h 85% -x 5% -y 4% -n "dropdown_terminal" alacritty --class "dropdown_terminal" -e tmux attach -t dropdown
else
    tdrop -ma -w 90% -h 85% -x 5% -y 4% -n "dropdown_terminal" alacritty --class "dropdown_terminal" -e tmux new-session -s dropdown
fi
