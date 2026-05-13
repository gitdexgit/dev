#!/bin/bash
# ~/.local/scripts/tmux_mark_toggle.sh

# This script toggles the border color of the current pane
# It's controlled by a hook in tmux.conf

# Check if the pane is currently marked by looking at a tmux variable
is_marked=$(tmux show-options -p | grep -c '@marked-pane-is-on')

if [ "$is_marked" -eq 1 ]; then
  # If it IS marked, turn our custom setting OFF and reset the color
  tmux set-option -p -u @marked-pane-is-on
  tmux select-pane -P 'border-style=fg=gray' # Reset to default
else
  # If it is NOT marked, turn our custom setting ON and set the color
  tmux set-option -p @marked-pane-is-on 1
  tmux select-pane -P 'border-style=fg=magenta,bold' # Our custom "marked" color
fi
