#!/bin/bash

# 1. Get the URL, Time, and Title from Zen/Firefox
URL=$(playerctl -p firefox metadata xesam:url || playerctl metadata xesam:url)
SECONDS=$(playerctl -p firefox position | cut -d'.' -f1 || playerctl position | cut -d'.' -f1)
TITLE=$(playerctl -p firefox metadata xesam:title || playerctl metadata xesam:title)

# 2. Safety check
if [ -z "$URL" ]; then
    notify-send -a "yt_timestamp" "Error" "No video found"
    exit 1
fi

# 3. STRIP PLAYLIST AND OLD TIME DATA
# Removes: &list=..., ?list=..., &index=..., &t=...
CLEAN_URL=$(echo "$URL" | sed -E 's/[&?](list|index|t)=[^&]*//g')

# 4. Fix potential broken URL (removes trailing ? or & if we stripped everything after it)
CLEAN_URL=$(echo "$CLEAN_URL" | sed 's/[?&]$//')

# 5. Append the NEW timestamp
# If the URL still has a '?' (like watch?v=ID), use '&t='
# If not (like youtu.be/ID), use '?t='
if [[ "$CLEAN_URL" == *"?"* ]]; then
    FINAL_URL="${CLEAN_URL}&t=${SECONDS}"
else
    FINAL_URL="${CLEAN_URL}?t=${SECONDS}"
fi

# 6. Copy to clipboard
echo -n "$FINAL_URL" | xclip -selection clipboard

# 7. Notify (Using your Dunst rule + 3s timeout)
notify-send -a "yt_timestamp" "Captured" "Video: $TITLE\n$FINAL_URL"
