#!/bin/bash
# modules/fonts.sh - Nerd Fonts and icon fonts

set -e

echo "🔤 Installing fonts..."

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# JetBrains Mono Nerd Font
if [ ! -d "$FONT_DIR/JetBrainsMono" ]; then
    echo "  → Downloading JetBrains Mono Nerd Font..."
    wget -q --show-progress -O /tmp/JetBrainsMono.zip \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    mkdir -p "$FONT_DIR/JetBrainsMono"
    unzip -oq /tmp/JetBrainsMono.zip -d "$FONT_DIR/JetBrainsMono"
    rm /tmp/JetBrainsMono.zip
    echo "  ✓ JetBrains Mono installed"
else
    echo "  → JetBrains Mono already installed"
fi

# FiraCode Nerd Font (optional, popular alternative)
if [ ! -d "$FONT_DIR/FiraCode" ]; then
    echo "  → Downloading FiraCode Nerd Font..."
    wget -q --show-progress -O /tmp/FiraCode.zip \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
    mkdir -p "$FONT_DIR/FiraCode"
    unzip -oq /tmp/FiraCode.zip -d "$FONT_DIR/FiraCode"
    rm /tmp/FiraCode.zip
    echo "  ✓ FiraCode installed"
else
    echo "  → FiraCode already installed"
fi

# System fonts
sudo apt install -y fonts-noto fonts-noto-color-emoji

# Rebuild font cache
fc-cache -fv > /dev/null 2>&1

echo "✅ Fonts installed"
