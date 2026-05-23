#!/bin/bash
ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

i3-msg "[class=\"(?i)urxvt|qterminal|qalculate-gtk|copyq|Zeal|vesktop|keepassxc|xournalpp|dropdown_terminal\" floating workspace=\"$ws\"] move scratchpad"
i3-msg "[title=\"main|config|btop|sync|task|work|duck|wiki|session\" floating workspace=\"$ws\"] move scratchpad"
