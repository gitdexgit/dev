#!/bin/bash
NUM=$1
DEFAULT=$2

i3-msg "workspace number $NUM"

NAME=$(i3-msg -t get_workspaces | python3 -c "
import json,sys
ws=json.load(sys.stdin)
f=[w for w in ws if w['focused']]
print(f[0]['name'] if f else '')
")

[ "$NAME" = "$NUM" ] && i3-msg "rename workspace to \"$DEFAULT\""
