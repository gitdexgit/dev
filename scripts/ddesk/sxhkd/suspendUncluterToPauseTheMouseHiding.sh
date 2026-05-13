#!/bin/bash

# A script to pause and resume the unclutter process.

# The file we use to track the paused/resumed state.
STATE_FILE="/tmp/unclutter.paused"

# Find the Process ID (PID) of unclutter.
PID=$(pgrep -x unclutter)

# If unclutter isn't running, do nothing and exit.
if [ -z "$PID" ]; then
    echo "unclutter is not running."
    exit 1
fi

# Check if the state file exists.
if [ -f "$STATE_FILE" ]; then
    # --- RESUME ---
    # The file exists, so unclutter is currently paused. Let's resume it.
    echo "Resuming unclutter (PID: $PID)..."
    kill -CONT "$PID"
    
    # Remove the state file to mark it as resumed.
    rm "$STATE_FILE"
else
    # --- PAUSE ---
    # The file does not exist, so unclutter is running. Let's pause it.
    echo "Pausing unclutter (PID: $PID)..."
    kill -STOP "$PID"
    
    # Create the state file to mark it as paused.
    touch "$STATE_FILE"
fi
