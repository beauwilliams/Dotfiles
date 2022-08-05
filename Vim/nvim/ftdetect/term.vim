augroup TermDetect
    au!
    " I want the filetype "term" for terminal windows
    au TermOpen term://*  set filetype=term
    "Enter insert mode automatically on first run
    au TermOpen term://* :startinsert
    "Enter insert mode automatically subsequent visits to buffer
    " au BufEnter * if &buftype == 'terminal' | :startinsert | endif

augroup END

