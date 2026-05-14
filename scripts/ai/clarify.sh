#!/bin/bash
MODEL="qwen2.5:1.5b"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "clarify" "⚠ nothing in clipboard" && exit 0

PROMPT="You are a detail inspector. Read the following dump and identify only the parts that are too vague to act on. For each vague part output exactly in this format:

vague: [quote]
need: [what specific detail is missing]
q: [one direct question to the user to resolve it]

Nothing else. No filler. No explanations.

Dump:
$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "clarify" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "clarify" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ clarify ready"
