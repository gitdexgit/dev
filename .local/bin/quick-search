#!/bin/bash

# --- 1. CONFIGURATION ---
TARGET_WORKSPACE="1"
TAB_INDEX=0  # 0 is the first tab

# --- 2. GET USER INPUT ---
QUERY=$(echo "" | rofi -dmenu -p "🔍 Search" \
    -theme-str 'window {width: 40%; border: 2px; border-color: #5e81ac;} listview {enabled: false;}')

# Exit if empty
[[ -z "$QUERY" ]] && exit 0

# --- 3. CONSTRUCT URL ---
if [[ "$QUERY" =~ ^(https?://)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ && ! "$QUERY" == *" "* ]]; then
    URL="$QUERY"
    [[ ! "$URL" =~ ^https?:// ]] && URL="https://$URL"
else
    # URL encode the search query
    ENCODED=$(python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$QUERY")
    URL="https://duckduckgo.com/?q=$ENCODED"
fi

# --- 4. LAUNCH & FOCUS ---
# Open the URL in the background
firefox "$URL" &

# Step A: Jump to the workspace immediately
i3-msg "workspace $TARGET_WORKSPACE"

# Step B: Robust Tab Focusing (Logic from your tab-focus.sh)
# We find the ID of the node at TAB_INDEX within the specific TARGET_WORKSPACE
TARGET_ID=$(i3-msg -t get_tree | jq -r ".. | objects | \
    select(.type?==\"workspace\" and .name==\"$TARGET_WORKSPACE\") | \
    if (.nodes | length == 1) then .nodes[0].nodes[$TAB_INDEX].id else .nodes[$TAB_INDEX].id end")

# Step C: Apply focus to that specific container
if [[ "$TARGET_ID" != "null" && -n "$TARGET_ID" ]]; then
    # Double "focus child" as per your preference for robust terminal/tmux focusing
    i3-msg "[con_id=$TARGET_ID] focus; focus child; focus child"
fi
