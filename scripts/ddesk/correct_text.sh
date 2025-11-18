#!/bin/bash
set -e

# --- 1. CAPTURE TEXT ---
SELECTED_TEXT=$(xclip -o -selection primary)
if [ -z "$SELECTED_TEXT" ]; then
    notify-send "LanguageTool" "No text selected."
    exit 1
fi

# --- 2. GET CORRECTIONS FROM THE API (Smarter Version) ---
# We disable the main spell-checker to avoid bad corrections on technical terms.
JSON_OUTPUT=$(curl -s -X POST \
     --data-urlencode "text=$SELECTED_TEXT" \
     -d "language=en-US" \
     -d "disabledRules=MORFOLOGIK_RULE_EN_US" \
     https://api.languagetool.org/v2/check)

# --- 3. APPLY CORRECTIONS WITH PYTHON ---
# This Python block contains the critical fix.
CORRECTED_TEXT=$(python3 -c '
import sys, json, re

def sanitize_text(text):
    """Removes non-printable ASCII control characters."""
    return re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f]", "", text)

original_text = sys.argv[1]
corrected_text = original_text
try:
    data = json.loads(sys.stdin.read())
    matches = data.get("matches", [])
    matches.sort(key=lambda m: m["offset"], reverse=True)
    
    for match in matches:
        if match.get("replacements") and len(match["replacements"]) > 0:
            # The buggy [::-1] has been removed from this line.
            replacement = sanitize_text(match["replacements"][0]["value"])
            offset = match["offset"]
            length = match["length"]
            corrected_text = corrected_text[:offset] + replacement + corrected_text[offset+length:]

    print(corrected_text)
except (json.JSONDecodeError, IndexError):
    print(original_text)
' "$SELECTED_TEXT" <<< "$JSON_OUTPUT")

# --- 4. OUTPUT THE RESULT ---
echo -n "$CORRECTED_TEXT" | xclip -i -selection clipboard
xdotool key --clearmodifiers "ctrl+v"
notify-send "LanguageTool" "Text corrected and pasted."
