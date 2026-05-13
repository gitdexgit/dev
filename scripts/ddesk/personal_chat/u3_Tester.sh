#!/bin/bash

xdotool keyup Super
WEEK=$(date +%V)
DATE="$WEEK $(date +"%a, %d at %H:%M")"
THIS="W$WEEK $DATE"

THE_TEXT="

----------------------------------------
$THIS
----------------------------------------
**Tester**:Runs_tests_and_gives_feedback
Note:
----------------------------------------

"

echo "$THE_TEXT" | xclip -se c

sleep 0.1
xdotool key --clearmodifiers Ctrl+v




