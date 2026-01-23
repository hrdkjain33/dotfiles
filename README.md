# Dotfiles

Pop OS / COSMIC environment setup. One command to get a fully working system.

## Quick Start

```bash
# On a fresh system:
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

## What Gets Installed

| Module | Contents |
|--------|----------|
| `base` | git, stow, curl, htop, btop, neofetch |
| `dev-tools` | neovim, tmux, ripgrep, fd, fzf, node, python |
| `fonts` | JetBrains Mono Nerd Font, FiraCode Nerd Font |
| `apps` | alacritty, VS Code, Discord, LibreWolf, Rnote |
| `zsh-setup` | zsh, oh-my-zsh, autosuggestions, syntax-highlighting |

## Structure

```
dotfiles/
├── bootstrap.sh      # Main entry point - run this!
├── stow.sh           # Links configs to ~
├── modules/          # Modular installers
│   ├── base.sh
│   ├── dev-tools.sh
│   ├── fonts.sh
│   ├── apps.sh
│   ├── zsh-setup.sh
│   └── cosmic-settings.sh
├── configs/          # Stow packages (symlinked to ~)
│   ├── nvim/
│   ├── tmux/
│   ├── alacritty/
│   ├── zsh/
│   ├── git/
│   └── ruff/
├── cosmic/           # COSMIC DE settings
│   └── export-settings.sh
├── archive/          # Old Hyprland configs
└── whisper/          # Voice dictation module
```

## Individual Commands

```bash
# Run individual modules
./modules/fonts.sh
./modules/dev-tools.sh

# Re-link configs only
./stow.sh

# Export current COSMIC settings
./cosmic/export-settings.sh

# Install whisper dictation
./whisper/install.sh
```

## Customization

- Edit `configs/zsh/.zshrc` for shell customizations
- Add machine-specific settings in `~/.zshrc.local` (not tracked)
- Edit `configs/git/.gitconfig` - update email!

## Adding New Configs

1. Create a new folder in `configs/`:
   ```bash
   mkdir -p configs/myapp/.config/myapp
   ```
2. Add your config files there
3. Run `./stow.sh` to link them
