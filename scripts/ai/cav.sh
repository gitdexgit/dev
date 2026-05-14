#!/bin/bash
MODEL="qwen2.5:1.5b"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "cav" "⚠ nothing in clipboard" && exit 0

PROMPT="Rephrase the following text in caveman style. Rules: drop articles, drop filler words, fragments OK, use short synonyms, keep ALL technical substance and meaning, do not add new information. Output only the rephrased text.\n\n$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "cav" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "cav" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ cav done"
