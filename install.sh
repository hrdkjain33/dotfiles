#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    log_error "Cannot detect OS. /etc/os-release not found."
    exit 1
fi

log_info "Detected OS: $OS"

# Common packages (names might vary slightly, handled in case statement)
# Core: hyprland, alacritty, rofi-wayland, waybar, hyprpaper, hyprlock, hypridle
# Utils: brightnessctl, playerctl, nautilus, tmux, unzip, git, stow
# Neovim: neovim, ripgrep, fd, npm, nodejs
# Apps: firefox
# Audio: pipewire, wireplumber
# Fonts: jetbrains-mono-nerd, noto-fonts, noto-fonts-emoji

install_arch() {
    log_info "Starting Arch Linux installation..."

    # Update system
    log_info "Updating system..."
    sudo pacman -Syu --noconfirm

    # Install base tools
    log_info "Installing base tools..."
    sudo pacman -S --needed --noconfirm git stow base-devel

    # Install AUR helper (yay) if not present
    if ! command -v yay &> /dev/null; then
        log_info "Installing yay..."
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    else
        log_info "yay is already installed."
    fi

    # Package list
    PACKAGES=(
        hyprland
        alacritty
        rofi-wayland
        waybar
        hyprpaper
        hyprlock
        hypridle
        hyprshot
        hyprsunset
        brightnessctl
        playerctl
        nautilus
        tmux
        neovim
        ripgrep
        fd
        unzip
        npm
        nodejs
        firefox
        visual-studio-code-bin
        rnote
        pipewire
        wireplumber
        opentabletdriver
        ttf-jetbrains-mono-nerd
        noto-fonts
        noto-fonts-emoji
    )

    log_info "Installing packages..."
    yay -S --needed --noconfirm "${PACKAGES[@]}"
}

install_fedora() {
    log_info "Starting Fedora installation..."

    # Update system
    log_info "Updating system..."
    sudo dnf update -y

    # Install base tools
    log_info "Installing base tools..."
    sudo dnf install -y git stow @development-tools

    # Enable COPRs if needed (Solopasha is common for Hyprland on older Fedora, but F39+ has it)
    # Checking version to be safe, but assuming modern Fedora
    
    # Package list
    # Note: Some packages might be named differently or need Flatpak
    PACKAGES=(
        hyprland
        alacritty
        rofi-wayland
        waybar
        hyprpaper
        hyprlock
        hypridle
        brightnessctl
        playerctl
        nautilus
        tmux
        neovim
        ripgrep
        fd-find
        unzip
        npm
        nodejs
        firefox
        pipewire
        wireplumber
        opentabletdriver
        jetbrains-mono-fonts
        google-noto-fonts-common
        google-noto-emoji-fonts
    )

    log_info "Installing packages..."
    sudo dnf install -y "${PACKAGES[@]}"

    # Handle packages missing from standard repos or named differently
    # Hyprshot/Hyprsunset might need manual install or COPR
    log_warn "Some packages like hyprshot, hyprsunset, visual-studio-code, rnote might need manual installation or Flatpak on Fedora."
    
    # VS Code (official repo)
    log_info "Setting up VS Code repo..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install -y code
}

case $OS in
    arch)
        install_arch
        ;;
    fedora)
        install_fedora
        ;;
    *)
        log_error "Unsupported OS: $OS. This script only supports Arch Linux and Fedora."
        exit 1
        ;;
esac

# Common configuration steps
log_info "Setting up dotfiles..."
if [ -f "./stow.sh" ]; then
    ./stow.sh
else
    log_warn "stow.sh not found in current directory. Skipping dotfiles linking."
fi

# Enable services
log_info "Enabling services..."
systemctl --user enable --now opentabletdriver.service

log_success "Installation complete! Please restart your session or reboot."
