"==========================START FZF CONFIGS=============================

    "______   __  __ _____ _______  __           ______    ____    _   __    ____     ______    ____
   "/ ____/  / / / //__  //__  /\ \/ /          / ____/   /  _/   / | / /   / __ \   / ____/   / __ \
  "/ /_     / / / /   / /   / /  \  /          / /_       / /    /  |/ /   / / / /  / __/     / /_/ /
 "/ __/    / /_/ /   / /__ / /__ / /          / __/     _/ /    / /|  /   / /_/ /  / /___    / _, _/
"/_/       \____/   /____//____//_/          /_/       /___/   /_/ |_/   /_____/  /_____/   /_/ |_|


"WE ARE USING BAT - A COOL NEW RUST CAT, TO PROVIDE FANCIER PREVIEW OF CODE
"let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout=reverse --margin=1,4 --color=always --style=header,grid --line-range :300 {}'"
let $FZF_DEFAULT_OPTS="--layout=reverse --margin=1,4  --preview 'right:60%'"
"FZF CONFIGS
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } } "fzf opens in pop up window instead of down bottom
"let g:fzf_preview_window = 'right:60%'
let g:fzf_history_dir = '~/.local/share/fzf-history'
"Enabling :find to search entire current directory of project you are working in using recursion
set path+=**
"Shows file preview in files search etc
let g:fzf_files_options =
                        \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
"Allows us to ignore files with fzf
"WE HAVE SET RIPGREP AS OUR GREP PROVIDER - FASTEST GREP IN THE WEST
"Note, can only figure out how to ignore folders for now. tried **.classes for
"java classes sended up blocking the classes folder itself.
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden --follow -g "!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes}/*"'

"command! -bang -nargs=? -complete=dir Files
""    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir Files
                        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline', '--layout=reverse']}), <bang>0)

" The query history for this command will be stored as 'ls' inside g:fzf_history_dir.
" The name is ignored if g:fzf_history_dir is not defined.
command! -bang -complete=dir -nargs=* LS
                        \ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}, <bang>0))

"capital letter command fzf execute "FZF"
"The below works beautifully!
cnoreabbrev fzf FZF


"==========================END FZF CONFIGS=============================

