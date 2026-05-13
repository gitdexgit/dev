#!/bin/bash

# Define the target directory for your fleeting notes
FLEET_DIR="$HOME/vaults/inbox/"

# --- ZK CHECK ---
# Check if the 'zk' command is available in the system's PATH
# if command -v zk &> /dev/null; then
#     # ZK IS AVAILABLE: Use the simpler zk n command.
#
#     echo "zk found. Using 'zk n' to create a note."
#
#     # Execute the command inside a new alacritty window using zsh.
#     alacritty -e zsh -c "zk n"
#
# else

# 2. Generate a timestamp for the final filename.
TIMESTAMP=$(date +%Y%m%d%H%M)
# The full path to the final note file
TARGET_FILE="$FLEET_DIR/$TIMESTAMP.md"

# 3. Create a secure temporary file to hold the template.
# mktemp creates a unique file and prints its path.
TEMP_TEMPLATE_FILE=$(mktemp)

# 4. Define the content for the first line
FIRST_LINE="$TIMESTAMP"
HEADER=$(date +'W%V %a, %d at %H:%M')

# Write your template into the temporary file
printf "" > "$TEMP_TEMPLATE_FILE"

# 5. Define the full command to execute within alacritty/zsh.
# This command first opens nvim with the template, then moves/renames the file,
# and finally cleans up the temporary file.
NVIM_COMMAND="
  # Open nvim:
  # -c \"file $TARGET_FILE\" -> Renames buffer to the final filename (Ghost mode)
  # -c \"8\" -> Jumps to line 8
  # -c \"startinsert\" -> Ready to type
  # -c \"setlocal wrap\" -> Visual wrapping
  nvim \"$TEMP_TEMPLATE_FILE\" -c \"file $TARGET_FILE\" -c \"10\" -c \"startinsert\" -c \"setlocal wrap\"

  # Cleanup: Remove the temporary file *after* nvim has finished
  rm \"$TEMP_TEMPLATE_FILE\"
"

# 6. Execute the command inside a new alacritty window using zsh.
# -e executes the following command and then exits the terminal.
alacritty -e zsh -c "$NVIM_COMMAND"

#
# fi

