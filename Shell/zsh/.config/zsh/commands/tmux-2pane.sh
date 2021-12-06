#!/usr/bin/env bash

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

echo -n "Would you like to attach to the tmux session ""$1""? y/n: "
read -r REPLY

if [[ $REPLY =~ ^[Yy]$ ]]; then
	tmux -2 attach-session -d
fi
