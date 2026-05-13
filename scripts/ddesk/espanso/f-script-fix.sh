#!/bin/bash

# This script launches fleet.note.sh as a fully detached background process.
#
# nohup:  "No Hang Up". Ensures the script keeps running even if this launcher shell closes.
# ... > /dev/null: Redirects standard output (what the script normally prints) to nowhere.
# 2>&1:          Redirects standard error (error messages) to the same place as standard output (nowhere).
# &:             This is the most crucial part. It runs the entire command in the background.
#
# The result is that this launcher script executes the command and immediately exits,
# unblocking Espanso.

nohup /home/dex/scripts/ddesk/nothing/fleet.note.sh > /dev/null 2>&1 &
