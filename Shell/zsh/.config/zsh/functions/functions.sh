#!/usr/bin/env bash
#TODO: Set up forgit -> https://github.com/wfxr/forgit

AWESOME_FZF_LOCATION="/Users/admin/Git_Downloads/awesome-fzf/awesome-fzf.zsh"
# morhetz/gruvbox theme for FZF
export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'

#Test if user has binary installed
function hasBinary() (
	if cmd=$(command -v $1); then echo TRUE; else echo FALSE; fi
)

function mdprint() {
	#npm install -g markdown-pdf
	markdown-pdf "$1"
}

function newtabi() {
	osascript \
		-e 'tell application "iTerm2" to tell current window to set newWindow to (create tab with default profile)' \
		-e "tell application \"iTerm2\" to tell current session of newWindow to write text \"$*\""
}

function titlei {
	echo -ne "\033]0;"$*"\007"
}

function iterm {
	local ARGS
	itermCmds=("newtabi" "titlei")
	cmd=$(printf "%s\n" "${itermCmds[@]}" | fzf --reverse)
	echo -n "enter chosen command args (if any) - enter for no args: "
	read -r ARGS
	eval "$cmd" "$ARGS"
}

function getFZFPreviewer() (
	if [[ $(hasBinary bat) = TRUE ]]; then
		echo "bat --style=numbers --color=always --line-range :500 {}"
	else
		echo "cat {}"
	fi
)

#List Awesome FZF Functions
function fzf-awesome-list() {
	if [[ -f $AWESOME_FZF_LOCATION ]]; then
		selected=$(grep -E "(function fzf-)(.*?)[^(]*" $AWESOME_FZF_LOCATION | sed -e "s/function fzf-//" | sed -e "s/() {//" | grep -v "selected=" | fzf --reverse --prompt="awesome fzf functions > ")
	else
		echo "awesome fzf not found"
	fi
	case "$selected" in
	"") ;; #don't throw an exit error when we dont select anything
	*) "fzf-"$selected ;;
	esac
}

###CHEATSHEETS###
function cheatsheets() {
	if [[ "$#" -eq 0 ]]; then
		local selected=$(find ~/.cheatsheet -maxdepth 1 -type f | fzf --multi)
		nvim $selected
	else
		nvim -- ~/.cheatsheet/$1-cheatsheet.md
	fi
}

# Get cheat sheet of command from cheat.sh. h <cmd>
h() {
	curl cheat.sh/${@:-cheat}
	# curl cheat.sh/$@
}

path() {
	echo $PATH | tr ':' '\n'
}

function mkcd() {
	mkdir -p -- "$1" &&
		cd -P -- "$1" || return
}

#Create nice image of some code on your clipboard
function codepic() {
	silicon --from-clipboard -l $1 -o ~/Downloads/Temp/$2.png --background '#fff0' --theme 'gruvbox'
}

function rm() (
	local SOURCES
	local REPLY
	local ERRORMSG
	if [[ "$#" -eq 0 ]]; then
		echo -n "would you like to use the force young padawan? y/n: "
		read -r REPLY
		#prompt user interactively to select multiple files with tab + fuzzy search
		SOURCES=$(find . -maxdepth 1 | fzf --multi)
		#we use xargs to capture filenames with spaces in them properly
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo "using the force..."
			echo "$SOURCES" | xargs -I '{}' rm -rf {}
		else
			echo "$SOURCES" | xargs -I '{}' rm {}
		fi
		echo "removed selected file/folder(s)"
	else
		ERRORMSG=$(command rm "$@" 2>&1)
		#if error msg is not empty, prompt the user
		if [ -n "$ERRORMSG" ]; then
			echo "$ERRORMSG"
			echo -n "rm failed, would you like to use the force young padawan? y/n: "
			read -r REPLY
			if [[ "$REPLY" =~ ^[Yy]$ ]]; then
				echo "using the force..."
				command rm -rf "$@"
			fi
		else
			echo "removed file/folder"
		fi
	fi
)

# mv wrapper. if no command provided prompt user to
# interactively select multiple files with tab + fuzzy search
function mv() {
	local SOURCES
	local TARGET
	local REPLY
	local ERRORMSG
	if [[ "$#" -eq 0 ]]; then
		echo -n "would you like to use the force young padawan? y/n: "
		read -r REPLY

		# NOTE. THIS IS A ZSH IMPLEMENTATION ONLY FOR NOW. VARED IS ZSH BUILTIN.
		# FOR BASH use something like read -p "enter a directory: "
		echo "Use full path i.e /Users/admin/Git_Downloads/blog-sites"
		vared -p 'to whence shall be the files moved. state your target: ' -c TARGET
		if [ -z "$TARGET" ]; then
			echo 'no target specified'
			return 1
		fi

		# This corrects issue where directory is not found as ~ is
		# not expanded  properly When stored directly from user input
		if echo "$TARGET" | grep -q "~"; then
			TARGET=$(echo $TARGET | sed 's/~//')
			TARGET=~/$TARGET
		fi

		SOURCES=$(find . -maxdepth 1 | fzf --multi)
		#we use xargs to capture filenames with spaces in them properly
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo "using the force..."
			echo "$SOURCES" | xargs -I '{}' mv -f {} '/'$TARGET'/'
		else
			echo "$SOURCES" | xargs -I '{}' mv {} '/'$TARGET'/'
		fi
		echo "moved selected file/folder(s)"
	else
		ERRORMSG=$(command mv "$@" 2>&1)
		#if error msg is not empty, prompt the user
		if [ -n "$ERRORMSG" ]; then
			echo "$ERRORMSG"
			echo -n "mv failed, would you like to use the force young padawan? y/n: "
			read -r REPLY
			if [[ "$REPLY" =~ ^[Yy]$ ]]; then
				echo "using the force..."
				command mv -f "$@"
			fi
		fi
	fi
}

# Man without options will use fzf to select a page
function man() (
	MAN="/usr/bin/man"
	if [ -n "$1" ]; then
		$MAN "$@"
		return $?
	else
		$MAN -k . | fzf --reverse --prompt='Man> ' --preview="echo {1} | sed 's/(.*//' | xargs $MAN -P cat" | awk '{print $1}' | sed 's/(.*//' | xargs $MAN
		return $?
	fi
)

list_man() {
	manlist=$(man -k . 2>/dev/null | awk 'BEGIN {FS=OFS="- "} /\([1|4]\)/ {gsub(/\([0-9]\)/, "", $1); if (!seen[$0]++) { print }}' | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN) &&
		man "$(echo "$manlist" | awk -F' |,' '{print $1}')" &&
		unset manlist
}

#

# Open current finder window in terminal
cdf() {
	target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
	if [ "$target" != "" ]; then
		cd "$target"
	else
		echo 'No Finder window found' >&2
	fi
}

# Scrape a single webpage with all assets
function scrapeUrl() {
	wget --adjust-extension --convert-links --page-requisites --span-hosts --no-host-directories "$1"
}

aliases() {
	if [ -f ~/.config/zsh/scripts/aliases.sh ]; then
		nvim ~/.config/zsh/scripts/aliases.sh
	fi

	if [ -f ~/.config/zsh/scripts/aliases.local.sh ]; then
		nvim ~/.config/zsh/scripts/aliases.sh.local
	fi
}

funcs() {
	if [ -f ~/.config/zsh/functions/functions.sh ]; then
		nvim ~/.config/zsh/functions/functions.sh
	fi

	if [ -f ~/.config/zsh/functions/functions.sh.local ]; then
		nvim ~/.config/zsh/functions/functions.sh.local
	fi
}

# Search list of aliases/functions
commands() {
	CMD=$(
		(
			(alias)
			(functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
		) | fzf | cut -d '=' -f1
	)

	eval $CMD
}

#############JAVA VERSION CHANGER#############
#USE `setjdk <version>`
#e.g --> setjdk 1.8
# set and change java versions
setjdk() {
	if [ $# -ne 0 ]; then
		removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
		if [ -n "${JAVA_HOME+x}" ]; then
			removeFromPath $JAVA_HOME
		fi
		export JAVA_HOME=$(/usr/libexec/java_home -v $@)
		export PATH=$JAVA_HOME/bin:$PATH
	fi
}
#Helper function for java path changer
removeFromPath() {
	export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

###GIT FUNCTIONS####
gitnewrepo() { mkdir "$*" && cd "$*" && git init && hub create && touch README.md && echo "# " "$*" >>README.md && git add . && git commit -m "init" && git push -u origin HEAD; }
gwc() { git clone --bare $1 $2 && cd $2 && git worktree add main && cd main; }
gwa() { git worktree add "$*"; }
gwr() { git worktree remove "$*"; }
gwrf() { git worktree remove --force "$*"; }
acp() {
	git add .
	# opencommit
	git commit -m "$*"
	git push -u origin HEAD
}
#Interactive git commit with KOJI
acpi() {
	git add .
	koji
	git push -u origin HEAD
}
# No arguments: `git status`
# With arguments: acts like `git`
g() {
	if [[ $# -gt 0 ]]; then
		git "$@"
	else
		git status
	fi
}

#git clone wrapper, `gcl` to clone from clipboard (macos)
#this works -->  `gcl git@github.com:beauwilliams/Dotfiles.git`
#this works --> `gcl`
# does not matter if the link you copied has "git clone" in front of it or not
gcl() {
	if [[ $# -gt 0 ]]; then
		git clone "$*" && cd "$(basename "$1" .git)"
	elif [[ "$(pbpaste)" == *"clone"* ]]; then
		$(pbpaste) && cd "$(basename "$(pbpaste)" .git)"
	else
		git clone "$(pbpaste)" && cd "$(basename "$(pbpaste)" .git)"
	fi
}

# Local:
# https://stackoverflow.com/questions/21151178/shell-script-to-check-if-specified-git-branch-exists
# test if the branch is in the local repository.
# return 1 if the branch exists in the local, or 0 if not.
function is_in_local() {
	if [ $(git rev-parse --verify --quiet $1) ]; then
		echo "Branch exists locally"
		return 1
	fi
}

# Remote:
# Ref: https://stackoverflow.com/questions/8223906/how-to-check-if-remote-branch-exists-on-a-given-remote-repository
# test if the branch is in the remote repository.
# return 1 if its remote branch exists, or 0 if not.
function is_in_remote() {
	if [ $(git branch --remotes | grep --extended-regexp "^[[:space:]]+origin/${1}$") ]; then
		echo "Branch exists on remote"
		return 1
	fi

}

# Checkout to existing branch or else create new branch. gco <branch-name>.
# Falls back to fuzzy branch selector list powered by fzf if no args.
gco() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
		if [[ "$#" -eq 0 ]]; then
			local branches branch
			branches=$(git branch -a) &&
				branch=$(echo "$branches" |
					fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
				git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
		elif [ $(git rev-parse --verify --quiet $*) ] ||
			[ $(git branch --remotes | grep --extended-regexp "^[[:space:]]+origin/${*}$") ]; then
			echo "Checking out to existing branch"
			git checkout "$*"
		else
			echo "Creating new branch"
			git checkout -b "$*"
		fi
	else
		echo "Can't check out or create branch. Not in a git repo"
	fi
}

function work-on-issue() {
	issue=$(gh issue list | fzf --header "PLEASE SELECT AN ISSUE TO WORK ON" | awk -F '\t' '{ print $1 }')
	sanitized=$(gh issue view $issue --json "title" | jq -r ".title" | tr '[:upper:]' '[:lower:]' | tr -s -c "a-z0-9\n" "-" | head -c 60)
	branchname=$issue-$sanitized
	shortname=$(echo "$branchname" | head -c 30)
	if [[ ! -z "$shortname" ]]; then
		git fetch
		existing=$(git branch -a | grep -v remotes | grep "$shortname" | head -n 1)
		if [[ ! -z "$existing" ]]; then
			sh -c "git switch $existing"
		else
			bold=$(tput bold)
			normal=$(tput sgr0)
			echo "${bold}Please confirm new branch name:${normal}"
			vared branchname
			base=$(git branch --show-current)
			echo "${bold}Please confirm the base branch:${normal}"
			vared base
			git checkout -b "$branchname" origin/$base
			git push --set-upstream origin "$branchname"
		fi
	fi
}

#quickly preview item in finder
ql() {
	qlmanage -p $1 ^ /dev/null >/dev/null &
}

# TODO: [beauwilliams] --> Add docker fzf list using 'docker container ls' command
# Docker
ssh-docker() {
	docker exec -it "$@" bash
}

function fzf-eval() {
	echo | fzf -q "$*" --preview-window=up:99% --preview="eval {q}"
}

execute-fzf() {
	if [ -z "$1" ]; then
		file="$(fzf --multi)" # if no cmd provided default to ls
	else
		file=$(eval "$1 | fzf --multi") # otherwise pipe output of that command into fzf
	fi

	case "$file" in
	"") echo "fzf cancelled" ;;
	*) eval "$2" "$file" ;; #execute the second provided command on the selected file
	esac
}

function fzf-find-files-alt() {
	selected="$(fzf --multi --reverse)"
	case "$selected" in
	"") echo "cancelled fzf" ;;
	*) eval "$EDITOR" "$selected" ;;
	esac
}

function fzf-find-files() {
	local file=$(fzf --multi --reverse) #get file from fzf
	if [[ $file ]]; then
		for prog in $( #open all the selected files
			echo $file
		); do $EDITOR $prog; done
	else
		echo "cancelled fzf"
	fi
}

#Helper
is_in_git_repo() {
	git rev-parse HEAD >/dev/null 2>&1
}

#Helper
fzf-down() {
	fzf --height 50% "$@" --border
}

function brewinstaller() {

	local inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")

	if [[ $inst ]]; then
		for prog in $(echo $inst); do
			brew install $prog
		done
	fi
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
brewip() {
	local inst=$(brew search | fzf -m)

	if [[ $inst ]]; then
		for prog in $(echo $inst); do brew install $prog; done
	fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
brewup() {
	local upd=$(brew leaves | fzf -m)

	if [[ $upd ]]; then
		for prog in $(echo $upd); do brew upgrade $prog; done
	fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
brewdp() {
	local uninst=$(brew leaves | fzf -m)

	if [[ $uninst ]]; then
		for prog in $(echo $uninst); do brew uninstall $prog; done
	fi
}

#brew uninstall list enter to uninstall package
brew-uninstall() {
	execute-fzf "brew list" "brew uninstall"
}
# alias bun='brew-uninstall'

#brew uninstall list enter to uninstall cask
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

#fuzzy finder and open in vim
ff() {
	$EDITOR $(find * -type f | fzf --multi --reverse --preview "$(getFZFPreviewer)")
}
# cd into the directory of the selected file
fz() {
	local file
	local dir
	file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
	ls
}

# Find Dirs
fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m) &&
		cd "$dir"
	ls
}

# Find Dirs + Hidden
fdh() {
	local dir
	dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
	ls
}

# fdr - cd to selected parent directory
f..() {
	local declare dirs=()
	get_parent_dirs() {
		if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
		if [[ "${1}" == '/' ]]; then
			for _dir in "${dirs[@]}"; do echo $_dir; done
		else
			get_parent_dirs $(dirname "$1")
		fi
	}
	local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
	cd "$DIR"
	ls
}

# Git commit history browser, when @param provided, its a shorthand for git commit
gc() {
	if [[ $# -gt 0 ]]; then
		git commit -m "$*"
	else
		git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" |
			fzf --ansi --no-sort --reverse --tiebreak=index --preview \
				'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 | delta ; }; f {}' \
				--bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                    (grep -o '[a-f0-9]\{7\}' | head -1 |
                        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                                            {}
                                            FZF-EOF" --preview-window=right:60%
	fi
}

# get git commit sha
# example usage: git rebase -i `fcs`
commitids() {
	local commits commit
	commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
		commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
		echo -n $(echo "$commit" | sed "s/ .*//")
}

#picklist to checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
#OR just type branch "branchname"
gbrl() {
	if [ $# -eq 0 ]; then
		local branches branch
		branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
			branch=$(echo "$branches" |
				fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
			git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
	else
		git checkout "$@"
	fi

}

#Select git branches including remote and checkout to them
gbr() {
	if [ $# -eq 0 ]; then
		local branches branch
		branches=$(git branch -a) &&
			branch=$(echo "$branches" |
				fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
			git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
	else
		git checkout "$@"
	fi
}

# stashes - easier way to deal with stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
#from here: https://github.com/nikitavoloboev/dotfiles/blob/master/zsh/functions/fzf-functions.zsh
#https://github.com/nikitavoloboev/dotfiles/blob/master/zsh/functions/git-functions.zsh
stashes() {
	local out q k sha
	while out=$(
		git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
			fzf --ansi --no-sort --query="$q" --print-query \
				--expect=ctrl-d,ctrl-b
	); do
		mapfile -t out <<<"$out"
		q="${out[0]}"
		k="${out[1]}"
		sha="${out[-1]}"
		sha="${sha%% *}"
		[[ -z "$sha" ]] && continue
		if [[ "$k" == 'ctrl-d' ]]; then
			git diff $sha
		elif [[ "$k" == 'ctrl-b' ]]; then
			git stash branch "stash-$sha" $sha
			break
		else
			git stash show -p $sha
		fi
	done
}

#Show git staging area (git status)
gs() {
	git rev-parse --git-dir >/dev/null 2>&1 || { echo "You are not in a git repository" && return; }
	local selected
	selected=$(git -c color.status=always status --short |
		fzf --height 50% "$@" --preview-window right:70% --border -m --ansi --nth 2..,.. \
			--preview '(git diff --color=always -- {-1} | delta | sed 1,4d; cat {-1}) | head -500' |
		cut -c4- | sed 's/.* -> //')
	if [[ $selected ]]; then
		for prog in $selected; do nvim "$prog"; done
	fi
}

# gs() {
# git rev-parse --git-dir > /dev/null 2>&1 || { echo "You are not in a git repository" && return }
# local selected
# selected=$(git -c color.status=always status --short |
#     fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
#     --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
#     cut -c4- | sed 's/.* -> //')
#     if [[ $selected ]]; then
#         for prog in $(echo $selected);
#         do; $EDITOR $prog; done;
#     fi
# }

grr() {
	is_in_git_repo || return
	git remote -v | awk '{print $1 "\t" $2}' | uniq |
		fzf-down --tac \
			--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
		cut -d$'\t' -f1
}

# checkout git commit
checkout() {
	local commits commit
	commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
		commit=$(echo "$commits" | fzf --tac +s +m -e) &&
		git checkout $(echo "$commit" | sed "s/ .*//")
}

fbr() {
	is_in_git_repo || return
	git branch -a --color=always | grep -v '/HEAD\s' | sort |
		fzf-down --ansi --multi --tac --preview-window right:70% \
			--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
		sed 's/^..//' | cut -d' ' -f1 |
		sed 's#^remotes/##'
}

tags() {
	is_in_git_repo || return
	git tag --sort -version:refname |
		fzf-down --multi --preview-window right:70% \
			--preview 'git show --color=always {} | head -'$LINES
}

# fh - Repeat history, assumes zsh
history() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Search env variables
vars() {
	local out
	out=$(env | fzf)
	echo $(echo $out | cut -d= -f2)
}

# Kill process
fkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

# Restart my buggy mouse app
restartmouse() (
	PID=$(ps -eaf | grep LogiMgrDaemon | grep -v grep | awk '{print $2}')
	if [[ "" != "$PID" ]]; then
		echo "killing LogiMgrDaemon with PID $PID"
		kill -9 "$PID"
	fi
)

#Zip files
# archive() {
#    zip -r "$1".zip -i "$1" ;
# }
# compress <file/dir> - Compress <file/dir>.
compress() {
	dirPriorToExe=$(pwd)
	dirName=$(dirname $1)
	baseName=$(basename $1)

	if [ -f $1 ]; then
		echo "It was a file change directory to $dirName"
		cd $dirName
		case $2 in
		tar.bz2)
			tar cjf $baseName.tar.bz2 $baseName
			;;
		tar.gz)
			tar czf $baseName.tar.gz $baseName
			;;
		gz)
			gzip $baseName
			;;
		tar)
			tar -cvvf $baseName.tar $baseName
			;;
		zip)
			zip -r $baseName.zip $baseName
			;;
		*)
			echo "Method not passed compressing using tar.bz2"
			tar cjf $baseName.tar.bz2 $baseName
			;;
		esac
		echo "Back to Directory $dirPriorToExe"
		cd $dirPriorToExe
	else
		if [ -d $1 ]; then
			echo "It was a Directory change directory to $dirName"
			cd $dirName
			case $2 in
			tar.bz2)
				tar cjf $baseName.tar.bz2 $baseName
				;;
			tar.gz)
				tar czf $baseName.tar.gz $baseName
				;;
			gz)
				gzip -r $baseName
				;;
			tar)
				tar -cvvf $baseName.tar $baseName
				;;
			zip)
				zip -r $baseName.zip $baseName
				;;
			*)
				echo "Method not passed compressing using tar.bz2"
				tar cjf $baseName.tar.bz2 $baseName
				;;
			esac
			echo "Back to Directory $dirPriorToExe"
			cd $dirPriorToExe
		else
			echo "'$1' is not a valid file/folder"
		fi
	fi
	echo "Done"
	echo "###########################################"
}

# TODO: Write a Go CLI that wraps extract and compress functions + more.
# extract <file.tar> - Extract <file.tar>.
extract() {
	local remove_archive
	local success
	local file_name
	local extract_dir

	if (($# == 0)); then
		echo "Usage: extract [-option] [file ...]"
		echo
		echo Options:
		echo "    -r, --remove    Remove archive."
	fi

	remove_archive=1
	if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
		remove_archive=0
		shift
	fi

	while (($# > 0)); do
		if [[ ! -f "$1" ]]; then
			echo "extract: '$1' is not a valid file" 1>&2
			shift
			continue
		fi

		success=0
		file_name="$(basename "$1")"
		extract_dir="$(echo "$file_name" | sed "s/\.${1##*.}//g")"
		case "$1" in
		*.tar.gz | *.tgz) [ -z $commands[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
		*.tar.bz2 | *.tbz | *.tbz2) tar xvjf "$1" ;;
		*.tar.xz | *.txz) tar --xz --help &>/dev/null &&
			tar --xz -xvf "$1" ||
			xzcat "$1" | tar xvf - ;;
		*.tar.zma | *.tlz) tar --lzma --help &>/dev/null &&
			tar --lzma -xvf "$1" ||
			lzcat "$1" | tar xvf - ;;
		*.tar) tar xvf "$1" ;;
		*.gz) [ -z $commands[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.xz) unxz "$1" ;;
		*.lzma) unlzma "$1" ;;
		*.Z) uncompress "$1" ;;
		*.zip | *.war | *.jar | *.sublime-package) unzip "$1" -d $extract_dir ;;
		*.rar) unrar x -ad "$1" ;;
		*.7z) 7za x "$1" ;;
		*.deb)
			mkdir -p "$extract_dir/control"
			mkdir -p "$extract_dir/data"
			cd "$extract_dir"
			ar vx "../${1}" >/dev/null
			cd control
			tar xzvf ../control.tar.gz
			cd ../data
			tar xzvf ../data.tar.gz
			cd ..
			rm *.tar.gz debian-binary
			cd ..
			;;
		*)
			echo "extract: '$1' cannot be extracted" 1>&2
			success=1
			;;
		esac

		((success = $success > 0 ? $success : $?))
		(($success == 0)) && (($remove_archive == 0)) && rm "$1"
		shift
	done
}

tmux-2pane() {
	getHelp() (
		echo "Creates a new detached tmux session with 2 panes"
		echo "With an option to run a command in left and right pane"
		echo " "
		echo 'USAGE: ./tmux-2pane.sh foo_bar "echo foo" "echo bar"'
		echo 'Creates a session named foo_bar, running echo commands in the left and right panes respectively'
		echo " "
		echo "options:"
		echo "-h, --help                show brief help"
		exit 0

	)

	if [[ "$#" -eq 0 ]]; then
		getHelp
		exit
	else
		# while test $# -gt 0; do
		case "$1" in
		-h | --help)
			getHelp
			shift
			;;
		*)
			tmux new-session -s "$1" -d
			echo -n "Would you like to create a vertical or horizontal split (enter for h) v/h?: "
			read -r REPLY

			if [[ $REPLY == ^[Vv]$ ]]; then
				tmux split-window -v
			else
				tmux split-window -h
			fi
			if [[ "$#" -gt 1 ]]; then
				tmux send-keys -t "$1"".0" "$2" ENTER
			fi
			if [[ "$#" -gt 2 ]]; then
				tmux send-keys -t "$1"".1" "$3" ENTER
			fi
			;;
		esac
		# done
	fi

	echo -n "Would you like to attach to the tmux session ""$1"" (enter for n) y/n?: "
	read -r REPLY

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		tmux -2 attach-session -d
	fi
}

function blog() {
	if [[ "$#" -eq 0 ]]; then
		echo "Please provide Post name"
	else
		echo -n "Enter blog post title: "
		read -r title
		echo -n "Enter blog post description: "
		read -r description
		date=$(date '+%d/%m/%Y')
		cd ~/Git_Downloads/blog-sites/my-nextjs-blog/ &&
			cat <<EOF >~/Git_Downloads/blog-sites/my-nextjs-blog/posts/"$*".md && nvim ~/Git_Downloads/blog-sites/my-nextjs-blog/posts/"$*".md +MarkdownPreview
---
title: $title
description: $description
date: $date
---


# A new blog about "$*"
EOF
	fi
}

function justinit() (
	cat <<EOF >./justfile
#NOTE: Autogenerated template by @beauwilliams
# Declaratively set shell recipes a.k.a commands should run in
set shell := ["bash", "-uc"]

# Load environment variables
set dotenv-load := true
# apikey:
#    echo "$API_KEY from .env"

# set positional-arguments := true
# foo:
#   echo $0
#   echo $1

# Colours

RED:= "\\\033[31m"
GREEN:= "\\\033[32m"
YELLOW:= "\\\033[33m"
BLUE:= "\\\033[34m"
MAGNETA:= "\\\033[35m"
CYAN:= "\\\033[36m"
WHITE:= "\\\033[37m"
BOLD:= "\\\033[1m"
UNDERLINE:= "\\\033[4m"
INVERTED_COLOURS:= "\\\033[7m"
RESET := "\\\033[0m"
NEWLINE := "\\n"

# Recipes

#This recipe will be the default if you run just without an argument, e.g list out available commands
default:
    @just --list --unsorted --list-heading $'{{BOLD}}{{GREEN}}Available recipes:{{NEWLINE}}{{RESET}}'
hello:
    @#Hide the recipe being run in the output using an @ symbol
    @#Here we use our hidden helper to prettify the text
    @just _bold_squares "{{YELLOW}}Hello World!"

#By default it prints the recipe that was run in output before outputting result
display:
    echo -e "Hello World! {{UNDERLINE}}Here we see the recipe that was run printed also by omitting @ in front of recipe"

whoami \$name:
    @#Recipe param as env variable with $ sign
    echo \$name

# Tip use ni to automatically determine your package manager
install *PACKAGES:
    @#Recipe param as list of packages
    @ni {{PACKAGES}}
install-dev *PACKAGES:
    @#Recipe param as list of packages
    @ni -D {{PACKAGES}}


# Tip: Private/helper recipes start with _
_build:
    @echo "Building..."

# Tip: Use variables with ':=' for reuse
NODE_ENV := "development"
build:
    @echo "Building in {{NODE_ENV}}"

# Tip: Create recipe aliases with 'alias'
alias b := build
alias t := test

# Tip: Use dependencies by adding them after the recipe name with a colon
lint:
    @echo 'Linting...'
test: lint build
    @echo 'Testing...'


# Tip: Use backticks for command substitution
current_branch := \`git branch --show-current\`
branch:
    @echo "On branch {{current_branch}}"

# Tip: Use indentation for multi-line commands
setup:
    #!/usr/bin/env bash
    echo "Setting up..."
    npm install
    cp .env.example .env

# Tip: Use parameters with default values
serve port='3000':
    npm start -- --port={{port}}

# Tip: Use conditionals with if/else
deploy ENV:
    @if [ "{{ENV}}" = "prod" ]; then         echo "Deploying to production";     else         echo "Deploying to staging";     fi

# Tip: Export environment variables for child processes
export RUST_BACKTRACE := "1"

# Tip: Recipe documentation appears in --list
# Lists all files in a directory
# Usage: just ls path
ls path:
    @ls {{path}}

# Tip: Load .env variables with dotenv-load
# Then use them in recipes:
load-env:
    @echo "API key: "

# Hidden Recipes

_bold_squares message:
    @#Hidden recipes have _ in front, i.e these can be helpers such as pretty printer below
    @echo -e "{{BOLD}}[{{RESET}}{{message}}{{RESET}}{{BOLD}}]{{RESET}}"
EOF
)

#USAGE: mdrender README.md
mdrender() {
	HTMLFILE="$(mktemp -u).html"
	jq --slurp --raw-input '{"text": "\(.)", "mode": "markdown"}' "$1" |
		curl -s --data @- https://api.github.com/markdown >"$HTMLFILE"
	echo Opening "$HTMLFILE"
	open "$HTMLFILE"
}

# Colour/Color echo prompt outputs
#USAGE: cecho @b@green[[Success]]
cecho() (
	echo "$@" | sed \
		-e "s/\(\(@\(red\|green\|yellow\|blue\|magenta\|cyan\|white\|reset\|b\|u\)\)\+\)[[]\{2\}\(.*\)[]]\{2\}/\1\4@reset/g" \
		-e "s/@red/$(tput setaf 1)/g" \
		-e "s/@green/$(tput setaf 2)/g" \
		-e "s/@yellow/$(tput setaf 3)/g" \
		-e "s/@blue/$(tput setaf 4)/g" \
		-e "s/@magenta/$(tput setaf 5)/g" \
		-e "s/@cyan/$(tput setaf 6)/g" \
		-e "s/@white/$(tput setaf 7)/g" \
		-e "s/@reset/$(tput sgr0)/g" \
		-e "s/@b/$(tput bold)/g" \
		-e "s/@u/$(tput sgr 0 1)/g"
)
