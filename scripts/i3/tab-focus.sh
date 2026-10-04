#!/bin/bash
[ -z "$1" ] && exit 1

INDEX=$1

TARGET_ID=$(i3-msg -t get_tree | jq -r --argjson idx "$INDEX" '
  ([.. | objects | select((.layout? == "tabbed" or .layout? == "stacked") and any(.. | objects; .focused?))] | last)
  // (.. | objects | select(.type? == "workspace" and any(.. | objects; .focused?)))
  | .nodes[$idx].id // empty
')

if [ -n "$TARGET_ID" ]; then
    i3-msg "[con_id=$TARGET_ID] focus; focus child; focus child"
fi
