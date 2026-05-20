#!/bin/bash
ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

i3-msg "[class=\"(?i)urxvt|qterminal|qalculate-gtk|copyq|Zeal|vesktop|keepassxc|xournalpp|dropdown_terminal\" floating workspace=\"$ws\"] move scratchpad"
i3-msg "[title=\"999|config|btop|task|duck|wiki|session\" floating workspace=\"$ws\"] move scratchpad"
