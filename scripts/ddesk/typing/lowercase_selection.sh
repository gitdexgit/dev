#!/bin/bash

xdotool keyup Super_L Super_R Shift_L Shift_R Control_L Control_R
sleep 0.05
xdotool key --clearmodifiers ctrl+c
sleep 0.1

CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && exit 0

echo -n "$CLIP" | tr '[:upper:]' '[:lower:]' | xclip -selection clipboard
sleep 0.05
xdotool key --clearmodifiers ctrl+v
