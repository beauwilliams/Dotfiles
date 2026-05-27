#!/bin/bash

# ZSH Plugins Installer
# Installs all required zsh plugins

set -e

PLUGINS_DIR="$HOME/.config/zsh/plugins"

echo "📦 Installing ZSH plugins..."

mkdir -p "$PLUGINS_DIR"

install_plugin() {
    local name="$1"
    local repo="$2"
    local path="$3"
    
    # Check if directory exists and has content (not just empty)
    if [ -d "$PLUGINS_DIR/$path" ] && [ "$(ls -A "$PLUGINS_DIR/$path" 2>/dev/null)" ]; then
        echo "  ✓ $name already installed"
    else
        # Remove empty directory if it exists
        [ -d "$PLUGINS_DIR/$path" ] && rmdir "$PLUGINS_DIR/$path" 2>/dev/null || true
        echo "  → Installing $name..."
        git clone --depth=1 "$repo" "$PLUGINS_DIR/$path" 2>/dev/null || {
            echo "  ⚠️  Failed to install $name"
            return 1
        }
        echo "  ✓ $name installed"
    fi
}

# Install plugins
install_plugin "powerlevel10k" "https://github.com/romkatv/powerlevel10k.git" "powerlevel10k"
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git" "zsh-autosuggestions"
install_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" "fast-syntax-highlighting"
install_plugin "enhancd" "https://github.com/b4b4r07/enhancd.git" "enhancd"
install_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions.git" "zsh-completions"
install_plugin "alias-tips" "https://github.com/djui/alias-tips.git" "alias-tips"
install_plugin "hacker-quotes" "https://github.com/oldratlee/hacker-quotes.git" "hacker-quotes"
install_plugin "zsh-vim-mode" "https://github.com/softmoth/zsh-vim-mode.git" "zsh-vim-mode"
install_plugin "fzf-tab" "https://github.com/Aloxaf/fzf-tab.git" "fzf-tab"
install_plugin "z.lua" "https://github.com/skywind3000/z.lua.git" "z.lua"

# Special case for plugin-osx (from ohmyzsh)
if [ ! -d "$PLUGINS_DIR/plugin-osx" ]; then
    echo "  → Installing plugin-osx..."
    if [ ! -d "$PLUGINS_DIR/ohmyzsh-temp" ]; then
        git clone --depth=1 "https://github.com/ohmyzsh/ohmyzsh.git" "$PLUGINS_DIR/ohmyzsh-temp"
    fi
    cp -r "$PLUGINS_DIR/ohmyzsh-temp/plugins/osx" "$PLUGINS_DIR/plugin-osx"
    rm -rf "$PLUGINS_DIR/ohmyzsh-temp"
    echo "  ✓ plugin-osx installed"
else
    echo "  ✓ plugin-osx already installed"
fi

echo ""
echo "✅ All plugins installed!"
