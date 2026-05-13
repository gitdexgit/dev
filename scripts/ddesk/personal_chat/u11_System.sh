#!/bin/bash

xdotool keyup Super
WEEK=$(date +%V)
DATE="$WEEK $(date +"%a, %d at %H:%M")"
THIS="W$WEEK $DATE"

THE_TEXT="

------------------------------------------------------
$THIS
------------------------------------------------------
**System**:Logs_events_announcments_big_news_game_like
Note:
------------------------------------------------------

"

echo "$THE_TEXT" | xclip -se c

sleep 0.1
xdotool key --clearmodifiers Ctrl+v




