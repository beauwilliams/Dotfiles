#!/bin/bash

# ZSH Setup Script
# This script sets up zsh configuration files and directory structure

set -e  # Exit on error

DOTFILES_DIR="$HOME/Git_Downloads/Dotfiles"
ZSH_DOTFILES="$DOTFILES_DIR/Shell/zsh"
OLD_USER="admin"
NEW_USER=$(whoami)

echo "🚀 Setting up ZSH configuration..."

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "❌ zsh is not installed. Please install it first:"
    echo "   brew install zsh"
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p ~/.config/zsh/{configs,functions,scripts,commands,plugins}
mkdir -p ~/.cache/zsh
mkdir -p ~/.zsh

# 1. Set up main zsh config files
echo "⚙️  Setting up main zsh config files..."

# Function to update username in file
update_username() {
    local file="$1"
    if [ -f "$file" ]; then
        sed -i '' "s|/Users/$OLD_USER|$HOME|g" "$file"
        sed -i '' "s|/Users/$OLD_USER|$HOME|g" "$file"  # Run twice for nested paths
    fi
}

# Copy and update .zshrc
if [ -f "$ZSH_DOTFILES/.zshrc" ]; then
    echo "  → Setting up .zshrc..."
    cp "$ZSH_DOTFILES/.zshrc" ~/.zshrc
    update_username ~/.zshrc
    echo "  ✓ .zshrc installed"
else
    echo "  ⚠️  .zshrc not found"
fi

# Copy and update .zprofile
if [ -f "$ZSH_DOTFILES/.zprofile" ]; then
    echo "  → Setting up .zprofile..."
    cp "$ZSH_DOTFILES/.zprofile" ~/.zprofile
    update_username ~/.zprofile
    echo "  ✓ .zprofile installed"
else
    echo "  ⚠️  .zprofile not found"
fi

# Copy and update .zshenv
if [ -f "$ZSH_DOTFILES/.zshenv" ]; then
    echo "  → Setting up .zshenv..."
    cp "$ZSH_DOTFILES/.zshenv" ~/.zshenv
    update_username ~/.zshenv
    echo "  ✓ .zshenv installed"
else
    echo "  ⚠️  .zshenv not found"
fi

# 2. Set up .config/zsh directory structure
echo "📂 Setting up .config/zsh structure..."

# Copy configs
if [ -d "$ZSH_DOTFILES/.config/zsh/configs" ]; then
    echo "  → Copying configs..."
    cp -r "$ZSH_DOTFILES/.config/zsh/configs/"* ~/.config/zsh/configs/ 2>/dev/null || true
    find ~/.config/zsh/configs -type f -exec update_username {} \;
    echo "  ✓ Configs installed"
fi

# Copy functions
if [ -d "$ZSH_DOTFILES/.config/zsh/functions" ]; then
    echo "  → Copying functions..."
    cp -r "$ZSH_DOTFILES/.config/zsh/functions/"* ~/.config/zsh/functions/ 2>/dev/null || true
    find ~/.config/zsh/functions -type f | while read file; do update_username "$file"; done
    echo "  ✓ Functions installed"
fi

# Copy scripts
if [ -d "$ZSH_DOTFILES/.config/zsh/scripts" ]; then
    echo "  → Copying scripts..."
    cp -r "$ZSH_DOTFILES/.config/zsh/scripts/"* ~/.config/zsh/scripts/ 2>/dev/null || true
    find ~/.config/zsh/scripts -type f | while read file; do update_username "$file"; done
    chmod +x ~/.config/zsh/scripts/*.sh 2>/dev/null || true
    echo "  ✓ Scripts installed"
fi

# Copy commands
if [ -d "$ZSH_DOTFILES/.config/zsh/commands" ]; then
    echo "  → Copying commands..."
    cp -r "$ZSH_DOTFILES/.config/zsh/commands/"* ~/.config/zsh/commands/ 2>/dev/null || true
    find ~/.config/zsh/commands -type f | while read file; do update_username "$file"; done
    chmod +x ~/.config/zsh/commands/*.sh 2>/dev/null || true
    echo "  ✓ Commands installed"
fi

# Copy plugins (only the ones that exist in dotfiles)
if [ -d "$ZSH_DOTFILES/.config/zsh/plugins" ]; then
    echo "  → Copying local plugins..."
    cp -r "$ZSH_DOTFILES/.config/zsh/plugins/"* ~/.config/zsh/plugins/ 2>/dev/null || true
    find ~/.config/zsh/plugins -type f | while read file; do update_username "$file"; done
    echo "  ✓ Local plugins installed"
fi

# 3. Check for required external plugins and tools
echo "🔍 Checking for required plugins and tools..."

check_tool() {
    local tool="$1"
    local install_cmd="$2"
    if command -v "$tool" &> /dev/null; then
        echo "  ✓ $tool is installed"
        return 0
    else
        echo "  ⚠️  $tool is not installed"
        if [ -n "$install_cmd" ]; then
            echo "     Install with: $install_cmd"
        fi
        return 1
    fi
}

# Check for required tools
check_tool "fzf" "brew install fzf"
check_tool "zoxide" "brew install zoxide"
check_tool "lua" "brew install lua"
check_tool "bat" "brew install bat"
check_tool "exa" "brew install exa || brew install eza"  # exa is deprecated, eza is the replacement
check_tool "nvim" "brew install neovim"

# Check for Python tools
if python3 -c "import argcomplete" 2>/dev/null; then
    echo "  ✓ python-argcomplete is installed"
else
    echo "  ⚠️  python-argcomplete is not installed"
    echo "     Install with: pip3 install argcomplete"
fi

# 4. Check for zsh plugins that need to be installed
echo ""
echo "📦 Required ZSH plugins (install manually if needed):"
echo ""
echo "  These plugins should be installed in ~/.config/zsh/plugins/:"
echo ""
echo "  • powerlevel10k:"
echo "    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/plugins/powerlevel10k"
echo ""
echo "  • zsh-autosuggestions:"
echo "    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions"
echo ""
echo "  • fast-syntax-highlighting:"
echo "    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.config/zsh/plugins/fast-syntax-highlighting"
echo ""
echo "  • enhancd:"
echo "    git clone https://github.com/b4b4r07/enhancd ~/.config/zsh/plugins/enhancd"
echo ""
echo "  • zsh-completions:"
echo "    git clone https://github.com/zsh-users/zsh-completions ~/.config/zsh/plugins/zsh-completions"
echo ""
echo "  • alias-tips:"
echo "    git clone https://github.com/djui/alias-tips.git ~/.config/zsh/plugins/alias-tips"
echo ""
echo "  • plugin-osx:"
echo "    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/zsh/plugins/ohmyzsh-temp"
echo "    cp -r ~/.config/zsh/plugins/ohmyzsh-temp/plugins/osx ~/.config/zsh/plugins/plugin-osx"
echo "    rm -rf ~/.config/zsh/plugins/ohmyzsh-temp"
echo ""
echo "  • hacker-quotes:"
echo "    git clone https://github.com/oldratlee/hacker-quotes ~/.config/zsh/plugins/hacker-quotes"
echo ""
echo "  • zsh-vim-mode:"
echo "    git clone https://github.com/softmoth/zsh-vim-mode ~/.config/zsh/plugins/zsh-vim-mode"
echo ""
echo "  • fzf-tab:"
echo "    git clone https://github.com/Aloxaf/fzf-tab ~/.config/zsh/plugins/fzf-tab"
echo ""
echo "  • z.lua:"
echo "    git clone https://github.com/skywind3000/z.lua.git ~/.config/zsh/plugins/z.lua"
echo ""

# 5. Check for optional external tools
echo "🔧 Optional tools (referenced in config):"
check_tool "sdkman" ""  # SDKMAN needs manual installation
check_tool "bun" "curl -fsSL https://bun.sh/install | bash"
check_tool "nvm" "brew install nvm"

# Check for awesome-fzf
if [ -d "$HOME/Git_Downloads/awesome-fzf" ]; then
    echo "  ✓ awesome-fzf found at ~/Git_Downloads/awesome-fzf"
else
    echo "  ⚠️  awesome-fzf not found"
    echo "     Clone with: git clone <repo-url> ~/Git_Downloads/awesome-fzf"
fi

echo ""
echo "✅ ZSH setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Install required plugins (see list above)"
echo "   2. Install missing tools (see warnings above)"
echo "   3. Set zsh as your default shell:"
echo "      chsh -s $(which zsh)"
echo "   4. Restart your terminal or run: exec zsh"
echo ""
echo "💡 Tip: You can install all plugins at once with:"
echo "   ./install_zsh_plugins.sh (if available)"
