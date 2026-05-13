#!/bin/bash

# /home/dex/scripts/ddesk/nothing/autoshot.sh &


#!/bin/bash

# Define the full path of the script you are managing
TARGET_SCRIPT="autoshot.sh"

# 1. Check for the existence of the process using pgrep
# -f : searches the full command line, not just the executable name
PIDS=$(pgrep -f "$TARGET_SCRIPT")

if [ -z "$PIDS" ]; then
    # --- SCENARIO A: Process is NOT running ---
    echo "[AUTOSHOT] Process not found. Starting new instance..."
    "$TARGET_SCRIPT" &

else
    # --- SCENARIO B: Process IS running (or existing) ---
    echo "[AUTOSHOT] Process found (PIDs: $PIDS)."

    # Iterate through all found PIDs (usually just one, but safe practice)
    for PID in $PIDS; do

        # Get the process status ('stat' column, suppress header)
        # Status codes: R=Running, S=Sleeping, D=Disk sleep, T=Stopped, Z=Zombie
        STATUS=$(ps -p $PID -o stat=)

        # Check if the status indicates Stopped ('T' or 't' status flag)
        if [[ "$STATUS" == *T* ]]; then
            echo "[AUTOSHOT] PID $PID is currently STOPPED ($STATUS). Resuming..."
            # Send the SIGCONT signal to continue the process
            kill -CONT $PID
        else
            echo "[AUTOSHOT] PID $PID is running/sleeping ($STATUS). No action needed."
        fi
    done
fi
