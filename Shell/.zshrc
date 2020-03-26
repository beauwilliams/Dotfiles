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
#/////##BEAU THIS IS WHERE ZSH PLUGINS FOR OHMYZSH ARE##/////
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

# User configuration

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# BEAU: Disable the username@hostname text in terminal when logged in to local machine
prompt_context(){}
#BEAU - Powerline code for zsh shell
##Not surte I actually use powrline now since using powerlevel10k
##Zsh taking too long to start atm
#. /Library/Python/2.7/site-packages/powerline/bindings/zsh/powerline.zsh

#BEAU - My aliases
alias vimconfig="vi /usr/local/Cellar/macvim/8.2-162/MacVim.app/Contents/Resources/vim/vimrc"
alias zshconfig="vi ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias ohmyzshplugins="cd ~/.oh-my-zsh/custom/plugins"
alias zghthemeconfig='vi ~/.p10k.zsh' #https://github.com/romkatv/powerlevel10k#oh-my-zsh
alias sshagentload='eval `ssh-agent -s`' #load ssh agent when ssh-add not working
#BEAU Below alias enables colourful ls
alias ls="lsd -la"
alias lt="lsd --tree"
#fuzzysearch open in vim I did this because fuzzy search won't open anything at the moment
alias ff="vim -c 'FZF'"
alias vs="vim -c 'FZF'"

alias powerlineconfig="p10k configure"
#My little go back quicker command
alias bd="cd .."


alias mergevim="cp /usr/local/Cellar/macvim/8.2-162/MacVim.app/Contents/Resources/vim/vimrc ~/Git_Downloads/Dotfiles/Vim"
alias mergezsh="cp ~/.zshrc ~/Git_Downloads/Dotfiles/Shell"

#TOGGLE THEME ON YOUR MAC WITH THIS SCRIPT =)
alias toggleosxtheme="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"

alias actmon="htop"

#Creating aliases for my dotfiles integration with github
#

#BEAU - config for z.lua file search
eval "$(lua /Users/admin/Git_Downloads/z.lua/z.lua --init zsh)"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

eval "$(jenv init -)"

#BEAU - adding tab completion for color ls module installed using ruby see 
#https://github.com/athityakumar/colorls
#source $(dirname $(gem which colorls))/tab_complete.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#BEAU - adding source for iTERM shell integration see here https://iterm2.com/documentation-shell-integration.html 
#source ~/.iterm2_shell_integration.zsh " disabled because it leaves a mark I dont like

