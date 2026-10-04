#!/usr/bin/env bash
item=$(echo "$1" | tr -d "'\"")
n="$2"

[[ "$item" != "[TMUX] "* ]] && exit 0
session="${item#\[TMUX\] }"

id=$(tmux list-panes -t "$session:" -F '#{pane_id}' 2>/dev/null | sed -n "${n}p")
[[ -n "$id" ]] && tmux select-pane -t "$id"
