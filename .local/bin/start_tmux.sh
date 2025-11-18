#!/bin/sh

# This script is intended to be run by the DE's autostart mechanism.
# It ensures a tmux server is running with the user's config.

# Check if a tmux server is already running. 'tmux info' is a good way to check.
# We redirect stdout and stderr to /dev/null to suppress output.
if ! tmux info >/dev/null 2>&1; then
    # If the command fails (exit code != 0), no server is running.
    # Start the server, loading the specific config file.
    /usr/bin/tmux -f "$HOME/.tmux.conf" start-server
fi

# The script exits here. The tmux server is now running in the background.
