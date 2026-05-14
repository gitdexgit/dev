#!/bin/bash

WIKI_DIR=~/wiki
MODEL="qwen2.5:1.5b"

QUERY=$(xclip -o -selection clipboard 2>/dev/null)

if [ -z "$QUERY" ]; then
    dunstify -u normal -t 2000 -a "wiki" "⚠ nothing in clipboard"
    exit 0
fi

if ! ollama ps 2>/dev/null | grep -q "$MODEL"; then
    dunstify -u low -t 2000 -a "wiki" "⏳ loading model..."
fi

TITLES=$(for f in "$WIKI_DIR"/*.md; do basename "$f"; done)

PROMPT="You are a wiki search assistant running inside a bash script. Here is a list of article titles:\n\n$TITLES\n\nThe user is looking for: $QUERY\n\nReturn ONLY the titles from the list that best match the user's intent, including the .md extension. One title per line. No explanations, no preamble, no extra text. IMPORTANT: you are running inside a script — your output is parsed programmatically. If nothing closely matches, return exactly the string: no match — nothing else, no punctuation, no explanation."

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"$MODEL\",
    \"prompt\": $(jq -n --arg p "$PROMPT" '$p'),
    \"options\": {\"temperature\": 0, \"top_k\": 1},
    \"stream\": false
  }" | jq -r '.response')

if [ -z "$RESULT" ] || [ "$RESULT" = "no match" ]; then
    dunstify -u normal -t 2000 -a "wiki" \
      -h "string:bgcolor:#e53935" \
      -h "string:fgcolor:#ffffff" \
      "✗ no wiki match found"
    exit 0
fi

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "wiki" \
  -h "string:bgcolor:#1e88e5" \
  -h "string:fgcolor:#ffffff" \
  "✓ wiki match ready"
