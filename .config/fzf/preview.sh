#!/usr/bin/env bash
item="$1"

case "$item" in
  "[TMUX] "*)
    session="${item#\[TMUX\] }"
    meta=$(tmux display-message -p -t "$session" \
      "Session: #S | Windows: #{session_windows} | Active: #W" 2>/dev/null)
    printf '\033[1;34m%s\033[0m\n' "$meta"
    echo "------------------------------------"
    tmux capture-pane -ep -t "$session" 2>/dev/null
    ;;
  *)
    if [ -f "$item" ]; then
      bat --color=always --style=numbers --line-range=:500 "$item"
    else
      echo "No preview for: $item"
    fi
    ;;
esac
