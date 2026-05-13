#!/bin/bash

# ~/.local/scripts/tmux-temp-terminal.sh
# Creates a temporary, disposable tmux session and displays it in a popup.
# This method correctly handles key passthrough (like Escape for vi-mode).

# 1. Create a unique session name using the script's process ID ($$)
#    This ensures that multiple temporary popups don't conflict.
SESSION_NAME="temp-popup-$$"

# 2. Create the new session in the background (detached).
#    It will start with a single window running your default shell.
tmux new-session -d -s "$SESSION_NAME"

# 3. Display this new session in a popup.
#    The script will PAUSE here and wait for the popup to be closed.
tmux display-popup -w 91% -h 91% -E "tmux attach-session -t '$SESSION_NAME'"

# 4. After the popup is closed, this line will run.
#    It kills the temporary session, cleaning everything up automatically.
tmux kill-session -t "$SESSION_NAME"
