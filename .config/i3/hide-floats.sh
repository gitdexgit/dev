#!/bin/bash
ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

i3-msg "[class=\"(?i)alacritty|urxvt|qterminal|copyq|Zeal|vesktop|keepassxc|xournalpp|dropdown_terminal\" floating workspace=\"$ws\"] move scratchpad"
i3-msg "[title=\"999\" floating workspace=\"$ws\"] move scratchpad"
