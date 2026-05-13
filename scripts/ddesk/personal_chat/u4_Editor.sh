#!/bin/bash

xdotool keyup Super
WEEK=$(date +%V)
DATE="$WEEK $(date +"%a, %d at %H:%M")"
THIS="W$WEEK $DATE"

THE_TEXT="

-----------------------------------
$THIS
-----------------------------------
**Editor**:Edits_things_mainly_code
Note:
-----------------------------------

"

echo "$THE_TEXT" | xclip -se c

sleep 0.1
xdotool key --clearmodifiers Ctrl+v




