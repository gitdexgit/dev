#!/bin/bash

# 1. The Theme String (This makes it look like a dmenu bar at the top)
THEME="window {width: 100%; anchor: north; location: north; children: [ horibox ];} horibox {orientation: horizontal; children: [ prompt, entry, listview ];} listview {layout: horizontal; spacing: 5px; lines: 100;} entry {expand: false; width: 10em;}"

# 2. Run Rofi
# -run-command "bash -c '{cmd}'" is the magic part that makes ~/ and $HOME work
rofi -show run \
    -theme-str "$THEME" \
    -run-command "bash -c '{cmd}'"
