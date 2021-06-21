
#====================BEGIN ALIASES=======================================

###MISC ALIASES###
eval $(thefuck --alias)


###CONFIGS###
alias vimconfig="nvim ~/.vimrc"
alias zshconfig="nvim ~/.zshrc"
alias powerlineconfig="nvim ~/.zsh/.p10k.zsh"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias sshconfig="nvim ~/.ssh/config"
alias ignoreconfig="nvim ~/.config/git/.gitignore_global"

#alias cheatsheet-git="nvim ~/.cheatsheet/git-cheatsheet.md"


###ZSH ###
alias zshreload="source ~/.zshrc"
alias sshagentload='eval `ssh-agent -s`' #load ssh agent when ssh-add not working
#BEAU Below alias enables colourful ls
#alias ls="exa -G -a --git-ignore --icons"
alias ls=" ls -a"
alias lst="exa -T -a --git-ignore --icons"
alias lsl="exa --long -a -u -h --icons"
#fuzzysearch open in vim I did this because fuzzy search won't open anything at the moment
alias ff="nvim -c 'FZF'"
alias vs="nvim -c 'FZF'"
alias cat="bat"

#DIR NAV
alias -- -="cd -" #quick jump back to prev dir with -
alias bd="cd .." #for when .. does not work on new systems
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
#My little go back quicker command
#First alias I made
#alias bd="cd .."

###GIT ALIASES####
alias gp='git push -u origin HEAD'
#Creating aliases for my dotfiles integration with github
alias mergevim="cp ~/.vimrc ~/Git_Downloads/Dotfiles/Vim/vim"
alias mergezsh="cp ~/.zshrc ~/Git_Downloads/Dotfiles/Shell && echo 'merging zshrc'"
alias mergenvim="~/.config/nvim/merge-nvim-config.sh"
alias mergecheatsheets="~/.cheatsheet/merge-cheatsheets.sh"
alias mergecoc="cp ~/.config/nvim/coc-settings.json ~/Git_Downloads/Dotfiles/Vim/nvim"
alias mergegit="~/.config/git/merge-git-config.sh"

###MAC ALIASES###
#TOGGLE THEME ON YOUR MAC WITH THIS SCRIPT =)
alias toggleosxtheme="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
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
alias mdreader='glow'


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
