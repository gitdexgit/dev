#!/bin/bash

# 1. Get the actual workspace names from i3 (ordered by number)
raw_list=$(i3-msg -t get_workspaces | jq -r 'sort_by(.num) | .[].name')

# 2. Create the "Clean" list for Rofi
# This regex removes digits followed by a colon at the START of the line.
# 1:web -> web
# 7:7.vaults -> 7.vaults
# e:email -> remains e:email (because it starts with 'e', not a digit)
clean_list=$(echo "$raw_list" | sed 's/^[0-9]\+://')

# 3. Show the clean names in Rofi
selection=$(echo "$clean_list" | rofi -dmenu -i -p "Move Window:")

# 4. Map the selection back to the original i3 name
if [ -n "$selection" ]; then
    # Find which line number the user selected
    line_num=$(echo "$clean_list" | grep -nxF "$selection" | cut -d: -f1)

    if [ -n "$line_num" ]; then
        # Get the original i3 name from that same line number
        target=$(echo "$raw_list" | sed -n "${line_num}p")
        i3-msg "move container to workspace \"$target\""
    else
        # If you typed a NEW name that isn't in the list, create it as is
        i3-msg "move container to workspace \"$selection\""
    fi
fi
