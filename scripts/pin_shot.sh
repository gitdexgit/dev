#!/bin/bash
# Create a unique filename so you can pin multiple images
FILE="/tmp/pin_$(date +%s).png"

# 1. Capture selection
# -s lets you drag a box
scrot -s "$FILE" || exit 1

# 2. Copy to clipboard
xclip -selection clipboard -t image/png -i "$FILE"

# 3. Open in feh
# --title: allows i3 to target this window
# --no-menu: cleaner look
# --borderless: looks like a real "pin"
feh --title "screenshot_pin" --no-menu --borderless "$FILE" &

# 4. Clean up (Optional)
# Note: If you delete the file immediately, feh might fail to load it.
# It's better to let it sit in /tmp (it clears on reboot).
