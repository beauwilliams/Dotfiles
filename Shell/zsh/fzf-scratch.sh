#### USAGE - notes <note>
#TODO: [beauwilliams] --> Make a proper doc for the tool

### EXAMPLES

#notes - opens a searchable list of your notes
#notes 123.md - creates new note 123.md and displays it in the list

#!/usr/bin/env bash
set -e
#Note, must provide full path no ~
# TODO: [beauwilliams] --> Make it so users can override the vars with their own configs
export NOTES_DIR="/Users/admin/.notes/"
export NOTES_FILE_FORMAT="md"
export BAT=true #optionally set cat as default output in preview


#MAIN
notes() {
    previous_file="$@"
    file_to_edit=`helper $*`

    if [ -n "$file_to_edit" ] ; then
        if [ $EDITOR = "nvim" ] ; then
            $EDITOR "$file_to_edit" +startinsert #start insert automatically for nvim
        else
            $EDITOR "$file_to_edit"
        fi
        #TODO: [beauwilliams] --> Decide if we want fzf to autoclose or stay open when editor closed or make it an option
        notes "$*" #resume fzf when we close editor?
    fi
}

#HELPER
helper() {
  file_name="$*"
  #IF NOTE NOT FOUND WITH PROVIDED FILENAME, MAKE A NEW ONE
  if [ -n "$file_name.*" ] ; then       touch $NOTES_DIR"$file_name".$NOTES_FILE_FORMAT
      # TODO: [beauwilliams] --> Decide if I want it to auto-open file or not
      # $EDITOR ~/.notes/"$file_name".md
      # notes "$file_name"
  fi
  #OUTPUT ONLY FILENAMES + COLORISED BAT PREVIEW AS DEFAULT @ RHS -- OPTION TO SET CAT
  if [ $BAT = true ] ; then
      find $NOTES_DIR* | fzf --delimiter / --with-nth -1 --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:70%:wrap --query="$file_name"
  else
      find $NOTES_DIR* | fzf --delimiter / --with-nth -1 --preview="cat{}" --preview-window=right:70%:wrap --query="$file_name"
  fi
}

#INIT
#TODO: [beauwilliams] --> Is this the right way?
notes $@
