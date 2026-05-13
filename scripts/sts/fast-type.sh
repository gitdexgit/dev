#!/bin/bash
MODEL="/home/dex/.local/share/whisper-models/tiny.en.bin"
BINARY="/home/dex/git/whisper.cpp/build/bin/whisper-cli"
TEMP_AUDIO="/tmp/whisper_voice.wav"
PID_FILE="/tmp/whisper_rec.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    kill "$PID" 2>/dev/null && rm "$PID_FILE"
    sleep 0.5

    if [ ! -f "$TEMP_AUDIO" ] || [ ! -s "$TEMP_AUDIO" ]; then
        notify-send "Dictation" "No audio recorded"
        exit
    fi

    if pgrep -x "whisper-cli" > /dev/null; then
        notify-send "Dictation" "Already processing, please wait..."
        exit
    fi

    notify-send "Dictation" "Processing..." -t 1000

    RESULT=$("$BINARY" -m "$MODEL" -f "$TEMP_AUDIO" \
        -nt \
        --threads 1 \
        --processors 1 \
        --beam-size 1 \
        --best-of 1 \
        --max-len 0 \
        2>/dev/null)

    CLEAN_TEXT=$(echo "$RESULT" | sed 's/\[.*\]//g' | xargs)

    if [ -n "$CLEAN_TEXT" ]; then
        echo -n "$CLEAN_TEXT " | xclip -selection clipboard
        sleep 0.2
        xdotool key --clearmodifiers ctrl+v
    else
        notify-send "Dictation" "No text detected"
    fi

    rm -f "$TEMP_AUDIO"
else
    rm -f "$TEMP_AUDIO"
    notify-send "Dictation" "Listening..." -t 500
    rec -q -c 1 -r 16000 "$TEMP_AUDIO" &
    echo $! > "$PID_FILE"
fi

