#!/usr/bin/env bash
set -e


#### USAGE - notes <note>

### EXAMPLES

#notes - opens a searchable list of your notes
#notes 123.md - creates new note 123.md and displays it in the list

main() {
  previous_file="$@"
  file_to_edit=`select_file $*`

  if [ -n "$file_to_edit" ] ; then
    "nvim" "$file_to_edit"
    main "$file_to_edit"
  fi
}

select_file() {
  given_file="$*"
  if [ -n "$given_file.*" ] ; then #makes a new note e.g notes newnote.md
      touch ~/.notes/"$given_file".md
      # $EDITOR ~/.notes/"$given_file".md
      # main "$given_file"
  fi
  find ~/.notes/* | fzf --preview="cat {}" --preview-window=right:70%:wrap --query="$given_file"
}

main $@
