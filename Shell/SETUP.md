# Shell Setup Guide

Complete setup guide for iTerm2, ZSH, and Homebrew.

## 📋 Setup Order

1. **Homebrew** - Install package manager and dependencies
2. **ZSH** - Set up shell configuration
3. **iTerm2** - Configure terminal application

## 🍺 Step 1: Homebrew Setup

### Install Homebrew and All Packages

```bash
cd ~/Git_Downloads/Dotfiles/Homebrew
bash setup_homebrew.sh
```

This will:
- Install Homebrew (if not already installed)
- Install all packages from `Brewfile` (includes fzf, zoxide, neovim, etc.)
- Set up fzf key bindings
- Configure gitstatus for powerlevel10k

**Note:** This may take 15-30 minutes depending on your internet connection.
**Note:** On Apple Silicon, Rosetta 2 is required for some Python runtimes. Install with:

```bash
softwareupdate --install-rosetta --agree-to-license
```

### Verify Installation

```bash
brew list
brew doctor
```

## 🐚 Step 2: ZSH Setup

### Install ZSH Configuration

```bash
cd ~/Git_Downloads/Dotfiles/Shell/zsh
bash setup_zsh.sh
```

This will:
- Copy `.zshrc`, `.zprofile`, `.zshenv` to your home directory
- Set up `.config/zsh/` directory structure
- Update all paths from `/Users/admin` to your username
- Check for required tools and plugins

### Install ZSH Plugins

```bash
cd ~/Git_Downloads/Dotfiles/Shell/zsh
bash install_zsh_plugins.sh
```

This installs all required plugins:
- powerlevel10k (theme)
- zsh-autosuggestions
- fast-syntax-highlighting
- enhancd
- zsh-completions
- alias-tips
- plugin-osx
- hacker-quotes
- zsh-vim-mode
- fzf-tab
- z.lua

### Set ZSH as Default Shell

```bash
chsh -s $(which zsh)
```

### Restart Terminal

Close and reopen your terminal, or run:

```bash
exec zsh
```

## 🖥️ Step 3: iTerm2 Setup

### 🔒 Secure Setup (Recommended for Production)

**⚠️ IMPORTANT: iTerm2 settings contain sensitive data** (SSH keys, passwords, API keys, etc.). When migrating from a source computer, use iTerm2's secure export/import.

#### Export from Source Computer

1. Open iTerm2 on **source computer**
2. **Preferences** (⌘,) → **General** → **Export Settings...**
3. Save to secure location
4. **Securely transfer** to destination (encrypted USB, scp, encrypted cloud storage)

#### Import on Destination Computer

1. Open iTerm2 on **destination computer**
2. **Preferences** (⌘,) → **General** → **Import Settings...**
3. Select exported settings file
4. Choose what to import
5. Review and verify settings

### Alternative: Manual Setup

If starting fresh or prefer manual setup:

```bash
cd ~/Git_Downloads/Dotfiles/Shell/iTerm
bash setup_iterm.sh
```

Then follow the manual steps:
1. Import color themes (Preferences → Profiles → Colors → Color Presets → Import...)
2. Import profiles (Preferences → Profiles → Other Actions → Import JSON Profiles...)
3. Enable auto theme switcher (Scripts → AutoLaunch)

See `Shell/iTerm/README.md` for detailed instructions.

## ✅ Verification

After setup, verify everything works:

```bash
# Check zsh is default
echo $SHELL

# Check plugins are loaded
zsh -c 'echo $ZSH_PLUGINS'

# Check tools are installed
which fzf zoxide nvim bat

# Test zsh config
zsh -n ~/.zshrc
```

## 🐛 Troubleshooting

### ZSH Issues

- **Plugins not loading**: Check `~/.config/zsh/plugins/` directory exists and plugins are installed
- **Slow startup**: Some plugins may need time to initialize on first load
- **Path issues**: Verify `~/.zprofile` has correct Homebrew paths

### iTerm2 Issues

- **Themes not appearing**: Make sure themes are imported (Preferences → Profiles → Colors)
- **Script not working**: Check iTerm2 Python API is enabled (Preferences → General → Magic)
- **Profiles not importing**: Verify JSON file is valid and paths are updated

### Homebrew Issues

- **Installation fails**: Check internet connection and try `brew update`
- **Packages missing**: Run `brew bundle --file=~/Git_Downloads/Dotfiles/Homebrew/Brewfile` again
- **Permission errors**: May need to run with `sudo` for some operations

## 📚 Additional Resources

- [Homebrew Documentation](https://docs.brew.sh/)
- [ZSH Documentation](https://www.zsh.org/)
- [iTerm2 Documentation](https://iterm2.com/documentation.html)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

## 🔄 Updating

### Update Homebrew Packages

```bash
brew update
brew upgrade
brew bundle --file=~/Git_Downloads/Dotfiles/Homebrew/Brewfile
```

### Update ZSH Plugins

```bash
cd ~/.config/zsh/plugins
for dir in */; do
    cd "$dir" && git pull && cd ..
done
```

### Update iTerm2 Settings

Use the secure export/import method, or manually update profiles and themes.
