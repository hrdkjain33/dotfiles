#!/bin/bash
# Whisper.cpp Voice Dictation Module Installer

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE}" )/.." && pwd )"
WHISPER_DIR="$DOTFILES_DIR/whisper"

echo "🎤 Installing Whisper dictation..."

# Install system dependencies
sudo apt install -y build-essential cmake alsa-utils wtype pulseaudio-utils

# Build whisper.cpp if not present
if [ ! -d "$HOME/whisper.cpp" ]; then
    cd ~
    git clone https://github.com/ggerganov/whisper.cpp.git
    cd whisper.cpp
    cmake -B build && cmake --build build -j4 --config Release
    bash ./models/download-ggml-model.sh base.en
fi

# Symlink scripts to home
ln -sf "$WHISPER_DIR/dictate.sh" "$HOME/dictate.sh"
ln -sf "$WHISPER_DIR/coding_vocab.txt" "$HOME/coding_vocab.txt"
chmod +x "$HOME/dictate.sh"

echo "✅ Whisper module installed! Configure keyboard shortcut in Settings."

