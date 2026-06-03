#!/bin/bash
MODEL="qwen2.5-coder:3b"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "namer" "⚠ nothing in clipboard" && exit 0

PROMPT="Suggest 5 concise variable or function names for the following description. Use snake_case and camelCase variants. Output ONLY the names, one per line, no explanations.\n\n$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "namer" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "namer" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ names ready"
