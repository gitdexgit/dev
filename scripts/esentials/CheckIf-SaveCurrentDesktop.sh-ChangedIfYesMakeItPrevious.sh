#!/bin/bash

sleep 0.2


LAST_DESKTOP_FILE="$HOME/.cache/last_desktop"

CURRENT_DESKTOP_FILE="$HOME/.cache/current_desktop"

NOW_WHAT_IS_MY_CURRENT_DESKTOP=$(xdotool get_desktop)

NOW_WHAT_IS_MY_PREVIOUS_DESKTOP=$(cat "LAST_DESKTOP_FILE")

if [[ $NOW_WHAT_IS_MY_CURRENT_DESKTOP -ne $NOW_WHAT_IS_MY_PREVIOUS_DESKTOP ]]; then

    echo "$(cat $CURRENT_DESKTOP_FILE)" > $LAST_DESKTOP_FILE
    echo "$(cat $NOW_WHAT_IS_MY_CURRENT_DESKTOP)" > $CURRENT_DESKTOP_FILE
    exit 1
fi


