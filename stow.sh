#!/bin/bash
# stow.sh - Link all configs from configs/ directory

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_DIR="$DOTFILES_DIR/configs"

echo "🔗 Stowing configurations..."

# Check if configs directory exists and has packages
if [ ! -d "$CONFIGS_DIR" ] || [ -z "$(ls -A "$CONFIGS_DIR")" ]; then
    echo "  → No config packages found in $CONFIGS_DIR"
    exit 0
fi

# Stow each config package
cd "$CONFIGS_DIR"
for package in */; do
    package_name="${package%/}"
    echo "  → Stowing: $package_name"
    stow -v -t "$HOME" "$package_name" 2>&1 | sed 's/^/    /'
done

echo "✅ All configurations linked"
