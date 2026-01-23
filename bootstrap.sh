#!/bin/bash
# bootstrap.sh - Pop OS / COSMIC Environment Bootstrap
# Run this on a fresh system to get your full environment set up

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }

echo ""
echo "🚀 Pop OS / COSMIC Environment Bootstrap"
echo "========================================="
echo ""

# 1. Update system
log_info "Updating system..."
sudo apt update && sudo apt upgrade -y

# 2. Install essential tools
log_info "Installing essential tools..."
sudo apt install -y git stow curl wget

# 3. Run modular installers
MODULES=(base dev-tools fonts apps)
for module in "${MODULES[@]}"; do
    if [ -f "$SCRIPT_DIR/modules/$module.sh" ]; then
        log_info "Running module: $module"
        bash "$SCRIPT_DIR/modules/$module.sh"
    else
        log_warn "Module not found: $module"
    fi
done

# 4. Setup zsh with oh-my-zsh
log_info "Setting up zsh..."
bash "$SCRIPT_DIR/modules/zsh-setup.sh"

# 5. Link configs with stow
log_info "Linking configurations with stow..."
bash "$SCRIPT_DIR/stow.sh"

# 6. Apply COSMIC settings if available
if [ -f "$SCRIPT_DIR/modules/cosmic-settings.sh" ]; then
    log_info "Applying COSMIC settings..."
    bash "$SCRIPT_DIR/modules/cosmic-settings.sh"
fi

# 7. Optional: Whisper dictation
echo ""
read -p "Install whisper dictation module? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/whisper/install.sh"
fi

echo ""
log_success "========================================="
log_success "Setup complete!"
log_success "========================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Log out and back in to apply all changes"
echo ""
