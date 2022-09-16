function! s:RunInInteractiveShell(command, bang)
  let saved_shellcmdflag = &shellcmdflag
  set shellcmdflag+=il
  try
    if a:bang
      silent execute '!clear'
    endif
    execute '!' . a:command
  finally
    execute 'set shellcmdflag=' . saved_shellcmdflag
  endtry
endfunction

command! -bang -nargs=1 Shell call <sid>RunInInteractiveShell(<f-args>, <bang>0)

" abbreviations below allow us to quick run shell cmd without needing to use shift key :]
