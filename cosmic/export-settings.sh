#!/bin/bash
# cosmic/export-settings.sh - Export current COSMIC settings

set -e

SCRIPT_DIR="$(dirname "$0")"

echo "📸 Exporting COSMIC settings..."

COSMIC_CONFIG="$HOME/.config/cosmic"

if [ -d "$COSMIC_CONFIG" ]; then
    # Remove old backup
    rm -rf "$SCRIPT_DIR/cosmic-config-backup"
    
    # Create new backup
    cp -r "$COSMIC_CONFIG" "$SCRIPT_DIR/cosmic-config-backup"
    
    echo "✅ COSMIC settings exported to $SCRIPT_DIR/cosmic-config-backup/"
    echo "   Commit this to your dotfiles repo to save your settings."
else
    echo "⚠️  No COSMIC config found at $COSMIC_CONFIG"
    echo "   Make sure you're running COSMIC DE."
fi
