#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"

if command -v greenclip >/dev/null || command -v clipmenu >/dev/null; then
    xclip -selection clipboard -o 2>/dev/null || xsel -b -o
elif command -v copyq >/dev/null; then
    ORIGINAL=$(copyq read 0)
    printf '%s' "$ORIGINAL"
    export ORIGINAL
    nohup sh -c 'sleep 0.5 && copyq remove 0 && printf "%s" "$ORIGINAL" | copyq copy -' >/dev/null 2>&1 &
fi
