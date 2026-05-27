# iTerm2 Setup Instructions

## 🔒 Secure Setup (Recommended)

**⚠️ IMPORTANT: iTerm2 settings contain sensitive data** (SSH keys, passwords, API keys, etc.). When migrating from a source computer to a destination computer, **always use iTerm2's secure export/import feature**.

### Export Settings from Source Computer

1. Open iTerm2 on the **source computer**
2. **Preferences** (⌘,) → **General** → **Export Settings...**
3. Save the settings file to a secure location
4. **Securely transfer** to destination computer using:
   - Encrypted USB drive
   - Secure file transfer (scp, rsync over SSH)
   - Encrypted cloud storage with 2FA
   - Password-protected archive

### Import Settings on Destination Computer

1. Open iTerm2 on the **destination computer**
2. **Preferences** (⌘,) → **General** → **Import Settings...**
3. Select the exported settings file
4. Choose what to import (Profiles, Color Presets, etc.)
5. Review and verify imported settings

**This method preserves all settings securely and is the recommended approach for production setups.**

---

## Manual Setup (Alternative Method)

If you prefer to set up manually or are starting fresh, follow these steps:

Setting up iTerm2 manually involves three main steps:

### ✅ Step 1: Import Color Themes (Required)

iTerm2 color themes must be imported through the GUI:

1. **Open iTerm2**
2. **Preferences** (⌘,) → **Profiles** → **Colors**
3. Click **Color Presets** dropdown → **Import...**
4. Navigate to and import each `.itermcolors` file:

   **From `Shell/iTerm/Themes/Dark/`:**
   - `dark-default-gruxbox.itermcolors`
   - `my-custom-gruvbox-soft.itermcolors` ⭐ (used by auto switcher)
   - `projekt0n:github-nvim-theme/github_dark.itermcolors`

   **From `Shell/iTerm/Themes/Light/`:**
   - `github_light/github-light.itermcolors`
   - `inspired-github/inspired-github.itermcolors`
   - `projekt0n:github-nvim-theme/github_light.itermcolors` ⭐ (used by auto switcher)

5. **Restart iTerm2** after importing

### ✅ Step 2: Import Profiles (Optional but Recommended)

Import your profile configurations:

1. **Open iTerm2**
2. **Preferences** (⌘,) → **Profiles**
3. Click **Other Actions...** (gear icon) → **Import JSON Profiles...**
4. Select: `Shell/iTerm/Profiles/Profiles.json`
5. Review imported profiles and set one as default

**Note:** The profiles reference `/Users/admin` - update paths if your username differs.

### ✅ Step 3: Set Up Auto Theme Switcher (Optional)

Automatically switch themes based on macOS appearance:

#### Install Python API:
```bash
pip3 install iterm2
```

#### Install the Script:
```bash
# Copy script to iTerm2's AutoLaunch directory
cp ~/Git_Downloads/Dotfiles/Shell/iTerm/Scripts/AutoLaunch/auto_dark_light_theme_switcher.py \
   ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/

# Update username in script (if needed)
sed -i '' "s|/Users/admin|$HOME|g" \
   ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/auto_dark_light_theme_switcher.py
```

#### Enable in iTerm2:
1. **Scripts** menu → **AutoLaunch** → **auto_dark_light_theme_switcher**
2. Script will auto-start on iTerm2 launch

**Requirements:**
- Themes `my-custom-gruvbox-soft` and `github_light` must be imported (Step 1)
- iTerm2 Python API must be enabled: **Preferences** → **General** → **Magic**

## 🚀 Quick Start

Run the automated setup script:

```bash
cd ~/Git_Downloads/Dotfiles/Shell/iTerm
./setup_iterm.sh
```

Then follow the manual steps it prompts you to complete.

## ⚡ What Gets Set Up

- ✅ Scripts directory structure
- ✅ Auto theme switcher script (copied and configured)
- ✅ Instructions for manual theme import
- ✅ Instructions for profile import

## 🎯 Minimum Required Setup

To get started quickly, you only need:
1. Import at least one color theme (Step 1)
2. Optionally import profiles (Step 2)

The auto theme switcher (Step 3) is optional but recommended for automatic dark/light mode switching.
