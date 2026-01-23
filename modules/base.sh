#!/bin/bash
# modules/base.sh - Core system packages

set -e

echo "📦 Installing base packages..."

sudo apt install -y \
    git \
    stow \
    curl \
    wget \
    build-essential \
    cmake \
    htop \
    btop \
    neofetch \
    unzip \
    zip \
    tar \
    jq \
    tree \
    xclip \
    wl-clipboard

echo "✅ Base packages installed"
