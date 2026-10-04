#!/usr/bin/env bash
f="/tmp/tmux-pick-$1.off"
o=$(cat "$f" 2>/dev/null || echo 0)
o=$((o + $2))
(( o < 0 )) && o=0
echo "$o" > "$f"
