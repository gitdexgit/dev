#!/usr/bin/env bash
item="$1"
case "$item" in
"[TMUX] "*)
    session="${item#\[TMUX\] }"
    active=$(tmux display-message -t "$session" -p '#{pane_index}' 2>/dev/null)
    pane_list=$(tmux list-panes -t "$session" -F '#{pane_index}' 2>/dev/null)
    total=$(echo "$pane_list" | wc -l | tr -d ' ')
    pos=$(echo "$pane_list" | awk -v a="$active" '{if($0==a) print NR}')
    windows=$(tmux list-windows -t "$session" \
      -F "#{window_index}:#{window_name}#{?window_active,*,}" 2>/dev/null | tr '\n' ' ')
    printf '\033[1;34m%s\033[0m  \033[1;33m[%s/%s]\033[0m\n' "$windows" "$pos" "$total"
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
