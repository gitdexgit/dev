#!/bin/bash
# Pass the tab index as the first argument (0 for Tab 1, 1 for Tab 2, etc.)
INDEX=$1

# Get the Target ID from the current workspace tree
TARGET_ID=$(i3-msg -t get_tree | jq -r ".. | objects | select(.type?==\"workspace\" and any(.. | objects; .focused?)) | if (.nodes | length == 1) then .nodes[0].nodes[$INDEX].id else .nodes[$INDEX].id end")

# Focus the ID if it was found and isn't "null"
if [ "$TARGET_ID" != "null" ]; then
    # We chain 'focus' and 'focus child'.
    # This selects the container, then immediately moves focus to the window inside.
    # Me:
    # The reason I'm doubling on focus child, so that some windows, like
    # terminal, when using tmux it doesn't focus really well. But adding another
    # focus child solves the problem
    i3-msg "[con_id=$TARGET_ID] focus; focus child; focus child"
fi
