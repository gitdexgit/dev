#!/bin/bash
ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

i3-msg "[class=\"(?i)urxvt|scrcpy|obs|qterminal|qalculate-gtk|copyq|Zeal|vesktop|keepassxc|xournalpp|dropdown_terminal\" floating workspace=\"$ws\"] move scratchpad"
i3-msg "[title=\"main|config|learn|btop|sync|work|duck|wiki|session\" floating workspace=\"$ws\"] move scratchpad"

