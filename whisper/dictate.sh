#!/bin/bash

# Configuration
LOCK_FILE="/tmp/whisper_dictation.lock"
AUDIO_FILE="/tmp/whisper_audio.wav"
WHISPER_PATH="$HOME/whisper.cpp/build/bin/whisper-cli"
MODEL_PATH="$HOME/whisper.cpp/models/ggml-base.en.bin"
VOCAB_CORRECT="$HOME/dotfiles/whisper/vocab_correct.sh"

# Sound feedback
STOP_SOUND="/usr/share/sounds/freedesktop/stereo/bell.oga"

if [ -f "$LOCK_FILE" ]; then
    # --- STOP & TRANSCRIBE ---
    
    PID=$(cat "$LOCK_FILE")
    kill -TERM "$PID"
    rm "$LOCK_FILE"
    
    paplay "$STOP_SOUND" &
    
    # Transcribe audio
    RAW_TEXT=$("$WHISPER_PATH" -m "$MODEL_PATH" -f "$AUDIO_FILE" -nt --no-prints 2>/dev/null | xargs)
    
    # Apply vocabulary correction
    TEXT=$(bash "$VOCAB_CORRECT" "$RAW_TEXT")

    if [ ! -z "$TEXT" ]; then
        wtype "$TEXT "
    fi

else
    # --- START RECORDING ---
    
    if command -v pw-record &> /dev/null; then
        pw-record --format=s16 --rate=16000 --channels=1 "$AUDIO_FILE" > /dev/null 2>&1 &
    else
        arecord -f S16_LE -c 1 -r 16000 "$AUDIO_FILE" > /dev/null 2>&1 &
    fi
    
    echo $! > "$LOCK_FILE"
fi

