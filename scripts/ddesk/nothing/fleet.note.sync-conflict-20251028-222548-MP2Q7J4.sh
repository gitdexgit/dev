#!/bin/bash

# Define the target directory for your fleeting notes
FLEET_DIR="$HOME/fleet"

# 1. Ensure the notes directory exists.
mkdir -p "$FLEET_DIR"

# 2. Generate a timestamp for the final filename.
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
SUGGESTED_FILENAME="${TIMESTAMP}.md"

# 3. Create a secure temporary file to hold the template.
# mktemp creates a unique file and prints its path.
TEMP_TEMPLATE_FILE=$(mktemp)

# 4. Write your template into the temporary file using a here-document.
# Note the redirect `>` to the temp file variable.
cat << EOF > "$TEMP_TEMPLATE_FILE"
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

# 5. Launch Alacritty with a command that uses the temp file.
# This is the key part!
alacritty -e sh -c "cd '$FLEET_DIR' && nvim '$TEMP_TEMPLATE_FILE' -c \"file $SUGGESTED_FILENAME\" -c 'normal Go' -c 'startinsert' ; rm '$TEMP_TEMPLATE_FILE'" &


