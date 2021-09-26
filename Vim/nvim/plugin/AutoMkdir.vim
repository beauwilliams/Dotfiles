"AUTOMATICALLY CREATE NEW PARENT FOLDER ON SAVE IF NOT ALREADY CREATED
"SAVES A LOT OF MKDIR COMMANDS :)
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            let confirm = input('Parent folders not found. y/n to confirm: ')
            if confirm=="y"
                call mkdir(dir, 'p')
            endif
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
