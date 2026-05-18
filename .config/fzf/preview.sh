#!/usr/bin/env bash
item="$1"

case "$item" in
  "[TMUX] "*)
    session="${item#\[TMUX\] }"
    windows=$(tmux list-windows -t "$session" \
      -F "#{window_index}:#{window_name}#{?window_active,*,}" 2>/dev/null | tr '\n' ' ')
    printf '\033[1;34m%s\033[0m\n' "$windows"
    echo "------------------------------------"

    current=$(tmux display-message -p '#S' 2>/dev/null)
    if [[ "$session" != "$current" && -n "$FZF_PREVIEW_COLUMNS" ]]; then
      orig=$(tmux display-message -p -t "$session" "#{window_width}" 2>/dev/null)
      tmux resize-window -t "$session" -x "$FZF_PREVIEW_COLUMNS" 2>/dev/null
      tmux capture-pane -ep -t "$session" 2>/dev/null
      tmux resize-window -t "$session" -x "$orig" 2>/dev/null
    else
      tmux capture-pane -ep -t "$session" 2>/dev/null
    fi
    ;;
  *)
    if [ -f "$item" ]; then
      bat --color=always --style=numbers --line-range=:500 "$item"
    else
      echo "No preview for: $item"
    fi
    ;;
esac
