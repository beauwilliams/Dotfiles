export PATH="/usr/local/sbin:$PATH"
#================ZSH DEFAULT OPTIONS=========================


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/admin/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='powerlevel10k/powerlevel10k'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
#
#===================END ZSH DEFAULTS================================
#
#
#=================OH MY ZSH PLUGINS=================================
#
plugins=(git
        zsh-syntax-highlighting
        zsh-autosuggestions
        zsh-vim-mode
)

#BEAU PLUGIN NOTES BELOW

#BEAU: Enabling ZSH Syntax Highlighting Plugin From this Tutorial https://www.freecodecamp.org/news/jazz-up-your-zsh-terminal-in-seven-steps-a-visual-guide-e81a8fd59a38/
#BEAU: ENABLING ZSH Autosuggestions - Using ABOVE TUTORial - syntax-highlighting

source $ZSH/oh-my-zsh.sh

#===================END PLUGIN CONFIG===========================
#
#
#====================BEGIN USER CONFIG==========================

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

# BEAU: Disable the username@hostname text in terminal when logged in to local machine
prompt_context(){}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#BEAU - Powerline code for zsh shell
##Not surte I actually use powrline now since using powerlevel10k
##Zsh taking too long to start atm
#. /Library/Python/2.7/site-packages/powerline/bindings/zsh/powerline.zsh



#THEME CONFIG - COLOR LS -- switching back to plain old ls as more portable.
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



#==================END USER CONFIG=======================================
#
#
#
#====================BEGIN ALIASES=======================================

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#BEAU - My aliases

###GIT ALIASES
alias git-create="hub create"

###CONFIGS###
alias vimconfig="nvim ~/.vimrc"
alias zshconfig="nvim ~/.zshrc"
alias powerlineconfig="p10k configure"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias sshconfig="nvim ~/.ssh/config"


###ZSH ###
alias zshreload="source ~/.zshrc"
alias ohmyzshplugins="cd ~/.oh-my-zsh/custom/plugins"
alias zghthemeconfig='vi ~/.p10k.zsh' #https://github.com/romkatv/powerlevel10k#oh-my-zsh
alias sshagentload='eval `ssh-agent -s`' #load ssh agent when ssh-add not working
#BEAU Below alias enables colourful ls
#alias ls="exa -G -a --git-ignore --icons"
alias ls=" ls -a"
alias lst="exa -T -a --git-ignore --icons"
alias lsl="exa --long -a -u -h --icons"
#fuzzysearch open in vim I did this because fuzzy search won't open anything at the moment
alias ff="vim -c 'FZF'"
alias vs="vim -c 'FZF'"
#TURNS OUT WE CAN SIMPLY USE .. in zsh, can extend it to ... .... etc
#My little go back quicker command
#alias bd="cd .."
alias cat="bat"

#COOL SHIT
alias -- -="cd -" #quick jump back to prev dir with -
alias bd="cd .." #for when .. does not work on new systems


###GIT ALIASES####
#Creating aliases for my dotfiles integration with github
alias mergevim="cp ~/.vimrc ~/Git_Downloads/Dotfiles/Vim/vim"
alias mergezsh="cp ~/.zshrc ~/Git_Downloads/Dotfiles/Shell"
alias mergenvim="cp ~/.config/nvim/init.vim ~/Git_Downloads/Dotfiles/Vim/nvim"


###MAC ALIASES###
#TOGGLE THEME ON YOUR MAC WITH THIS SCRIPT =)
alias toggleosxtheme="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
#APP LAUNCHERS
alias dymosdk="open /Library/Frameworks/DYMO/SDK/DYMO.DLS.Printing.Host.app"
alias helloyoutube="echo SUP. CHECK IT OUT. WE MAKING OUR OWN COMMANDS OUT HERE"
alias whatsitabout="echo MAKING CUSTOM ALIASES BABY"
alias soundscool="echo LETS GET IT"


###APP SHORTCUTS###
alias activitymonitor="htop"
#Adding a markdown previewer command to my terminal
#From here: https://tosbourn.com/view-markdown-files-terminal/
#rmd () {
#  pandoc $1 | lynx -stdin
#}
#NOTE: Did not like above approach, replaced it with https://brettterpstra.com/2015/08/21/mdless-better-markdown-in-terminal/ - it is lighter and works better - use mdless to open .MD for previewing
#Does not matter what reader we usem remember one command! mdreader
alias mdreader='mdless'


###PYTHON ALIASES###
#Creating python3 and pip3 alias, essentially upgrading my system to python3
#alias python="~/opt/miniconda3/bin/python"
#alias pip="/usr/local/bin/pip3"
#NO LONGER NEEDED USED PIP3 COMMAND FOR NOW #alias pipAzureML="~/opt/miniconda3/envs/AzureML/bin/pip" #NOTE: You need this to install things into your conda env

#######VIM ALIASES##########



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
eval "$(lua /Users/admin/Git_Downloads/z.lua/z.lua --init zsh)"
#Launches jenv, but why?
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

###SOURCES###
#BEAU - adding tab completion for color ls module installed using ruby see
#https://github.com/athityakumar/colorls
#source $(dirname $(gem which colorls))/tab_complete.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#BEAU - adding source for iTERM shell integration see here https://iterm2.com/documentation-shell-integration.html
#source ~/.iterm2_shell_integration.zsh " disabled because it leaves a mark I dont like
#Fuzzy finder FZF source
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



###PATHS###
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
#Adding path for node installation, something happened during update and npm dissapeared!
export PATH="/usr/local/bin/:$PATH"


###PATHS###
#See here https://stackoverflow.com/questions/41060382/using-pip-to-install-packages-to-anaconda-environment
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/admin/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/admin/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/admin/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/admin/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
#<<< conda initialize <<<
#
#
# TELL FZF TO USE RIPGREP
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

#
#
# =====================END OF INITS, PATHS & SOURCES===============================
#
#
#
# ==========================END OF ZSH CONFIG======================================
#export PATH="/usr/local/opt/qt/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 12)
#setting adoptopenjdk8 as default
export PATH="$HOME/tools/nvim:$PATH"
export PATH=$HOME/Library/Haskell/bin:$PATH
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
export PATH="$PATH:/Users/admin/Git_Downloads/SDK..Downloads/flutter/bin"
#export PATH="$PATH:/Users/admin/SDK/Android_Studio/platform-tools"
export ANDROID_HOME=/Users/$USER/SDK/Android_Studio/
export ANDROID_SDK_ROOT=$ANDROID_HOME
PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

if [ -e /Users/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

#ALLOWS SYNTAX HIGHLIGHTING IN VIM USING BAT (cat replcmnt)
export BAT_THEME='gruvbox'
