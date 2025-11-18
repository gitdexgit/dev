#!/bin/bash

# ~/.local/scripts/tmux-scratchpad.sh

SESSION_NAME="_scratchpad"

# Check if the scratchpad session exists. If not, create it detached.
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux new-session -d -s "$SESSION_NAME"
fi

# Attach to the session within a popup.
# When you press Esc, this popup will close, but the session remains.
# NEW LINE (Large & Centered)
tmux display-popup -w 91% -h 91% -E "tmux attach-session -t $SESSION_NAME"
