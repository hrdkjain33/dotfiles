#!/bin/bash
# modules/dev-tools.sh - Development environment setup

set -e

echo "🛠️ Installing development tools..."

# Core dev tools
sudo apt install -y \
    neovim \
    tmux \
    ripgrep \
    fd-find \
    fzf \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm

# Install latest Node.js LTS via n
echo "📦 Setting up Node.js LTS..."
sudo npm install -g n
sudo n lts

# Useful npm globals
sudo npm install -g pnpm yarn

echo "✅ Development tools installed"
