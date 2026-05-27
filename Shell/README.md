# Shell Configuration

Complete shell setup for macOS including iTerm2, ZSH, and Homebrew.

## 📁 Directory Structure

```
Shell/
├── iTerm/              # iTerm2 configuration
│   ├── Profiles/       # Profile configurations
│   ├── Themes/         # Color themes (dark/light)
│   ├── Scripts/        # Automation scripts
│   └── setup_iterm.sh  # Setup script
├── zsh/                # ZSH configuration
│   ├── .zshrc         # Main zsh config
│   ├── .zprofile      # Profile config
│   ├── .zshenv        # Environment config
│   ├── .config/zsh/   # ZSH config directory
│   ├── setup_zsh.sh   # Setup script
│   └── install_zsh_plugins.sh  # Plugin installer
└── SETUP.md           # Complete setup guide
```

## 🚀 Quick Start

### Option 1: Complete Automated Setup

Run the master setup script:

```bash
cd ~/Git_Downloads/Dotfiles/Shell
bash setup_all.sh
```

This will set up everything in the correct order:
1. Homebrew (package manager and dependencies)
2. ZSH (shell configuration)
3. iTerm2 (terminal application)

### Option 2: Step-by-Step Setup

Follow the detailed guide in [`SETUP.md`](./SETUP.md) for step-by-step instructions.

## 📚 Documentation

- **[SETUP.md](./SETUP.md)** - Complete setup guide with troubleshooting
- **[iTerm/README.md](./iTerm/README.md)** - iTerm2 configuration guide
- **[iTerm/SETUP_INSTRUCTIONS.md](./iTerm/SETUP_INSTRUCTIONS.md)** - Quick iTerm2 setup reference
- **[zsh/.zshrc](../Shell/zsh/.zshrc)** - ZSH configuration file

## 🔒 Security Note

**⚠️ IMPORTANT:** iTerm2 settings may contain sensitive data (SSH keys, passwords, API keys). When migrating between computers, use iTerm2's secure export/import feature:

1. **Source computer**: Preferences → General → Export Settings...
2. **Securely transfer** the exported file
3. **Destination computer**: Preferences → General → Import Settings...

See [iTerm/README.md](./iTerm/README.md) for detailed instructions.

## 🛠️ Setup Scripts

- `setup_all.sh` - Master script (sets up everything)
- `Homebrew/setup_homebrew.sh` - Install Homebrew and packages
- `zsh/setup_zsh.sh` - Set up ZSH configuration
- `zsh/install_zsh_plugins.sh` - Install ZSH plugins
- `iTerm/setup_iterm.sh` - Set up iTerm2

## ✅ Verification

After setup, verify everything works:

```bash
# Check shell
echo $SHELL  # Should be /bin/zsh or /usr/bin/zsh

# Check tools
which fzf zoxide nvim bat

# Test zsh config
zsh -n ~/.zshrc
```

## 🔄 Updating

### Update Homebrew Packages
```bash
brew update && brew upgrade
brew bundle --file=~/Git_Downloads/Dotfiles/Homebrew/Brewfile
```

### Update ZSH Plugins
```bash
cd ~/.config/zsh/plugins
for dir in */; do cd "$dir" && git pull && cd ..; done
```

## 📖 Features

### ZSH Features
- Powerlevel10k theme
- Syntax highlighting
- Auto-suggestions
- FZF integration
- Zoxide (smart cd)
- Vim mode
- Git integration
- Custom aliases and functions

### iTerm2 Features
- Auto theme switching (dark/light mode)
- Multiple profiles
- Custom color themes
- Status bar with system info
- Powerline glyphs support

### Homebrew Packages
- Development tools (git, neovim, go, node, etc.)
- CLI utilities (fzf, bat, ripgrep, etc.)
- Fonts (Hack Nerd Font)
- Applications (Android Studio, etc.)

## 🐛 Troubleshooting

See [SETUP.md](./SETUP.md) for detailed troubleshooting guide.

Common issues:
- **ZSH slow**: First load may be slow, subsequent loads are faster
- **Plugins missing**: Run `install_zsh_plugins.sh`
- **iTerm themes not working**: Make sure themes are imported
- **Homebrew errors**: Check internet connection and run `brew doctor`
