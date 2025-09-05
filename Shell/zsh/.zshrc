#     ____    _   __    ____  ______
#    /  _/   / | / /   /  _/ /_  __/
#    / /    /  |/ /    / /    / /
#  _/ /    / /|  /   _/ /    / /
# /___/   /_/ |_/   /___/   /_/


# GITSTATUS_LOG_LEVEL=DEBUG

# Skip interactive features when running in Cursor Agent
if [[ -z "$CURSOR_AGENT" ]]; then

#TODO: solve the pesky auto quote issue with acp command
# https://superuser.com/questions/1508079/auto-quote-arguments-in-zshhttps://superuser.com/questions/1508079/auto-quote-arguments-in-zsh
# https://zsh.sourceforge.io/Guide/zshguide05.html
function quote-accept-line() {
    local -a starts_with=("python -c ")
    for str ($starts_with) {
        if [[ ${(M)BUFFER#$str} ]] {
            BUFFER=$str${(qq)BUFFER#$str}
        }
    }
    zle accept-line
}
zle -N quote-accept-line
# bind it to "Enter"
bindkey "^M" quote-accept-line


# https://sgeb.io/posts/zsh-zle-custom-widgets/
function _git-status {
    zle kill-whole-line
    zle -U "git status"
    zle accept-line
}
zle -N _git-status

#Allow more system resources and open files to the shell
#Hopefully fix vim open files leaks
ulimit -n 10240

#Disable the username@hostname text in terminal when logged in to local machine
prompt_context(){}

#########COMPLETIONS############
#ENABLE ZSH COMPLETION SYSTEM (OMZSH USED TO DO IT FOR US)
# Add homebrew completions
if [ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]; then
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi
#Set up the completions
autoload -Uz compinit && compinit
zmodload -i zsh/complist
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"


#Hopefully this loads powerlevel10k theme faster
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#dump zsh shell colours
function colours() (
for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
  )


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

[[ -f ~/.config/zsh/configs/.fzf.zsh ]] && source ~/.config/zsh/configs/.fzf.zsh
[[ -f ~/.config/zsh/configs/.p10k.zsh ]] && source ~/.config/zsh/configs/.p10k.zsh #powerline theme config
eval "$(zoxide init zsh)" #Faster than z.lua, works with https://github.com/nanotee/zoxide.vim
eval "$(lua ~/.config/zsh/plugins/z.lua/z.lua --init zsh enhanced fzf)" #I use this for z because it has tab completion zoxide is just for vim :z
# source ~/Git_Downloads/z/z.sh
source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme #theme binaries
source ~/.config/zsh/plugins/.iterm2_shell_integration.zsh
source ~/.config/zsh/plugins/git-auto-fetch.plugin.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/enhancd/init.sh && export ENHANCD_DISABLE_DOT=1 #disable cd ..
source ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh && fpath=(~/.zsh/zsh-completions/src $fpath)
source ~/.config/zsh/plugins/alias-tips/alias-tips.plugin.zsh #Reminds you of your aliases
source ~/.config/zsh/plugins/plugin-osx/osx-aliases.plugin.zsh #OSX Aliases
source ~/.config/zsh/plugins/hacker-quotes/hacker-quotes.plugin.zsh
source ~/.config/zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh #must be loaded before fzf-tab
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source ~/Git_Downloads/awesome-fzf/awesome-fzf.zsh
fpath=(~/.config/zsh/plugins/zsh-cht.sh-completions/ $fpath) #source cht.sh completions
# source ~/.zsh/boss-git-zsh-plugin/boss-git.plugin.zsh
# source ~/.zsh/zsh-z/zsh-z.plugin.zsh #zsh native version of z for speed
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh #NOT WORKING https://github.com/marlonrichert/zsh-autocomplete/issues/287
# source ~/.zsh/zsh-vim-mode-enhanced/zsh-vi-mode.plugin.zsh #https://github.com/jeffreytse/zsh-vi-mode - does not work with fzf-tab

#    ____     ____   ______    ____   ____     _   __   _____
#   / __ \   / __ \ /_  __/   /  _/  / __ \   / | / /  / ___/
#  / / / /  / /_/ /  / /      / /   / / / /  /  |/ /   \__ \
# / /_/ /  / ____/  / /     _/ /   / /_/ /  / /|  /   ___/ /
# \____/  /_/      /_/     /___/   \____/  /_/ |_/   /____/


# NOTE: functions imported in zshenv

# funcs and aliases and other scripts
for file (~/.config/zsh/scripts/*); do
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
# export CLICOLOR_FORCE=true
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
#ALLOWS SYNTAX HIGHLIGHTING IN VIM USING BAT (cat replcmnt)
# if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ];
#   else export BAT_THEME='gruvbox-light'
# fi;
refresh-bat-theme() (
if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ];
  then echo 'gruvbox-dark'
  else echo 'GitHub'
fi;
)
export BAT_THEME=$(refresh-bat-theme)
precmd() { export BAT_THEME=$(refresh-bat-theme) }
# while true; do ~/.config/zsh/configs/theme.config; sleep 60; done
# echo "bash $0" | at now +1 minutes -M

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

fi # End of non-CURSOR_AGENT section


#     ____     ___   ______    __  __   _____
#    / __ \   /   | /_  __/   / / / /  / ___/
#   / /_/ /  / /| |  / /     / /_/ /   \__ \
#  / ____/  / ___ | / /     / __  /   ___/ /
# /_/      /_/  |_|/_/     /_/ /_/   /____/


#GCC + CC
#NOTE: gcc is symlinked to replace usr/bin/cc
#ln -s /usr/local/Cellar/gcc/11.2.0/bin/gcc-11 /usr/local/bin/cc
#Use GCC-11 by default
# export CC=gcc-11

#SYSTEM
# export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin #default path ls, mv etc
export PATH="/usr/local/bin:$PATH"
export MYBIN='/Users/admin/.local/bin' # For later reference to my BIN location for locally installed binaries
export PATH="$PATH:/Users/admin/.local/bin" #MY CUSTOM BINARY LOCATION
# export PATH="/usr/local/sbin:$PATH"

#NODE
export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# export PNPM_HOME="/Users/admin/Library/pnpm"
# export PATH="$PATH:$PNPM_HOME"

#HASKELL GHC
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
#HASKELL
export PATH=$HOME/Library/Haskell/bin:$PATH

#QT Framework
#export PATH="/usr/local/opt/qt/bin:$PATH"

#JAVA --> using my setjdk() function
setjdk 17 #using v11 for scala/sbt comp3000 26/7/21

#SCALA
export PATH="$PATH:/Users/admin/Library/Application Support/Coursier/bin" #Coursier ,Pure Scala Artifact Fetching


#SOLIDITY
#NOTE: Use solc-select binary to change / install solidity versions
# export PATH="$PATH:$HOME/.langservers/solidity/llvm12.0/bin"
# export PATH="$PATH:$HOME/.langservers/solidity/"

#GOLANG
export GOPATH=$HOME/workspaces/golang #workspace
export GOROOT=/opt/homebrew/opt/go/libexec/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


#FLUTTER
# export PATH="$PATH:/Users/admin/Git_Downloads/SDK..Downloads/flutter/bin"


#ANDROID
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
# export ANDROID_SDK_ROOT=$ANDROID_HOME


###VIM PATHS###
# NOTE: Using mason now, no need to manually manage binaries, but keep here if needed in future
#Path for vim man pages extension https://github.com/jez/vim-superman
# export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"
# compdef vman="man" #adds autocompletion for the command
# export PATH="$PATH:$HOME/.langservers" #my langservers
# export PATH="$PATH:$HOME/.langservers/omnisharp-osx/bin/" # C#  omnisharp-roslyn
# export PATH="$PATH:$HOME/.formatters" #my formatters

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/admin/.sdkman"
[[ -s "/Users/admin/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/admin/.sdkman/bin/sdkman-init.sh"

# bun completions
[ -s "/Users/admin/.bun/_bun" ] && source "/Users/admin/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/admin/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#export PATH=/opt/homebrew/bin:/Users/admin/.rvm/gems/ruby-2.7.0/bin:/Users/admin/.rvm/gems/ruby-2.7.0@global/bin:/Users/admin/.rvm/rubies/ruby-2.7.0/bin:/Users/admin/.bun/bin:/Users/admin/.sdkman/candidates/scala/current/bin:/Users/admin/.sdkman/candidates/sbt/current/bin:/Users/admin/.luarocks/bin:/usr/local/php5/bin:/Library/Java/JavaVirtualMachines/jdk-11.0.11.jdk/Contents/Home/bin:/Users/admin/Library/Haskell/bin:/Users/admin/.cabal/bin:/Users/admin/.ghcup/bin:/Users/admin/.nvm/versions/node/v16.13.1/bin:/usr/local/bin:/Users/admin/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/usr/local/share/dotnet:/opt/X11/bin:~/.dotnet/tools:/Library/Apple/usr/bin:/Applications/Wireshark.app/Contents/MacOS:/usr/local/git/bin:/Users/admin/.fig/bin:/Users/admin/.local/bin:/usr/local/opt/fzf/bin:/Users/admin/.local/bin:/Users/admin/Library/Application Support/Coursier/bin:/Users/admin/.langservers/solidity/llvm12.0/bin:/Users/admin/.langservers/solidity/:/Users/admin/workspaces/golang/bin:/usr/local/opt/go/libexec/bin:/Users/admin/.langservers:/Users/admin/.formatters:/Users/admin/.rvm/bin

