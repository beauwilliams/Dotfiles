#!/bin/bash

# iTerm2 Setup Script
# This script sets up iTerm2 profiles, color themes, and auto theme switcher

set -e  # Exit on error

DOTFILES_DIR="$HOME/Git_Downloads/Dotfiles"
ITERM_DIR="$HOME/Library/Application Support/iTerm2"
ITERM_DOTFILES="$DOTFILES_DIR/Shell/iTerm"

echo "🚀 Setting up iTerm2 configuration..."

# Check if iTerm2 is installed
if [ ! -d "$ITERM_DIR" ]; then
    echo "❌ iTerm2 directory not found. Please install iTerm2 first."
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p "$ITERM_DIR/Scripts"
mkdir -p "$ITERM_DIR/Scripts/AutoLaunch"

# 1. Import Color Themes
echo "🎨 Importing color themes..."
THEMES_DIR="$ITERM_DOTFILES/Themes"

# Function to import a theme
import_theme() {
    local theme_file="$1"
    local theme_name=$(basename "$theme_file" .itermcolors)
    
    if [ -f "$theme_file" ]; then
        echo "  → Importing $theme_name..."
        # Open the theme file with iTerm2 to import it
        open -a iTerm "$theme_file" 2>/dev/null || true
        # Alternative: Use defaults command (may not work for all versions)
        # We'll use the manual import method via AppleScript
    fi
}

# Import dark themes
if [ -d "$THEMES_DIR/Dark" ]; then
    find "$THEMES_DIR/Dark" -name "*.itermcolors" -type f | while read theme; do
        import_theme "$theme"
    done
fi

# Import light themes
if [ -d "$THEMES_DIR/Light" ]; then
    find "$THEMES_DIR/Light" -name "*.itermcolors" -type f | while read theme; do
        import_theme "$theme"
    done
fi

echo "  ⚠️  Note: Color themes need to be manually imported in iTerm2:"
echo "     Preferences → Profiles → Colors → Color Presets → Import..."
echo "     Then select each .itermcolors file from: $THEMES_DIR"

# 2. Copy Auto Theme Switcher Script
echo "🔄 Setting up auto theme switcher..."
SCRIPT_SRC="$ITERM_DOTFILES/Scripts/AutoLaunch/auto_dark_light_theme_switcher.py"

# Check for both possible iTerm2 script locations (old and new)
ITERM_SCRIPT_DIR_OLD="$ITERM_DIR/Scripts/AutoLaunch"
ITERM_SCRIPT_DIR_NEW="$HOME/.config/iterm2/AppSupport/Scripts/AutoLaunch"
SCRIPT_DST_OLD="$ITERM_SCRIPT_DIR_OLD/auto_dark_light_theme_switcher.py"
SCRIPT_DST_NEW="$ITERM_SCRIPT_DIR_NEW/auto_dark_light_theme_switcher.py"

# Determine which location to use
if [ -d "$ITERM_SCRIPT_DIR_NEW" ]; then
    SCRIPT_DST="$SCRIPT_DST_NEW"
    mkdir -p "$ITERM_SCRIPT_DIR_NEW"
elif [ -d "$ITERM_SCRIPT_DIR_OLD" ]; then
    SCRIPT_DST="$SCRIPT_DST_OLD"
    mkdir -p "$ITERM_SCRIPT_DIR_OLD"
else
    # Default to old location
    SCRIPT_DST="$SCRIPT_DST_OLD"
    mkdir -p "$ITERM_SCRIPT_DIR_OLD"
fi

if [ -f "$SCRIPT_SRC" ]; then
    # Find system Python
    SYSTEM_PYTHON=$(which python3)
    if [ -z "$SYSTEM_PYTHON" ]; then
        SYSTEM_PYTHON="/usr/bin/python3"
    fi
    
    # Copy script and update username and Python path
    sed "s|/Users/admin|$HOME|g" "$SCRIPT_SRC" | \
    sed "1s|#!/usr/bin/env python3|#!$SYSTEM_PYTHON|" > "$SCRIPT_DST"
    chmod +x "$SCRIPT_DST"
    echo "  ✓ Auto theme switcher script installed to: $SCRIPT_DST"
    echo "  ✓ Configured to use system Python: $SYSTEM_PYTHON"
    echo "  → To enable: iTerm2 → Scripts → AutoLaunch → auto_dark_light_theme_switcher"
    echo ""
    echo "  ⚠️  IMPORTANT: If script still fails, configure iTerm2 Python path:"
    echo "     Preferences → General → Magic → Python API → Set to: $SYSTEM_PYTHON"
else
    echo "  ⚠️  Auto theme switcher script not found at $SCRIPT_SRC"
fi

# 3. Import Profiles
echo "⚙️  Setting up profiles..."
PROFILES_FILE="$ITERM_DOTFILES/Profiles/Profiles.json"

if [ -f "$PROFILES_FILE" ]; then
    echo "  → Profiles configuration found"
    echo "  ⚠️  Note: Profiles need to be manually imported:"
    echo "     Preferences → Profiles → Other Actions → Import JSON Profiles..."
    echo "     Then select: $PROFILES_FILE"
    echo ""
    echo "     Or use the command line:"
    echo "     defaults read com.googlecode.iterm2"
    echo "     (then manually merge the JSON)"
else
    echo "  ⚠️  Profiles.json not found at $PROFILES_FILE"
fi

# 4. Check for iterm2 Python API
echo "🐍 Checking for iTerm2 Python API..."
if python3 -c "import iterm2" 2>/dev/null; then
    echo "  ✓ iterm2 Python package is installed"
else
    echo "  ⚠️  iterm2 Python package not found"
    echo "     Install with: pip3 install iterm2"
fi

echo ""
echo "✅ iTerm2 setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Import color themes manually (see instructions above)"
echo "   2. Import profiles manually (see instructions above)"
echo "   3. Enable the auto theme switcher script in iTerm2"
echo "   4. Restart iTerm2 to apply all changes"
echo ""
echo "💡 Tip: You can also use iTerm2's built-in import features:"
echo "   - Preferences → Profiles → Colors → Color Presets → Import..."
echo "   - Preferences → Profiles → Other Actions → Import JSON Profiles..."
