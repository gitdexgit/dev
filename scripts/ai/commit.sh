#!/bin/bash
MODEL="llama3.2:latest"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "commit" "⚠ nothing in clipboard" && exit 0

PROMPT="Generate a conventional commit message from the following description. Format: <type>[(<scope>)]: <imperative summary> — max 50 chars. Types: feat/fix/refactor/perf/test/docs/chore. Output ONLY the commit message, nothing else.\n\n$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "commit" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "commit" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ commit ready"
