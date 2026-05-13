#!/bin/bash

# ~/.local/scripts/new-note.sh

# --- Configuration ---
NOTES_DIR="$HOME/fleet"
# ---------------------

# 1. Ensure the notes directory exists.
mkdir -p "$NOTES_DIR"

# 2. Generate a timestamp to use as a *suggested* filename.
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
SUGGESTED_FILENAME="${TIMESTAMP}.md"

# 3. Change the current working directory to the notes directory.
# This way, when you save in Neovim, the file is created in the correct place.
# The '|| exit' part is a safety measure: if the cd fails, the script stops.
cd "$NOTES_DIR" || exit 1

# 4. Pipe the template directly into a new Neovim buffer.
# The magic happens on the `nvim` command line below.
cat << EOF | nvim -c "file $SUGGESTED_FILENAME" -c "normal Go" -c "startinsert" -
---
Title: '" What ever"'
aliases:
  - 
  - 
Number: 
---

(Make sure you write things before answering the questions then delete this line)

Tags: [ ], [ ], [ ], [ ], [ ], [ ]

Summary of what is this all about?:
-->

What is the problem here? Why did you write this?:
-->

Outline:
-->

Claimed Answers if any Exist:
-->

Where do you think this belongs to? At What category:
-->

Where do you think it belongs to in my obsdidian vualt?
-->

# (Make sure you write things before answering the questions then delete this or leave it)



EOF
