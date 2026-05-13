#!/bin/bash
# SCRIPT 2: NVIM INJECTOR (ORCHESTRATOR)
# Espanso calls this script. It coordinates getting the content
# and then injecting it into Neovim with xdotool.

# --- SETUP ---
# Find the directory this script is in, so we can reliably call the other script.
script_dir=$(dirname "$(readlink -f "$0")")

# --- EXECUTION ---

sleep 0.05 # Small pause for stability
# 1. Call the content script and capture its output into a variable.
full_block=$("$script_dir/insert_comment_gc_hashtag.sh")

# 2. Check if the content is empty (meaning the user cancelled the prompt).
if [ -z "$full_block" ]; then
  # If so, just delete the trigger and exit gracefully.
  # xdotool key --clearmodifiers BackSpace BackSpace BackSpace BackSpace
  exit 0
fi

# 3. If we have content, perform the sequence of keyboard actions.
#    This part is the "editor manipulation" logic.

sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability

# Action 1: Delete the trigger ";;gc#"
xdotool key --clearmodifiers BackSpace 
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
xdotool key --clearmodifiers BackSpace 
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
xdotool key --clearmodifiers BackSpace 
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
xdotool key --clearmodifiers BackSpace 
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability

xdotool key --clearmodifiers BackSpace 
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
sleep 0.05 # Small pause for stability
# Action 2: Type the content we got from the other script
# xdotool type --clearmodifiers --delay 0 "$full_block"
xdotool type --clearmodifiers "$full_block"

# Action 3: Enter Normal Mode
# xdotool key --clearmodifiers Escape
sleep 0.05

# # Action 4: Move up two lines
# xdotool key --clearmodifiers k k
#
# # Action 5: Enter Insert Mode at the start of the line
# xdotool key --clearmodifiers I
