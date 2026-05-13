#!/bin/bash

# Check if the tmux session exists
if tmux has-session -t dropdown 2>/dev/null; then
    # Session exists - attach to it
    tdrop -ma -w 99% -x "4" -h 95% kitty
else
    # Session doesn't exist - create a new session
    tdrop -ma -w 99% -x "4" -h 95% kitty
fi
