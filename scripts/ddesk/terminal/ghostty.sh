#!/bin/bash

# Check if the tmux session exists
if tmux has-session -t dropdown 2>/dev/null; then
    # Session exists - attach to it
    tdrop -ma -w 100% -h 95% ghostty -e tmux attach -t dropdown
else
    # Session doesn't exist - create a new session
    tdrop -ma -w 100% -h 95% ghostty -e tmux attach -t dropdown
fi

