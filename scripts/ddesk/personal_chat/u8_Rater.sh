#!/bin/bash

xdotool keyup Super
WEEK=$(date +%V)
DATE="$WEEK $(date +"%a, %d at %H:%M")"
THIS="W$WEEK $DATE"

THE_TEXT="

--------------------------------------------
$THIS
--------------------------------------------
**Rater**:Rates_stuff_with_different_ratings
Note:
--------------------------------------------

"

echo "$THE_TEXT" | xclip -se c

sleep 0.1
xdotool key --clearmodifiers Ctrl+v




