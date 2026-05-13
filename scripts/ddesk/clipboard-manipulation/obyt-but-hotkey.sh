#!/bin/bash

URL=$(xclip -selection clipboard -o)

MARKDOWN_LINK="![]($URL)"

echo -n "$MARKDOWN_LINK" | xclip -selection clipboard

sleep 0.1
xdotool keyup control alt
sleep 0.1
xdotool key ctrl+v

