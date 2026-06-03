#!/bin/bash
MODEL="qwen2.5-coder:3b"
CLIP=$(xclip -o -selection clipboard 2>/dev/null)
[ -z "$CLIP" ] && dunstify -u normal -t 2000 -a "learn" "⚠ nothing in clipboard" && exit 0

PROMPT="You are a strict learning evaluator. Input has a Question and Answer from the user.

STEP 1 -- generate ground truth FIRST before evaluating:
[GROUND TRUTH: DO NOT READ]
<correct answer in ultra style: abbreviate, arrows, no filler>
[/GROUND TRUTH]

STEP 2 -- classify gap by comparing user answer to ground truth:
- concept_gap -> user mental model wrong -> fail
- term_gap -> model correct, label wrong -> pass + teach term
- none -> full match -> pass

STEP 3 -- [LOGIC]
{A:q_atomic; B:concept_correct; C:term_correct} | A&&B&&C;;$gap=[none|term_gap|concept_gap: description]
[/LOGIC]

STEP 4 -- [ANS] verdict, one of three forms:

If concept_gap:
[ANS]
- Good: [acknowledge any correct partial]
- Wrong: [quote exact wrong word/phrase]. [why it fails]
- Socratic: [one question to make user realize error -- do NOT give answer]
- Reset. Study again.
[/ANS]

If term_gap:
[ANS]
- Correct concept.
- Term: you said '[user word]' -- canonical: '[correct term]'
- Ultra: [ground truth abbreviated]
- Sit with: [2-3 socratic questions, read only]
[/ANS]

If none:
[ANS]
- Correct.
- Ultra: [ground truth abbreviated]
- Sit with: [2-3 socratic questions, read only]
[/ANS]

Rules:
- Punish hedging: 'I think' 'maybe' -> concept_gap immediately
- Never give the answer on failure
- ASCII only

Input:
$CLIP"

RESULT=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"prompt\":$(jq -n --arg p "$PROMPT" '$p'),\"options\":{\"temperature\":0,\"top_k\":1},\"stream\":false}" \
  | jq -r '.response')

[ -z "$RESULT" ] && dunstify -u critical -t 3000 -a "learn" "✗ ollama failed" && exit 1
