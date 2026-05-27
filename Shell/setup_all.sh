#!/bin/bash

# Master Setup Script
# Sets up Homebrew, ZSH, and iTerm2 in the correct order

set -e

DOTFILES_DIR="$HOME/Git_Downloads/Dotfiles"

echo "🚀 Starting complete shell setup..."
echo ""

# Step 1: Homebrew
echo "════════════════════════════════════════"
echo "Step 1/3: Setting up Homebrew"
echo "════════════════════════════════════════"
if [ -f "$DOTFILES_DIR/Homebrew/setup_homebrew.sh" ]; then
    bash "$DOTFILES_DIR/Homebrew/setup_homebrew.sh"
else
    echo "⚠️  Homebrew setup script not found"
fi

echo ""
echo "════════════════════════════════════════"
echo "Step 2/3: Setting up ZSH"
echo "════════════════════════════════════════"

# Step 2: ZSH
if [ -f "$DOTFILES_DIR/Shell/zsh/setup_zsh.sh" ]; then
    bash "$DOTFILES_DIR/Shell/zsh/setup_zsh.sh"
    
    # Install plugins
    if [ -f "$DOTFILES_DIR/Shell/zsh/install_zsh_plugins.sh" ]; then
        echo ""
        read -p "Install ZSH plugins now? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            bash "$DOTFILES_DIR/Shell/zsh/install_zsh_plugins.sh"
        else
            echo "  → Run later: bash $DOTFILES_DIR/Shell/zsh/install_zsh_plugins.sh"
        fi
    fi
else
    echo "⚠️  ZSH setup script not found"
fi

echo ""
echo "════════════════════════════════════════"
echo "Step 3/3: Setting up iTerm2"
echo "════════════════════════════════════════"

# Step 3: iTerm2
if [ -f "$DOTFILES_DIR/Shell/iTerm/setup_iterm.sh" ]; then
    bash "$DOTFILES_DIR/Shell/iTerm/setup_iterm.sh"
else
    echo "⚠️  iTerm2 setup script not found"
fi

echo ""
echo "════════════════════════════════════════"
echo "✅ Setup Complete!"
echo "════════════════════════════════════════"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Set ZSH as default shell:"
echo "   chsh -s \$(which zsh)"
echo ""
echo "2. Restart your terminal or run:"
echo "   exec zsh"
echo ""
echo "3. For iTerm2:"
echo "   - Import color themes (see Shell/iTerm/README.md)"
echo "   - Import profiles (see Shell/iTerm/README.md)"
echo "   - Or use secure export/import from source computer"
echo ""
echo "4. Verify installation:"
echo "   which fzf zoxide nvim"
echo "   zsh -n ~/.zshrc"
echo ""
