#!/usr/bin/env bash
item="$1"
win="$2"

[[ "$item" != "[TMUX] "* ]] && exit 0

session="${item#\[TMUX\] }"
tmux select-window -t "$session:$win" 2>/dev/null
