#!/bin/bash
ORIGINAL=$(copyq read 0)
printf '%s' "$ORIGINAL"
export ORIGINAL
nohup sh -c 'sleep 0.5 && copyq remove 0 && printf "%s" "$ORIGINAL" | copyq copy -' >/dev/null 2>&1 &
