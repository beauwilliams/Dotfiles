#!/bin/bash

# Homebrew Setup Script
# Installs Homebrew and all packages from Brewfile

set -e

DOTFILES_DIR="$HOME/Git_Downloads/Dotfiles"
BREWFILE="$DOTFILES_DIR/Homebrew/Brewfile"

echo "🍺 Setting up Homebrew..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH (for Apple Silicon Macs)
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "  ✓ Homebrew installed"
else
    echo "  ✓ Homebrew is already installed"
    brew --version
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Install packages from Brewfile
if [ -f "$BREWFILE" ]; then
    echo "📦 Installing packages from Brewfile..."
    echo "  → This may take a while..."
    brew bundle --file="$BREWFILE" --verbose
    echo "  ✓ All packages installed"
else
    echo "  ⚠️  Brewfile not found at $BREWFILE"
    exit 1
fi

# Run post-install setup
echo "🔧 Running post-install setup..."

# Setup fzf key bindings and fuzzy completion
if command -v fzf &> /dev/null; then
    echo "  → Setting up fzf..."
    $(brew --prefix)/opt/fzf/install --all || true
    echo "  ✓ fzf configured"
fi

# Setup gitstatus (for powerlevel10k)
if command -v gitstatus &> /dev/null; then
    echo "  ✓ gitstatus installed"
fi

echo ""
echo "✅ Homebrew setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Restart your terminal or run: source ~/.zprofile"
echo "   2. Verify installations: brew list"
echo "   3. Check for any issues: brew doctor"
