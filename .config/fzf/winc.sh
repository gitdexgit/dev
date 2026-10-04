#!/usr/bin/env bash
item=$(echo "$1" | tr -d "'\"")
action="$2"

[[ "$item" != "[TMUX] "* ]] && exit 0
session="${item#\[TMUX\] }"

if [[ "$action" == "next" ]]; then
  tmux next-window -t "$session"
else
  tmux previous-window -t "$session"
fi
