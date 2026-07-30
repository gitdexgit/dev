#!/bin/bash

CACHE="$HOME/.cache/last_workspace"

# 1. Get workspace names and the focused one
ws_list=$(i3-msg -t get_workspaces | jq -r '.[].name')
current_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# 2. Calculate 0-based index for Rofi highlighting
row_num=$(echo "$ws_list" | grep -nxF "$current_ws" | cut -d: -f1)
active_idx=$((row_num - 1))

# 3. Show Rofi with active highlight (-a) and pre-selected row
selection=$(echo "$ws_list" | rofi -dmenu -i -p "Workspace:" -a "$active_idx" -selected-row "$active_idx")

# 4. Switch and center mouse
if [ -n "$selection" ] && [ "$selection" != "$current_ws" ]; then
    echo "$current_ws" > "$CACHE"
    i3-msg "workspace \"$selection\""

    sleep 0.1
    xdotool mousemove --window $(xdotool getactivewindow) --polar 0 0
fi
