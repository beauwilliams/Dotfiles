# iTerm2 Setup Guide

This directory contains iTerm2 configuration files including profiles, color themes, and automation scripts.

## 📁 Directory Structure

```
Shell/iTerm/
├── Profiles/
│   └── Profiles.json          # iTerm2 profile configurations
├── Themes/
│   ├── Dark/                  # Dark mode color themes
│   └── Light/                 # Light mode color themes
├── Scripts/
│   ├── auto_dark_light_theme_switcher.py  # Manual script
│   └── AutoLaunch/
│       └── auto_dark_light_theme_switcher.py  # Auto-launch script
└── setup_iterm.sh             # Automated setup script
```

## 🔒 Secure Setup (Recommended for Production)

**⚠️ IMPORTANT: iTerm2 settings may contain sensitive data** (SSH keys, passwords, API keys, etc.). When migrating from a source computer to a destination computer, use iTerm2's built-in export/import feature to securely transfer settings.

### Export Settings from Source Computer

1. Open iTerm2 on the **source computer**
2. Go to **Preferences** (⌘,)
3. Click **General** → **Export Settings...**
4. Choose a secure location to save the settings file
5. **Securely transfer** this file to the destination computer (using encrypted methods like:
   - Encrypted USB drive
   - Secure file transfer (scp, rsync over SSH)
   - Encrypted cloud storage with 2FA
   - Password-protected archive)

### Import Settings on Destination Computer

1. Open iTerm2 on the **destination computer**
2. Go to **Preferences** (⌘,)
3. Click **General** → **Import Settings...**
4. Select the exported settings file
5. Choose what to import (Profiles, Color Presets, etc.)
6. Review imported settings and verify paths/usernames if needed

**Note:** This method preserves all settings including profiles, color themes, key bindings, and scripts, while maintaining security of sensitive data.

## 🚀 Quick Setup (Alternative Method)

### Option 1: Automated Setup

Run the setup script:

```bash
cd ~/Git_Downloads/Dotfiles/Shell/iTerm
./setup_iterm.sh
```

This will:
- Create necessary directories
- Copy the auto theme switcher script
- Provide instructions for manual steps

### Option 2: Manual Setup

Follow the steps below for manual installation.

## 📝 Manual Setup Steps

### 1. Import Color Themes

iTerm2 color themes (`.itermcolors` files) need to be imported manually:

1. Open iTerm2
2. Go to **Preferences** → **Profiles** → **Colors**
3. Click **Color Presets** → **Import...**
4. Navigate to `Shell/iTerm/Themes/` and import each theme:
   - **Dark themes:**
     - `Dark/dark-default-gruxbox.itermcolors`
     - `Dark/my-custom-gruvbox-soft.itermcolors`
     - `Dark/projekt0n:github-nvim-theme/github_dark.itermcolors`
   - **Light themes:**
     - `Light/github_light/github-light.itermcolors`
     - `Light/inspired-github/inspired-github.itermcolors`
     - `Light/projekt0n:github-nvim-theme/github_light.itermcolors`

### 2. Import Profiles

To import the profile configurations:

1. Open iTerm2
2. Go to **Preferences** → **Profiles**
3. Click **Other Actions...** → **Import JSON Profiles...**
4. Select `Shell/iTerm/Profiles/Profiles.json`

**Note:** The profiles reference `/Users/admin` - you may need to update paths after import if your username is different.

### 3. Set Up Auto Theme Switcher

The auto theme switcher automatically changes iTerm2 themes based on macOS system appearance (dark/light mode).

#### Prerequisites

Install the iTerm2 Python API:

```bash
pip3 install iterm2
```

#### Installation

1. Copy the script to iTerm2's Scripts directory:
   ```bash
   cp Shell/iTerm/Scripts/AutoLaunch/auto_dark_light_theme_switcher.py \
      ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/
   ```

2. Update the script with your username (if different from `admin`):
   ```bash
   sed -i '' 's|/Users/admin|$HOME|g' \
      ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/auto_dark_light_theme_switcher.py
   ```

3. Enable the script in iTerm2:
   - Open iTerm2
   - Go to **Scripts** menu → **AutoLaunch** → **auto_dark_light_theme_switcher**
   - The script will start automatically on iTerm2 launch

#### How It Works

The script monitors macOS system theme changes and automatically switches iTerm2 color presets:
- **Dark mode** → `my-custom-gruvbox-soft`
- **Light mode** → `github_light`

Make sure these color presets are imported (see step 1) before enabling the script.

## 🔧 Profile Configuration

The `Profiles.json` contains three profiles:

1. **Default** - Main profile with Hack Nerd Font, powerline glyphs, and status bar
2. **Dropdown Window** - Hotkey-activated dropdown window profile
3. **Test** - Additional test profile

### Key Features

- **Font:** Hack Nerd Font Complete (Regular 12-13pt)
- **Terminal Type:** xterm-256color
- **Powerline Glyphs:** Enabled
- **Status Bar:** CPU, Memory, Network utilization
- **Unlimited Scrollback:** Enabled
- **Transparency:** Minimal blur effect

## 🎨 Available Themes

### Dark Themes
- `dark-default-gruxbox` - Gruvbox dark variant
- `my-custom-gruvbox-soft` - Custom soft gruvbox (used by auto switcher)
- `github_dark` - GitHub dark theme

### Light Themes
- `github-light` - GitHub light theme (used by auto switcher)
- `inspired-github` - Inspired GitHub theme
- `github_light` - Alternative GitHub light theme

## 🐛 Troubleshooting

### Script Not Working

1. Check if `iterm2` Python package is installed:
   ```bash
   python3 -c "import iterm2"
   ```

2. Verify the script is in the correct location:
   ```bash
   ls ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/
   ```

3. Check iTerm2 Scripts menu is enabled:
   - **Preferences** → **General** → **Magic** → Enable Python API

### Themes Not Appearing

- Make sure you've imported the `.itermcolors` files (see step 1)
- Restart iTerm2 after importing themes
- Check that theme names match exactly (case-sensitive)

### Profiles Not Importing

- Ensure the JSON file is valid
- Check for path references that need updating (e.g., `/Users/admin` → your username)
- Try importing one profile at a time

## 📚 Additional Resources

- [iTerm2 Documentation](https://iterm2.com/documentation.html)
- [iTerm2 Python API](https://iterm2.com/python-api/)
- [iTerm2 Color Schemes](https://iterm2colorschemes.com/)
