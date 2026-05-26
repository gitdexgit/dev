#!/usr/bin/env bash
item="$1"
dir="$2"
[[ "$item" != "[TMUX] "* ]] && exit 0
session="${item#\[TMUX\] }"
if [[ "$dir" == "next" ]]; then
  tmux select-pane -t "$session":.+ 2>/dev/null
else
  tmux select-pane -t "$session":.- 2>/dev/null
fi
