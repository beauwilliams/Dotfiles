#!/usr/bin/env sh
#====================BEGIN ALIASES=======================================

###BOSS SHIT###
alias nvimenv="~/.local/bin/nvim"
alias n="nvim"
alias vi="nvim"
alias vim="nvim"

###MISC ALIASES###
# eval "$(thefuck --alias)"
alias comp3100='multipass exec comp3100 bash'

####NOTES####
alias scratch="~/.config/zsh/commands/fzf-scratch.sh"
alias notes="~/.config/zsh/commands/fzf-scratch.sh"

####CHEAT.SH####
alias chtsh='fzf-cheat'

###CONFIGS###
alias vimconfig="nvim ~/.vimrc"
alias zshconfig="nvim ~/.zshrc"
alias zshenv="nvim ~/.zshenv"
alias powerlineconfig="nvim ~/.config/zsh/.p10k.zsh"
alias hammerconfig="nvim ~/.hammerspoon/init.lua"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias sshconfig="nvim ~/.ssh/config"
alias gitignore="nvim ~/.config/git/ignore"
alias gitconfig="nvim ~/.config/git/config"

#alias cheatsheet-git="nvim ~/.cheatsheet/git-cheatsheet.md"
#CODING
alias start='just start'
alias deploy='just deploy'
alias compile='just compile'
alias run='just run'
alias init='just init'
alias build='just build'
alias test='just test'
alias lint='just lint'

###TMUX###
alias attach='tmux attach -t'
alias stop='tmux kill-session -t'
alias 2pane='tmux-2pane'

###ZSH ###
alias zshreload="source ~/.zshrc"
alias sshagentload='eval `ssh-agent -s`' #load ssh agent when ssh-add not working
#BEAU Below alias enables colourful ls
#alias ls="exa -G -a --git-ignore --icons"
alias ls=" ls -a"
alias lst="exa -T -a --git-ignore --icons"
alias lsl="exa --long -a -u -h --icons"
alias cat="bat"
#fuzzysearch open in vim I did this because fuzzy search won't open anything at the moment
# alias ff="nvim -c 'FZF'"
# alias vs="nvim -c 'FZF'"

#DIR NAV
alias -- -="cd -" #quick jump back to prev dir with -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
#My little go back quicker command
#First alias I made
#alias bd="cd .."

###REMIX###
alias remix=remixd -s . --remix-ide http://remix.ethereum.org && http://remix.ethereum.org

###GIT ALIASES####
alias gd=lazygit #GIT DASHBOARD
alias gci='koji' #INTERACTIVE COMMITS
alias ghelp="git help -a | fzf --reverse"
alias gpo='git push -u origin HEAD'
alias __git_find_subcommand='__git_find_on_cmdline'
alias ga='git add'
alias gall='git add .'
alias gb='git branch'
alias gba='git branch -a'
# alias gc='git commit -v'
alias gca='git commit -v -a'
# alias gci='git commit --interactive'
# alias gcl='git clone'
alias gcm='git commit -v -m'
# alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gdel='git branch -D'
alias get='git'
alias gexport='git archive --format zip --output'
alias gpl='git pull'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gm='git merge'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gp='git push'
alias gpp='git pull && git push'
alias gpr='git pull --rebase'
# alias gs='git status'
alias gsl='git shortlog -sn'
alias gss='git status -s'
alias gst='git status'
alias gup='git fetch && git rebase'
alias gus='git reset HEAD'
alias gw='git whatchanged'

#Creating aliases for my dotfiles backup on github
alias mergevim="echo merging vimrc && cp ~/.vimrc ~/Git_Downloads/Dotfiles/Vim/vim"
alias mergezsh="~/.config/zsh/commands/merge-zsh.sh"
alias mergenvim="~/.config/nvim/merge-nvim-config.sh"
alias mergecheatsheets="~/.cheatsheet/merge-cheatsheets.sh"
alias mergehammer="echo merging hammerspon && cp ~/.hammerspoon/init.lua ~/Git_Downloads/Dotfiles/Hammerspoon"
alias mergegit="~/.config/git/merge-git-config.sh"
alias mergebrew="echo merging homebrew && cd ~/Git_Downloads/Dotfiles/Homebrew/ && brew bundle dump --force"
alias mergeiterm="echo merging iterm && cp -r /Users/admin/Library/Application\ Support/iTerm2/Scripts/ ~/Git_Downloads/Dotfiles/Shell/iTerm/Scripts/"
alias mergeall="mergezsh && mergenvim && mergebrew && mergecheatsheets && mergegit && mergehammer && mergevim && mergeiterm"


###MAC ALIASES###
#TOGGLE THEME ON YOUR MAC WITH THIS SCRIPT =)
alias toggleosxtheme="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
alias finder="open $(pwd)"
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"
alias cpu='top -o cpu'   # CPU
alias mem='top -o rsize' # Memory
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
#APP LAUNCHERS
alias dymosdk="open /Library/Frameworks/DYMO/SDK/DYMO.DLS.Printing.Host.app"

###APP SHORTCUTS###
alias activitymonitor="htop"
#Adding a markdown previewer command to my terminal
#From here: https://tosbourn.com/view-markdown-files-terminal/
#rmd () {
#  pandoc $1 | lynx -stdin
#}
#NOTE: Did not like above approach, replaced it with https://brettterpstra.com/2015/08/21/mdless-better-markdown-in-terminal/ - it is lighter and works better - use mdless to open .MD for previewing
#Does not matter what reader we usem remember one command! mdreader
# alias mdreader='mdless'
# alias mdreader='glow'
alias mdreader='mlp'
alias mdr=mdreader
alias mdpreview=mdreader
alias mdp=mdreader

###PYTHON ALIASES###
#Creating python3 and pip3 alias, essentially upgrading my system to python3
#alias python="~/opt/miniconda3/bin/python"
#alias pip="/usr/local/bin/pip3"
#NO LONGER NEEDED USED PIP3 COMMAND FOR NOW #alias pipAzureML="~/opt/miniconda3/envs/AzureML/bin/pip" #NOTE: You need this to install things into your conda env

#######VIM ALIASES##########
alias luamake=/Users/admin/.config/nvim/.langservers/lua-language-server/3rd/luamake/luamake

#####UNI######
alias mountIceberg='sshfs -o default_permissions mqserver2:/home/45456070/ ~/SSHFS/Iceberg/ && cd ~/SSHFS/Iceberg/'
alias umountIceberg='cd ~/ && umount -f ~/SSHFS/Iceberg'

#==================================END ALIASES===================================
