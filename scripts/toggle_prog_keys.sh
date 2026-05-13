#!/bin/bash
STATE_FILE="/tmp/prog_keys_state"
if [ ! -f $STATE_FILE ] || [ "$(cat $STATE_FILE)" == "norm" ]; then
    xmodmap ~/.Xmodmap.prog
    echo "prog" > $STATE_FILE
    dunstify -u low -t 500 -a "Keys" -h "string:bgcolor:#2e7d32" -h "string:fgcolor:#ffffff" "Keys: Programmer"
else
    xmodmap ~/.Xmodmap.norm
    echo "norm" > $STATE_FILE
    dunstify -u low -t 500 -a "Keys" -h "string:bgcolor:#455a64" -h "string:fgcolor:#ffffff" "Keys: Normal"
fi
