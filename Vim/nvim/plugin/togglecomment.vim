" source: https://stackoverflow.com/a/24046914/2571881
let s:comment_map = {
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "zshrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \   "markdown": '<\!--',
    \   "html": '<\!--',
    \ }


"Our function using regex based logic
function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ '^\s*$'
            " Skip empty line
            return
        endif
        " Uncomment the line
        if getline('.') =~ '^\s*' . comment_leader
            " Account for wrappers like HTML or MD. Quick hack around for now.
            if &filetype=='markdown' || &filetype=='html'
                    execute ":silent! normal :nohlsearch\<CR>:s/<!--//\<CR>=="
                    execute ":silent! normal :nohlsearch\<CR>:s/-->//\<CR>=="
            else
                execute 'silent s/\v\s*\zs' . comment_leader . '\s*\ze//'
            endif
        " Comment the line
        else
            execute 'silent s/\v^(\s*)/\1' . comment_leader . ' /'
            " Account for wrappers like HTML or MD. Quick hack around for now.
            if &filetype=='markdown' || &filetype=='html'
                execute "g/$/norm A -->"
            endif

        endif
    else
        echo "No comment leader found for filetype"
    endif
endfunction

"Set up key shortcuts
"NOTE: Leaving to user to set up their own shortcuts but this is left as example
" nnoremap <silent><Leader>0 :call ToggleComment()<CR>
" vnoremap <silent><Leader>0 :call ToggleComment()<CR>

