#!/bin/bash

CLIP=$(xclip -o -selection clipboard 2>/dev/null)

if [ -z "$CLIP" ]; then
    dunstify -u normal -t 2000 -a "fix_text" "⚠ nothing in clipboard"
    exit 0
fi

aspell_fix() {
    local text="$1"
    local corrections
    corrections=$(echo "$text" | aspell -a --lang=en 2>/dev/null | awk '
        /^[&]/ {
            original = $2
            split($0, parts, ": ")
            n = split(parts[2], sugs, ", ")

            orig_lower = tolower(original)

            # if any suggestion lowercased == original lowercased → keep as-is
            keep = 0
            for (i = 1; i <= n; i++) {
                gsub(/^ +| +$/, "", sugs[i])
                if (tolower(sugs[i]) == orig_lower) { keep = 1; break }
            }
            if (keep) next

            # prefer first all-lowercase suggestion
            best = ""
            for (i = 1; i <= n; i++) {
                if (sugs[i] ~ /^[a-z]+$/) { best = sugs[i]; break }
            }
            if (best == "") best = sugs[1]
            gsub(/^ +| +$/, "", best)
            if (best != "") print original "|" best
        }
    ')

    local result="$text"
    while IFS='|' read -r original suggestion; do
        [ -z "$original" ] && continue
        escaped=$(echo "$original" | sed 's/[]\[^$.*/]/\\&/g')
        result=$(echo "$result" | sed "s/\b$escaped\b/$suggestion/g")
    done <<< "$corrections"

    echo "$result"
}

SPELL_FIXED=$(aspell_fix "$CLIP")

PROMPT="Fix grammar only. Spelling is already correct. Do not change, replace, or rephrase any words. Only fix grammar if clearly broken. Output only the corrected text."

FIXED=$(curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"llama3.2:latest\",
    \"prompt\": $(jq -n --arg p "$PROMPT\n\n$SPELL_FIXED" '$p'),
    \"options\": {\"temperature\": 0, \"top_k\": 1},
    \"stream\": false
  }" | jq -r '.response')

if [ -z "$FIXED" ]; then
    dunstify -u critical -t 3000 -a "fix_text" "✗ ollama failed"
    exit 1
fi

echo -n "$FIXED" | xclip -selection clipboard



dunstify -u low -t 1400 -a "fix_text" \
  -h "string:bgcolor:#1e88e5" \
  -h "string:fgcolor:#ffffff" \
  "✓ fix_text done"
