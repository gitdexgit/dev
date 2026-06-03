#!/bin/bash
MODEL="llama3.2:latest"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "atomq" "⚠ nothing in clipboard" && exit 0

PROMPT="You are an atomic question refiner running inside a bash script. Your output is parsed programmatically.

Rules:
1. From the answer given, extract what the user wants to remember -- that is the recall target.
2. Output the minimum number of questions. Only split if two genuinely separate recall targets exist.
3. Questions must trigger recall of the answer without restating it.
4. Questions must be self-contained -- include domain context.
5. ASCII only. No commas. No parentheses. No double quotes. No shell-breaking chars: ? * : < > | \\ / ! \$ &
6. Use single quotes if quoting needed. Use -> for arrows.

Output format -- strictly this, nothing else:
[LOGIC]
one line: recall target extracted from answer
[/LOGIC]
[ANS]
- Atomic question 1
- Atomic question 2 only if two separate recall targets
[/ANS]

Answer to process:
$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "atomq" "✗ ollama failed" && exit 1

echo -n "$RESULT" | xclip -selection clipboard
dunstify -u low -t 1400 -a "atomq" \
  -h "string:bgcolor:#1e88e5" -h "string:fgcolor:#ffffff" "✓ atomq ready"
