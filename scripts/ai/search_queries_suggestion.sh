#!/bin/bash
MODEL="llama3.2:latest"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "searcher" "⚠ nothing in clipboard" && exit 0

PROMPT="Convert the following natural language description into 3 optimized search engine queries. Rules: short, keyword-focused, no filler words, no punctuation, use search operators if helpful (site:, filetype:, quotes for exact). Output ONLY the queries, one per line, nothing else.\n\n$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "searcher" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "searcher" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ queries ready"
