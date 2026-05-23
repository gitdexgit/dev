#!/bin/bash
(
  # Wait for Nvim to process text injection
  sleep 5.15
  # Move up 2 lines to reach space below q:
  xdotool key --clearmodifiers Up Up
) &
disown
