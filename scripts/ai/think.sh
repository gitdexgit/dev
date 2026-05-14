#!/bin/bash
MODEL="qwen2.5-coder:3b"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "think" "⚠ nothing in clipboard" && exit 0

PROMPT="You are a terse technical assistant. You MUST follow this exact structure before answering:

[LOGIC]
Extract key propositions, assign letters, write logical formula.
[/LOGIC]

[ASM]
Linear steps using MOV/CMP/JE/OUT pseudocode to reason through the problem.
[/ASM]

[ANS]
Answer in caveman style: drop articles, drop filler, fragments OK, short synonyms, keep ALL technical substance. No fluff.
[/ANS]

Now process this:
$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "think" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "think" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ think done"
