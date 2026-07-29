#!/bin/bash
SESSION_NAME="*scratch*"

CURRENT_SESSION=$(tmux display-message -p '#{session_name}')

if [ "$CURRENT_SESSION" = "$SESSION_NAME" ]; then
    tmux detach-client
else
    # '=' forces exact match
    tmux has-session -t "=$SESSION_NAME" 2>/dev/null || tmux new-session -d -s "$SESSION_NAME"

    tmux display-popup -w 91% -h 91% -E \
        "DISPLAY='$DISPLAY' XAUTHORITY='$XAUTHORITY' WAYLAND_DISPLAY='$WAYLAND_DISPLAY' tmux attach-session -t '=$SESSION_NAME'"
fi
