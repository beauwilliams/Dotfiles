#!/usr/bin/env bash

CHT_SH_LIST_CACHE=$HOME/'.cache/cht_sh_cached_list'


#Cache the list on first run
if [ ! -f "$CHT_SH_LIST_CACHE" ]; then
    echo "First time run. Downloading cht.sh cht.sh/:list to cache..."
    curl cht.sh/:list > $CHT_SH_LIST_CACHE
fi



#Select a cht.sh cheat from the list
selected=`cat $CHT_SH_LIST_CACHE | fzf --reverse --height 75% --border -m --ansi --nth 2..,.. --prompt='CHT.SH> ' --preview='curl -s cht.sh/{-1}' --preview-window=right:60%`
if [[ -z $selected ]]; then
    exit 0
fi

#Ask the user what they would like to query
read -p "Type a $selected topic to query (Empty query prints $selected summary): " query

#Retreive the cheatsheet from cht.sh
if grep -qs "$selected" $CHT_SH_LIST_CACHE; then
    query=`echo $query | tr ' ' '+'`
    if [[ -z $query ]]; then
        echo "curl cht.sh/$selected" & curl cht.sh/$selected
    else
        echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query
    fi
else
    #If its not in the cache, query cht.sh anyways and hope for the best
    curl -s cht.sh/$selected~$query
fi
