#!/bin/bash

# --- Configuration ---
# The directory where your Obsidian vault-opening scripts are stored.
VAULT_SCRIPTS_DIR="$HOME/scripts/ddesk/obsidian/ob-vaults"
# ---------------------

# 1. Check if the script directory actually exists.
if [ ! -d "$VAULT_SCRIPTS_DIR" ]; then
    echo "Error: Directory not found: $VAULT_SCRIPTS_DIR"
    echo "Please check the VAULT_SCRIPTS_DIR variable in the script."
    exit 1
fi

# 2. Use 'ls' to list the files in the directory and pipe them into fzf.
# The output of the user's selection is stored in the 'selected_script' variable.
# We add a --header to fzf to make it more user-friendly.
selected_script=$(ls "$VAULT_SCRIPTS_DIR" | fzf --header="Select an Obsidian Vault script to run")

# 3. Check if the user made a selection.
# If they press Esc, 'selected_script' will be empty, and we should exit gracefully.
if [ -z "$selected_script" ]; then
    echo "No script selected. Exiting."
    exit 0
fi

# 4. Construct the full path to the script and execute it.
FULL_SCRIPT_PATH="$VAULT_SCRIPTS_DIR/$selected_script"

echo "Running: $selected_script"
# The 'exec' command replaces the current script process with the new one.
"$FULL_SCRIPT_PATH"
