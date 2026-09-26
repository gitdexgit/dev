#!/bin/bash

HIST_FILE="/tmp/i3-window-focus-history"
touch "$HIST_FILE"

i3-msg -t subscribe -m '["window"]' | jq --unbuffered -r 'select(.change=="focus") | .container.window // empty' | while read -r id; do
    [ -z "$id" ] && continue

    # Put the latest window ID at top, drop duplicates, keep top 30
    temp=$(grep -v "^$id$" "$HIST_FILE" 2>/dev/null)
    printf "%s\n%s\n" "$id" "$temp" | sed '/^$/d' | head -n 30 > "$HIST_FILE.tmp"
    mv "$HIST_FILE.tmp" "$HIST_FILE"
done
