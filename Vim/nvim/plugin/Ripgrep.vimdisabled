
"==========================START RIPGREP CONFIGS=============================

    "____     ____    ____    ______    ____     ______    ____
   "/ __ \   /  _/   / __ \  / ____/   / __ \   / ____/   / __ \
  "/ /_/ /   / /    / /_/ / / / __    / /_/ /  / __/     / /_/ /
 "/ _, _/  _/ /    / ____/ / /_/ /   / _, _/  / /___    / ____/
"/_/ |_|  /___/   /_/      \____/   /_/ |_|  /_____/   /_/



"This fn replaces grep with Ripgrep, so we can do better search and replace.
"Also prevents searching .git files and some other sane defaults
try
if executable('rg')
        set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

"let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

"RIPGREP CONFIG - Prevent :Rg searching files, we want to search within files
"only. We have FZF :Files to search for files
"
function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')
        let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
"NOTE NEED TO MAP TO NEW COMMAND "RG" instead of "Rg"
command! -nargs=* -bang RG call RipgrepFzf(<q-args>,<bang>0)
"
"
"HOW TO SEARCH AND REPLACE IN MULTIPLE FILES --
"All we have to do is be in a file with the string to replace and do this
":grep \"string" -- if we arent in file with string to replace yet
":cfdo %s/test/success/g | update -- all we need to do is pipe the result of
"the first find and replace to :update and it will save the file for us then
"ripgrep recursively does the rest automatically as we have set it up to work
"that way
"NOTE - We can also F&R multiple open files only using buffers like so -- :bufdo %s/pizza/donut/g | update

"WHY RIPGREP MAKES OUR LIFE EASIER
"Otherwise we would have to search recursively each time like so :grep \"test" . -R
"Now we can just do :grep \"test" and we get a recursive search

catch
    echo 'RipGrep not installed.'
endtry


"==========================END RIPGREP CONFIGS=============================
