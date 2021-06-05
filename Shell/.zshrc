#====================BEGIN USER CONFIG==========================
#
# BEAU: Disable the username@hostname text in terminal when logged in to local machine
prompt_context(){}

# ENABLE ZSH COMPLETION SYSTEM (OMZSH USED TO DO IT FOR US)
autoload -Uz compinit && compinit
zmodload -i zsh/complist

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export iterm2_hostname=`hostname -f` #NOTE: download with scp not working..

###SOURCES###
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh #theme config
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme #theme binaries
source ~/.iterm2_shell_integration.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-vim-mode-enhanced/zsh-vi-mode.plugin.zsh #https://github.com/jeffreytse/zsh-vi-mode
source ~/.zsh/boss-git-zsh-plugin/boss-git.plugin.zsh
source ~/.zsh/enhancd/init.sh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh && fpath=(~/.zsh/zsh-completions/src $fpath)
source ~/.zsh/alias-tips/alias-tips.plugin.zsh #Reminds you of your aliases
source ~/.zsh/plugin-osx/osx-aliases.plugin.zsh #OSX Aliases
source ~/.zsh/hacker-quotes/hacker-quotes.plugin.zsh
# source ~/.zsh/zsh-z/zsh-z.plugin.zsh #zsh native version of z for speed
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh #NOT WORKING
# https://github.com/marlonrichert/zsh-autocomplete/issues/287
# source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#AUTOSUGGESTION HISTORY
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
setopt share_history

#OTHER CONFIGS
setopt AUTO_PUSHD               #allow for cd -1 -2 -3 and so on
setopt auto_cd                  # if command is a path, cd into it
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
setopt print_exit_value         # print return value if non-zero
setopt chase_links              # resolve symlinks
setopt auto_remove_slash        # self explicit

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' original true
zstyle :compinstall filename '/Users/admin/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# setopt completealiases #NOTE:, setting this on for now disables z completion
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 #avoids lag pasting large chunks of text into the shell

#THEME CONFIG - COLOR LS -- switching back to plain old ls as more portable.
ZSH_THEME='powerlevel10k/powerlevel10k'
#ALLOWS SYNTAX HIGHLIGHTING IN VIM USING BAT (cat replcmnt)
export BAT_THEME='gruvbox'
export CLICOLOR=1
export CLICOLOR_FORCE=true
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
#export LSCOLORS=GxFxCxDxBxegedabagaced
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
#export LSCOLORS=exfxcxdxbxegedabagacad

# Ignore pointless files in filename completion
export FIGNORE="DS_Store:$FIGNORE"
export FIGNORE="$FIGNORE:.DS_Store"

# Ignore pointless files when we ls
#function ll { ls -la $@ | rg -v .DS_Store; }

EDITOR=nvim
#Setting nvim as our MANPAGER
export MANPAGER='nvim +Man!'




#############JAVA VERSION CHANGER#############
#USE `setjdk <version>`
#e.g --> setjdk 1.8
# set and change java versions
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}
#Helper function for java path changer
removeFromPath () {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}


#==================END USER CONFIG=======================================
#
#
#
#====================BEGIN ALIASES=======================================

###MISC ALIASES###
eval $(thefuck --alias)


###CONFIGS###
alias vimconfig="nvim ~/.vimrc"
alias zshconfig="nvim ~/.zshrc"
alias powerlineconfig="nvim ~/.zsh/.p10k.zsh"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias sshconfig="nvim ~/.ssh/config"

###CHEATSHEETS###
function cheat() { nvim -- ~/.cheatsheet/$1-cheatsheet.md; }
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
alias mergezsh="cp ~/.zshrc ~/Git_Downloads/Dotfiles/Shell"
alias mergenvim="~/.config/nvim/merge-nvim-config.sh"
alias mergecheatsheets="~/.cheatsheet/merge-cheatsheets.sh"
alias mergecoc="cp ~/.config/nvim/coc-settings.json ~/Git_Downloads/Dotfiles/Vim/nvim"

###GIT FUNCTIONS####
function gitnewrepo() {mkdir $1 && cd $1 && git init && hub create && touch README.md && echo "# " $1 >> README.md && git add . && git commit -m "init" && git push -u origin HEAD;}

function acp() {
git add .
git commit -m "$1"
git push -u origin HEAD
}

function ql() {
	qlmanage -p $1 >  /dev/null ^ /dev/null&
}


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
#
#
#
#========================START INITS, PATHS & SOURCES=============================

###INITS###
#BEAU - config for z.lua directory jumper i.e z
eval "$(lua /Users/admin/Git_Downloads/z.lua/z.lua --init zsh enhanced fzf)"
# eval "$(zoxide init zsh)" #Faster than z.lua, works with https://github.com/nanotee/zoxide.vim

#Launches jenv, currently using to mng java vers
#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"



#HASKELL GHC
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"


###PATHS###
# export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin #default path ls, mv etc
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/Users/admin/.local/bin" #MY CUSTOM BINARY LOCATION
# export PATH="/usr/local/sbin:$PATH"
#NODE
#Adding path for node installation, something happened during update and npm dissapeared!
# export PATH="/usr/local/bin/:$PATH"
#QT Framework
#export PATH="/usr/local/opt/qt/bin:$PATH"
#JAVA
#setting adoptopenjdk8 as default
#export JAVA_HOME=$(/usr/libexec/java_home -v 14) / DEC20 replace with setjdk fn
# export PATH="$HOME/tools/nvim:$PATH"
#HASKELL
export PATH=$HOME/Library/Haskell/bin:$PATH
#FLUTTER
# export PATH="$PATH:/Users/admin/Git_Downloads/SDK..Downloads/flutter/bin"
#ANDROID
#export PATH="$PATH:/Users/admin/SDK/Android_Studio/platform-tools"
# export ANDROID_HOME=/Users/$USER/SDK/Android_Studio/
# export ANDROID_SDK_ROOT=$ANDROID_HOME
# export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

###VIM PATHS###
#Path for vim man pages extension https://github.com/jez/vim-superman
# export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"
# compdef vman="man" #adds autocompletion for the command
export PATH="$PATH:$HOME/.config/nvim/.langservers" #my langservers

#RUBY / RVM
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


###CONDA PATHS###
#See here https://stackoverflow.com/questions/41060382/using-pip-to-install-packages-to-anaconda-environment
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#
# DISABLING CONDA JUL 2021, using python 3.9 now..
# __conda_setup="$('/Users/admin/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/admin/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/admin/opt/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/admin/opt/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
#<<< conda initialize <<<
#
#
# # TELL FZF TO USE RIPGREP NOTE: Testing this in .fzf.zsh file
# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files'
#   export FZF_DEFAULT_OPTS='-m --height 50% --border'
# fi

#if [ -e /Users/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


#
#
#=====================END OF INITS, PATHS & SOURCES===============================
#
#
#
#================ZSH DEFAULT OPTIONS=========================
#

# -e ensure scipt stops when first cmd fails, -u ensure script exits on first unset variable, -o pipefail means that if piped commands fail, exit code is whole command not last failed piped command
#   set -euo pipefail

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#
#
#===================END ZSH DEFAULTS================================
#
#
#
#=================OH MY ZSH PLUGINS=================================
#
# Path to your oh-my-zsh installation.
#export ZSH="/Users/admin/.oh-my-zsh"
#
#
#plugins=(git
        #zsh-syntax-highlighting
        #zsh-autosuggestions
        #zsh-vim-mode
#)
#
#REPLACED OH-MY-ZSH with Manual MGMT as I only have few plugins :)

#source $ZSH/oh-my-zsh.sh

#===================END PLUGIN CONFIG===========================
#
#
#

#===================END ZSH CONFIG===========================
#

