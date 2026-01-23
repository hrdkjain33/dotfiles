#!/bin/bash
# modules/apps.sh - Daily applications

set -e

echo "📱 Installing applications..."

# Terminal emulator
sudo apt install -y alacritty

# VS Code
if ! command -v code &> /dev/null; then
    echo "  → Installing VS Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm /tmp/packages.microsoft.gpg
    sudo apt update
    sudo apt install -y code
    echo "  ✓ VS Code installed"
else
    echo "  → VS Code already installed"
fi

# Flatpak apps (Pop OS has Flatpak by default)
echo "  → Installing Flatpak apps..."

# Ensure Flathub is added
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Discord
flatpak install -y flathub com.discordapp.Discord || true

# LibreWolf (privacy-focused Firefox fork)
flatpak install -y flathub io.gitlab.librewolf-community || true

# Rnote (handwriting/drawing app)
flatpak install -y flathub com.github.flxzt.rnote || true

echo "✅ Applications installed"
