#!/bin/bash
MODEL="qwen2.5:1.5b"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "taskdump" "⚠ nothing in clipboard" && exit 0

PROMPT="Act as Taskwarrior architect. Convert the following brain dump into atomic actionable tasks. Rules: 1. Each task must be atomic - smallest possible unit. 2. Output ONLY 'task add project:<name> <description>' commands, one per line. 3. Infer project names from context. 4. No filler, no explanations, no numbering.\n\nDump:\n$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "taskdump" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "taskdump" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ tasks ready"
