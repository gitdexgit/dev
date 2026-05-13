#!/bin/bash

LAST_DESKTOP_FILE="$HOME/.cache/last_desktop"

CURRENT_DESKTOP_FILE="$HOME/.cache/current_desktop"

NOW_WHAT_IS_MY_CURRENT_DESKTOP=$(xdotool get_desktop > "$CURRENT_DESKTOP_FILE")
