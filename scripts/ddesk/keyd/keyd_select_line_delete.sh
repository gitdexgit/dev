#!/bin/bash
#
# This script performs the "select line and delete" macro.
# 1. Go to the end of the line.
# 2. Hold shift and go to the home of the line (selecting it).
# 3. Press delete twice (to handle different editor behaviors).


xdotool keyup shift

sleep 0.01

xdotool key End shift+Home control+c Delete

sleep 0.01
# sleep 0.01
#
# sleep 0.01

# xdotool key BackSpace 
# sleep 0.1
# xdotool key End
# sleep 0.01
# sleep 0.1
# sleep 0.01
# sleep 0.1
#
# # xdotool key Down End
# sleep 0.1
# sleep 0.1
# xdotool key End
# after control+c we will have in index 0 the deleted stuff
# now we will copy index 1 then remove index 1 then add it again to make the 
# deleted stuff the new index 0
content=$(copyq read 1)
copyq remove 1
copyq add "$content"
#then we copy index 0
sleep 0.1
sleep 0.1
copyq select 0

