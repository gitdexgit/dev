#!/bin/bash

#!/bin/bash

# Define the full path of the script you want to pause
TARGET_SCRIPT="autoshot.sh"

echo "[AUTOSHOT PAUSER] Attempting to PAUSE (SIGSTOP): $TARGET_SCRIPT"

# 1. Find the Process ID (PID) precisely
PIDS=$(pgrep -f "$TARGET_SCRIPT")

if [ -z "$PIDS" ]; then
    # Process not running
    echo "[AUTOSHOT PAUSER] No running instance of autoshot.sh found."
else
    # Process found, pause it
    echo "[AUTOSHOT PAUSER] Found PID(s): $PIDS"

    # Iterate through PIDs and send the SIGSTOP signal
    for PID in $PIDS; do

        # Check current status to avoid sending SIGSTOP if already stopped
        STATUS=$(ps -p $PID -o stat=)

        if [[ "$STATUS" == *T* ]]; then
            echo "[AUTOSHOT PAUSER] PID $PID is already STOPPED ($STATUS). Skipping."
        else
            echo "[AUTOSHOT PAUSER] Sending SIGSTOP (kill -STOP) to PID $PID..."
            # Use 'kill -STOP' or 'kill -19'
            kill -STOP $PID
        fi
    done

    # Optional: Verify the status after sending the signal
    sleep 0.5
    echo "[AUTOSHOT PAUSER] Verification:"
    ps -p $PIDS -o pid,stat,command
fi
