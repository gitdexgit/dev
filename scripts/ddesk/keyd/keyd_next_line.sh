#!/bin/bash
#
# This script performs the "select line and delete" macro.
# 1. Go to the end of the line.
# 2. Hold shift and go to the home of the line (selecting it).
# 3. Press delete twice (to handle different editor behaviors).



xdotool key End shift+Enter


