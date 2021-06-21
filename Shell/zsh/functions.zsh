###CHEATSHEETS###
function cheat() { nvim -- ~/.cheatsheet/$1-cheatsheet.md; }

path() {
  echo $PATH | tr ':' '\n'
}

execute-fzf() {
  if [ -z "$1" ]; then
    file="$(fzf --multi)"
  else
    file=$(eval "$1 | fzf --multi")
  fi

  case "$file" in
    "") echo "fzf cancelled";;
    *) eval "$2" "$file";;
  esac
}

ff() {
  execute-fzf "" "nvim"
}

brew-uninstall() {
  execute-fzf "brew list" "brew uninstall"
}
alias bun='brew-uninstall'

brew-cask-uninstall() {
  execute-fzf "brew cask list" "brew cask uninstall"
}
alias bcun='brew-cask-uninstall'

brew-outdated() {
  echo "==> Running brew update..."
  brew update >/dev/null

  echo "\n==> Outdated brews and casks"
  brew outdated
}

brew-upgrade() {
  echo "\n==> brew upgrade"
  brew upgrade

  echo "\n==> brew cask upgrade"
  brew upgrade --cask
}

alias bo="brew-outdated"
alias bu="brew-upgrade"

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}


aliases() {
  if [ -f ~/.config/zsh/aliases.zsh ]; then
    nvim ~/.config/zsh/aliases.zsh
  fi

  if [ -f ~/.config/zsh/aliases.local.zsh ]; then
    nvim ~/.config/zsh/aliases.zsh.local
  fi
}

funcs() {
  if [ -f ~/.config/zsh/functions.zsh ]; then
    nvim ~/.config/zsh/functions.zsh
  fi

  if [ -f ~/.config/zsh/functions.zsh.local ]; then
    nvim ~/.config/zsh/functions.zsh.local
  fi
}

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


###GIT FUNCTIONS####
function gitnewrepo() {mkdir $1 && cd $1 && git init && hub create && touch README.md && echo "# " $1 >> README.md && git add . && git commit -m "init" && git push -u origin HEAD;}
function gwc() { git clone --bare $1 $2 && cd $2 && git worktree add main && cd main;}
function gwa() {git worktree add $1;}
function gwr() {git worktree remove $1;}
function gwrf() {git worktree remove --force $1;}
function acp() {
git add .
git commit -m "$1"
git push -u origin HEAD
}

function ql() {
	qlmanage -p $1 >  /dev/null ^ /dev/null&
}
