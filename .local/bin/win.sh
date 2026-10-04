#!/usr/bin/env bash
item=$(echo "$1" | tr -d "'\"")
win="$2"

[[ "$item" != "[TMUX] "* ]] && exit 0
session="${item#\[TMUX\] }"

target_id=$(tmux list-windows -t "$session:" -F '#{window_index} #{window_id}' 2>/dev/null | awk -v w="$win" '$1==w {print $2}')

if [[ -n "$target_id" ]]; then
  tmux select-window -t "$target_id"
else
  tmux select-window -t "$session:$win"
fi
