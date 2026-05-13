#!/bin/bash
BORDER=$(i3-msg -t get_tree | python3 -c "
import json,sys
def find_focused(n):
    if n.get('focused'): return n
    for c in n.get('nodes',[])+n.get('floating_nodes',[]):
        r=find_focused(c)
        if r: return r
focused=find_focused(json.load(sys.stdin))
print(focused['current_border_width'])
")
if [ "$BORDER" = "0" ]; then
    i3-msg 'border normal'
else
    i3-msg 'border pixel 0'
fi
