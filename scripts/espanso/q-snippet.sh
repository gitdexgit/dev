#!/bin/bash
# Log errors to check if script even run
exec 2> /tmp/espanso-debug.log

(
  # Wait for Espanso to release keyboard fully
  sleep 0.2

  # Ensure focus stay in terminal
  # xdotool type "q:"

  # Use key sequence for reliability in Nvim
  xdotool key q colon Return Return a colon

  sleep 0.1
  xdotool key Up Up
) &
disown
