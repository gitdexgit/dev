#!/bin/bash

# Check if the tmux session exists
if tmux has-session -t dropdown 2>/dev/null; then
    # Session exists - attach to it
    tdrop -ma -w 97% -x 3% -h 92% -y 8% ghostty -e tmux attach -t dropdown
else
    # Session doesn't exist - create a new session
    tdrop -ma -w 97% -x 3% -h 92% -y 8% ghostty -e tmux new-session -s dropdown
fi

