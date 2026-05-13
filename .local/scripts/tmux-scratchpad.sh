#!/bin/bash
SESSION_NAME="_scratchpad"

# 1. Get the current session name
CURRENT_SESSION=$(tmux display-message -p '#{session_name}')

if [ "$CURRENT_SESSION" = "$SESSION_NAME" ]; then
    tmux detach-client
else
    # 2. Ensure session exists
    if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        tmux new-session -d -s "$SESSION_NAME"
    fi

    # 3. Capture current environment variables
    # We pass them directly into the attach command so the popup-shell has them.
    CUR_DISPLAY=$DISPLAY
    CUR_XAUTH=$XAUTHORITY
    CUR_WAYLAND=$WAYLAND_DISPLAY

    # 4. Launch popup with explicit environment injection
    tmux display-popup -w 91% -h 91% -E \
        "DISPLAY=$CUR_DISPLAY XAUTHORITY=$CUR_XAUTH WAYLAND_DISPLAY=$CUR_WAYLAND tmux attach-session -t $SESSION_NAME"
fi
