#!/bin/bash
# modules/cosmic-settings.sh - COSMIC DE settings backup/restore
# Note: COSMIC is still in development, settings management may change

set -e

COSMIC_DIR="$(dirname "$0")/../cosmic"

echo "🌌 COSMIC Settings Manager"

# COSMIC stores settings differently than GNOME
# For now, we track what we can

# Export current settings
export_settings() {
    echo "  → Exporting COSMIC settings..."
    
    # COSMIC settings location (may vary by version)
    COSMIC_CONFIG="$HOME/.config/cosmic"
    
    if [ -d "$COSMIC_CONFIG" ]; then
        # Create a snapshot of cosmic config
        cp -r "$COSMIC_CONFIG" "$COSMIC_DIR/cosmic-config-backup"
        echo "  ✓ COSMIC config backed up to $COSMIC_DIR/cosmic-config-backup"
    else
        echo "  → No COSMIC config found at $COSMIC_CONFIG"
    fi
}

# Import/restore settings
import_settings() {
    echo "  → Restoring COSMIC settings..."
    
    COSMIC_CONFIG="$HOME/.config/cosmic"
    
    if [ -d "$COSMIC_DIR/cosmic-config-backup" ]; then
        mkdir -p "$COSMIC_CONFIG"
        cp -r "$COSMIC_DIR/cosmic-config-backup/"* "$COSMIC_CONFIG/"
        echo "  ✓ COSMIC settings restored"
    else
        echo "  → No backup found to restore"
    fi
}

# Main logic
case "${1:-import}" in
    export)
        export_settings
        ;;
    import|*)
        import_settings
        ;;
esac

echo "✅ COSMIC settings handled"
