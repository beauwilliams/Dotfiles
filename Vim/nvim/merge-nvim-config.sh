#!/usr/bin/env sh
echo "Merging nvim config to git dotfiles repo"
#folders of files
cp -r ~/.config/nvim/.baks ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/ftdetect ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/ftplugin ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/plugin ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/syntax ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/lua ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/fnl ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/snippets ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/spell ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/vimspector-config ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/after ~/Git_Downloads/Dotfiles/Vim/nvim/
cp -r ~/.config/nvim/doc ~/Git_Downloads/Dotfiles/Vim/nvim/

#single files
cp ~/.config/nvim/init.lua ~/Git_Downloads/Dotfiles/Vim/nvim/
cp ~/.config/nvim/justfile ~/Git_Downloads/Dotfiles/Vim/nvim/
cp ~/.config/nvim/stylua.toml ~/Git_Downloads/Dotfiles/Vim/nvim/
cp ~/.config/nvim/merge-nvim-config.sh ~/Git_Downloads/Dotfiles/Vim/nvim/
cp ~/.config/nvim/cheatsheet.txt ~/Git_Downloads/Dotfiles/Vim/nvim/
