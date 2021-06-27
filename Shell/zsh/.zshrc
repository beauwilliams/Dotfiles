#     ____    _   __    ____  ______
#    /  _/   / | / /   /  _/ /_  __/
#    / /    /  |/ /    / /    / /
#  _/ /    / /|  /   _/ /    / /
# /___/   /_/ |_/   /___/   /_/



#Disable the username@hostname text in terminal when logged in to local machine
prompt_context(){}

#ENABLE ZSH COMPLETION SYSTEM (OMZSH USED TO DO IT FOR US)
autoload -Uz compinit && compinit
zmodload -i zsh/complist

#Hopefully this loads powerlevel10k theme faster
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export BAT=0


#     ____     __    __  __   ______    ____    _   __   _____
#    / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
#   / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
#  / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
# /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/



# Plugins I want to try
# https://github.com/yuki-yano/zeno.zsh Abbreviations for zsh and fzf

# use this in the future?
# for file (~/.zsh/*); do
#   source $file
# done

[[ -f ~/.config/zsh/.fzf.zsh ]] && source ~/.config/zsh/.fzf.zsh
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh #powerline theme config
eval "$(zoxide init zsh)" #Faster than z.lua, works with https://github.com/nanotee/zoxide.vim
eval "$(lua /Users/admin/Git_Downloads/z.lua/z.lua --init zsh enhanced fzf)" #I use this for z because it has tab completion zoxide is just for vim :z
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme #theme binaries
source ~/.zsh/.iterm2_shell_integration.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/enhancd/init.sh && export ENHANCD_DISABLE_DOT=1 #disable cd ..
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh && fpath=(~/.zsh/zsh-completions/src $fpath)
source ~/.zsh/alias-tips/alias-tips.plugin.zsh #Reminds you of your aliases
source ~/.zsh/plugin-osx/osx-aliases.plugin.zsh #OSX Aliases
source ~/.zsh/hacker-quotes/hacker-quotes.plugin.zsh
source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh #must be loaded before fzf-tab
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/Git_Downloads/awesome-fzf/awesome-fzf.zsh
# source ~/.zsh/boss-git-zsh-plugin/boss-git.plugin.zsh
# source ~/.zsh/zsh-z/zsh-z.plugin.zsh #zsh native version of z for speed
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh #NOT WORKING https://github.com/marlonrichert/zsh-autocomplete/issues/287
# source ~/.zsh/zsh-vim-mode-enhanced/zsh-vi-mode.plugin.zsh #https://github.com/jeffreytse/zsh-vi-mode - does not work with fzf-tab



#    ____     ____   ______    ____   ____     _   __   _____
#   / __ \   / __ \ /_  __/   /  _/  / __ \   / | / /  / ___/
#  / / / /  / /_/ /  / /      / /   / / / /  /  |/ /   \__ \
# / /_/ /  / ____/  / /     _/ /   / /_/ /  / /|  /   ___/ /
# \____/  /_/      /_/     /___/   \____/  /_/ |_/   /____/



# funcs and aliases configs
for file (~/.config/zsh/*.zsh); do
  source $file
done

#AUTOSUGGESTION HISTORY
HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#OTHER CONFIGS
#TODO: [beauwilliams] --> Find out what each of the below does and document for future ref
setopt appendhistory
setopt INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
setopt share_history
setopt AUTO_PUSHD               #allow for cd -1 -2 -3 and so on
setopt auto_cd                  # if command is a path, cd into it
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
setopt print_exit_value         # print return value if non-zero
setopt chase_links              # resolve symlinks
setopt auto_remove_slash        # self explicit

#COMPLETION OPTIONS
#TODO: [beauwilliams] --> Find out what each of the below does and document for future ref
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' original true
zstyle :compinstall filename '/Users/admin/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# setopt completealiases #setting this on for now disables z completion
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 #avoids lag pasting large chunks of text into the shell

#THEME CONFIG - COLOR LS -- switching back to plain old ls as more portable.
export ZSH_THEME='powerlevel10k/powerlevel10k'
export CLICOLOR=1
export CLICOLOR_FORCE=true
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
#ALLOWS SYNTAX HIGHLIGHTING IN VIM USING BAT (cat replcmnt)
export BAT_THEME='gruvbox'
#export LSCOLORS=GxFxCxDxBxegedabagaced
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
#export LSCOLORS=exfxcxdxbxegedabagacad

# Ignore pointless files in filename completion
#idk why but these were breaking bat completion so turned them off...
# export FIGNORE="DS_Store:$FIGNORE"
# export FIGNORE="$FIGNORE:.DS_Store"

# Ignore pointless files when we ls
#function ll { ls -la $@ | rg -v .DS_Store; }

#Setting nvim as out editor
export EDITOR="nvim"
#Setting nvim as our MANPAGER
export MANPAGER='nvim +Man!'

#ITERM OPTIONS
export iterm2_hostname=`hostname -f` #NOTE: download with scp not working..



#     ____     ___   ______    __  __   _____
#    / __ \   /   | /_  __/   / / / /  / ___/
#   / /_/ /  / /| |  / /     / /_/ /   \__ \
#  / ____/  / ___ | / /     / __  /   ___/ /
# /_/      /_/  |_|/_/     /_/ /_/   /____/




#SYSTEM
# export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin #default path ls, mv etc
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/Users/admin/.local/bin" #MY CUSTOM BINARY LOCATION
# export PATH="/usr/local/sbin:$PATH"

#NODE
#Adding path for node installation, something happened during update and npm dissapeared!
# export PATH="/usr/local/bin/:$PATH"

#HASKELL GHC
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
#HASKELL
export PATH=$HOME/Library/Haskell/bin:$PATH

#QT Framework
#export PATH="/usr/local/opt/qt/bin:$PATH"

#JAVA --> using my setjdk() function
setjdk 14


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

#PHP -- Override macosx default 7.1
export PATH=/usr/local/php5/bin:$PATH

####LUA/FENNEL
export PATH=$HOME/.luarocks/bin:$PATH #sets luarocks local into path. So I can use fennel.

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

#if [ -e /Users/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer




#     ____     ______    ____     ____     ______   ______    ___   ______    ______    ____
#    / __ \   / ____/   / __ \   / __ \   / ____/  / ____/   /   | /_  __/   / ____/   / __ \
#   / / / /  / __/     / /_/ /  / /_/ /  / __/    / /       / /| |  / /     / __/     / / / /
#  / /_/ /  / /___    / ____/  / _, _/  / /___   / /___    / ___ | / /     / /___    / /_/ /
# /_____/  /_____/   /_/      /_/ |_|  /_____/   \____/   /_/  |_|/_/     /_____/   /_____/




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
