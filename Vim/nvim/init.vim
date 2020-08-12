" ===========================START MY PLUGINS===============================
"
"
if &compatible
        set nocompatible " Using vim-plug we must set not compatible with old vim
endif


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

"THEME/UX
Plug 'gruvbox-community/gruvbox'
Plug 'https://github.com/noscript/cSyntaxAfter' "Adds a little visual bling to () etc for semantic langs like c
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify' "startup screen for vim allowing you to open recent files and stuff
Plug 'vim-airline/vim-airline' "FROM HERE https://oracleyue.github.io/2019/11/07/vim-powerline/
Plug 'vim-airline/vim-airline-themes' "FROM HERE https://github.com/vim-airline/vim-airline-themes Once installed, use :AirlineTheme <theme> to set theme

" COC PLUGS
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
"END COC PLUGS -- Note as of 8/20 - COC supports installing extensions via
"plugs -- we will migrate to this over time easier for automation this way
"
"
"FILE NAV
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "FUZZY FINDER
Plug 'laher/fuzzymenu.vim' "HELP MENU FOR FF
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "FILE BROWSER
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

"LANG PLUGS
Plug 'rust-lang/rust.vim'
Plug 'uiiaoo/java-syntax.vim'
Plug 'sbdchd/neoformat'
Plug 'w0rp/ale' "provides errors in the gutter and linting


"GIT PLUGINS
Plug 'airblade/vim-gitgutter' "Git diff gutter
Plug 'rhysd/git-messenger.vim' "leader-gm to GIT BLAME i.e who wrote that code commit info
Plug 'tpope/vim-fugitive'

"OTHER
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
Plug 'tpope/vim-eunuch' "Allows us to do cool UNIX CLI stuff like :SudoWrite to write to read only files
call plug#end()

"============================START MY CONFIGS===============================
"
"
"BEAU CONFIGS
set autoindent "enable auto-indentation"
set smartindent  " smart  autoindent (e.g. add indent after '{')
set number "enable line numbers"
set softtabstop=4 "option so make backspace delete entire tab"
set tabstop=4 "setting tab to 4 spaces"
set expandtab "this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up"
set cursorline "enable line under cursor"
set incsearch "search as characters are entered"
set hlsearch "highlight matches"
set ignorecase "ignore cases when searching
set smartcase "However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
set backspace=indent,eol,start " this makes backspace work as normal
set scrolloff=5 "Set the cursor 5 lines down instead of at the top
set undofile "Keeps undo history even after we close a file
set encoding=UTF-8 "REQUIRED BY DEV ICONS PLUGIN
set showmatch "match opening and closing braces
set lazyredraw "hopefully this speeds up vim!
set wildmenu "enhanced tab completion for vim command bar
set wildmode=list,full "Displays a handy list of commands we can tab thru"
set updatetime=50 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience. - some dude on the internet (not my idea)

"THEME CONFIG
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="soft" " lightens up gruvbox, too dark otherwise
set termguicolors "enabling terminal color support
set t_Co=256 "enabling 256 color support
colorscheme gruvbox
let g:airline_theme='gruvbox' "SET GRUVBOX AS STATUS BAR THEME


"==========================CONFIGS UNDER TESTING=============================
"
"
"set autochdir "sets the cwd to whatever file is in view. This allows better ommicompletion
"This kind of makes workflows annoying where it screws up fzf if i enter a
"file within a tree, I cant get back to files at the root
"Seems like our completion is g anyways -- review later
"
"FROM https://github.com/erkrnt/awesome-streamerrc/blob/master/ThePrimeagen/.vimrc
"Auto Whitspace trimming!!
fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()




set clipboard+=unnamed " share system clipboard but also retain nvim clipboard (see += compared
"to just =) essentially instead of overwriting we are appending to a list of copied things to the clipboard



"SET RELATIVE LINE NUMBERS IN RULER
set relativenumber

"ENABLE BUFFERS TO HIDE - PREVENTS ERROR:
"E37: No write since last change (add ! to override)
"When opening a new buffer before saving current one
set hidden


"
"------AUTO RESIZING WINDOWS----------
"
"UNDER TESTING LETS SEE IF WE LIKE THIS WORKFLOW
" From https://github.com/knubie/dotfiles/blob/fe7967f875945e54d49fc672f575c47691a1e4cc/.vimrc#L136
augroup ReduceNoise
        autocmd!
        " Automatically resize active split to 85 width
        autocmd WinEnter * :call ResizeSplits()

        autocmd WinEnter * setlocal cursorline
        autocmd WinEnter * setlocal signcolumn=auto

        autocmd WinLeave * setlocal nocursorline
        autocmd WinLeave * setlocal signcolumn=no

augroup END

function! ResizeSplits()
        if &ft == 'nerdtree'
                return
        elseif &ft == 'qf'
                " Always set quickfix list to a height of 10
                resize 10
                return
        else
                set winwidth=120
                wincmd =
        endif
endfunction

"-----------------------------------------


"############UNDER TESTING############
"SORT OF LIKE A PRETTIFIER FOR OUR BRACES AND STUFF TO GIVE THEM DIFFERENT
"COLOURS
autocmd! FileType c,cpp,java,php call CSyntaxAfter()


"==============================END CONFIGS=======================================
"
"
"
"
"
"=============================START REMAPS========================================

"LEADER KEY IS THE SPACE BAR
let mapleader = "\<Space>"


"


"Speeding up auto correction toggle for my uni lectures
"Note plgn is Vim-you-autocorrect
cnoreabbrev spellon EnableAutocorrect
cnoreabbrev spelloff  DisableAutocorrect


"Clear highlights quick!
nnoremap <silent><leader>c :nohlsearch<cr>

"FORMATTERS
"Remove indents from code! (a simple code formatter)
nnoremap <silent><leader>i gg=G
"Run Neoformat
nnoremap <silent><leader>F :Neoformat<CR>


"FIND AND REPLACE
"Replace/Delete words quick! ONE BY ONE
"nnoremap ,x *``cgn
nnoremap <silent>c. /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <silent>c, ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap <silent>d. /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap <silent>d, ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN


"jj to escape quick yo
imap jj <ESC>

"Remove superfluous whitespaces with leader W (as in the shift-w big W)
"We user <leader>w elsewhere to move between windows quick
nnoremap <leader>W :let _save_pos=getpos(".") <Bar>
                        \ :let _s=@/ <Bar>
                        \ :%s/\s\+$//e <Bar>
                        \ :let @/=_s <Bar>
                        \ :nohl <Bar>
                        \ :unlet _s<Bar>
                        \ :call setpos('.', _save_pos)<Bar>
                        \ :unlet _save_pos<CR><CR>

"NOTE: Mapped iTERM2 CMD+/ to ++ so we can overload the vim + function
"already there

"FuzzyFinderMappings AKA ctrl+p search like say vscode
nnoremap <silent><Leader>p :Files<cr>
nnoremap <silent> <Leader>h :History<CR>

"Ripgrep Mappings / NOTE We also have Silver Searcher Optionally Available :Ag
"FIND WORDS RECURSIVELY AND FAST IN YOUR CWD
"leader-s for SEARCH
nnoremap <silent> <Leader>f :RG<CR>

"leader-b for BUFFER LIST (show buffers)
"leader-s for SPLIT CYCLING (cycle current windows)
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <leader>w <C-w>w



"Fuzzymenu Mappings
nmap <silent><Leader><Leader> <Plug>Fzm
vmap <silent><Leader><Leader> <Plug>FzmVisual

nmap <Leader>n :NERDTreeToggle<cr>



"Resize our splits with <leader> +/- easily
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>. :vertical resize -10<CR>
nnoremap <silent> <leader>, :vertical resize +10<CR>


"Show git commit that introduced line after cursor, bit like GIT BLAME, BUT
"NOW WE CAN INCLUDE OUR VIM ;)

"==========================MAPPINGS UNDER TESING=============================

"Lets see what all this hype is about.. the CHAD of file tree viewers, CHADtree
"Get out of here NERDS
nnoremap <silent><leader>v <cmd>CHADopen<cr>
nmap <silent><leader>e :CocCommand explorer<CR>



"
"=============================END REMAPPINGS===============================
"
"
"============================BEGIN FUNCTIONS CONFIG=======================


"ENABLE SYNTAX ONLY ONCE, TO PREVENT OVERWRITING
if !exists("g:syntax_on")
        syntax enable
endif


"self descriptive -- highlights yanked text for a little extra visual feedback
"so we don't need to rely on visual mode as much, try yip or y4y
"NOTE REQUIRES NVIM V5
augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END




""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""EASY WINDOW MANAGEMENT""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""
"default move between splits with ctrl h j k l
"IF no split to move to, create a new split
function! WinMove(key)
        let t:curwin = winnr()
        exec "wincmd ".a:key
        if (t:curwin == winnr())
                if (match(a:key,'[jk]'))
                        wincmd v
                else
                        wincmd s
                endif
                exec "wincmd ".a:key
        endif
endfunction


"MOVE BETWEEN WINDOWS SUPER QUICK
"OPEN NEW WINDOWS IF NO WINDOWS EXIST,
"SORTA LIKE WE HAVE OVERLOADED IT :P
"Just space-hjkl
nnoremap <silent><leader>h :call WinMove('h')<CR>
nnoremap <silent><leader>j :call WinMove('j')<CR>
nnoremap <silent><leader>k :call WinMove('k')<CR>
nnoremap <silent><leader>l :call WinMove('l')<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""

"
"============================END FUNCTIONS CONFIG=======================
"
"
"============================BEGIN STATUSLINE CONFIG=======================
"
" Abbreviating INSERT NORMAL etc to just the first character
let airline_mode_map = {
                        \ '__'      : '_',
                        \ 'c'       : 'C',
                        \ 'i'       : 'I',
                        \ 'v'       : 'V',
                        \ 'n'      : 'N',
                        \ }

" remove the filetype part - now it just displays the icon
let g:airline_section_x =''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1
"Abbreviate section z, it has percentage of way down doc, line count, line
"length
"let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_section_z = "%p%%  \ue0a1 %l/%L  \ue0a3 %c"
"Remove the filetype encoding section, I dont need to specifically know this
"most of the time!
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#whitespace#checks = [ 'indent', 'mixed-indent-file', 'conflicts' ]
"Shorten 'words' to 'w' for wordcount
let g:airline#extensions#wordcount#formatter#default#fmt = '%d w'
let g:airline#extensions#wordcount#format = '%d w'
let g:airline#extensions#wordcount#enabled = 1

"=============================END STATUSLINE CONFIG=================================
"
"================================BEGIN COC CONFIG=========================
"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
else
        set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<TAB>" :
                        \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
else
        inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
        else
                call CocAction('doHover')
        endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming - RENAME / REFACTOR FILES QUICK.
nmap <leader>rn <Plug>(coc-rename)


"
"
"================================END COC CONFIG=========================
"
"
"
"
"
"================================START PRETTIER CONFIG=========================
"
"Part of prettier recommended configs
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"NOTE -- SET Prettier languages with :CocConfig
"Prettier seems to format java okay which is neat :)
"
"
"================================END PRETTIER CONFIG=========================
"
"
"
"==========================START FZF CONFIGS=============================
"
"WE ARE USING BAT - A COOL NEW RUST CAT, TO PROVIDE FANCIER PREVIEW OF CODE
"let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout=reverse --margin=1,4 --color=always --style=header,grid --line-range :300 {}'"
let $FZF_DEFAULT_OPTS="--layout=reverse --margin=1,4 --preview-window 'right:60%'"
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
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden --follow -g "!{.git,node_modules,vendor}/*"'
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
"
"
"
"
"==========================START RIPGREP CONFIGS=============================
"
"
"
"This fn replaces grep with Ripgrep, so we can do better search and replace.
"Also prevents searching .git files and some other sane defaults
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
"
"
"==========================END RIPGREP CONFIGS=============================
"
"
"
"===============================END VIM CONFIG=================================
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"===============================RETIRED CODE==================================
"
"
"
"
"Removed because I ended up just configuring fzf myself before I even got into
"using this plugin
"=========
""UNDER TESTING -- FZF PREVIEW VIM AS REPLACEMENT FOR FZF VIM, ITS S SUPER UP
"VERSION, BASICALLY A PREMADE CONFIG OF FZF WITH DEV ICONS ETC.
"let g:fzf_preview_use_dev_icons = 1
"let g:fzf_preview_command = 'bat --color=always --plain {-1}'
" https://github.com/yuki-ycino/fzf-preview.vim/blob/master/README.md
"========





" Copy to clipboard -- RETIRED, just remember "+y
" ========
"vnoremap  <leader>y  "+y
"nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+y
"nnoremap  <leader>yy  "+yy

" " Paste from clipboard
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P
"vnoremap <leader>p "+p
"vnoremap <leader>P "+P
"========
"
"
"
"
"Using fuzzy search mostly now..
"======
"NETRW MAPPINGS - Lex opens and does not close, vex opens and closes when you
"open file
"nmap <Leader>n :Lex<cr> AUG2020 - Moving back to nerdtree as our file split
"function is not working with netrw it seems to load not as a split?
"NETRW CONFIGS
"SET NETRW SIZE
"let g:netrw_winsize=22
"NETRW commands :Lex :Vex: Sex
"======
"
"
"
"
"This just got annoying to look at and use auto white trimmer now anyways
"=============
"Highlight whitespaces in white so I can easily find and remove them
"use :help highlight to find highlight groups like one used below
"match StatusLineNC /\s\+$/
"======


"Lame ass remaps from my early vim days :)
"=============
"Go to start and end of line quick!
"nmap e $ use shift+A and shift+S instead :)
"nmap s 0
"nmap ; : RETIRING - when I used the f and t commands - we can cycle through
"with , and ; so we need to remove out semi colon mapping
"NO MORE SHIFT KEY :D
"=================
"
"
"
"===============RETIRED BUT SAVE THIS FOR LATER===============
"Great function to save power when on battery if needed
"function! MyOnBattery()
"        if has('macunix')
"                return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
"        elseif has('unix')
"                return readfile('/sys/class/power_supply/AC/online') == ['0']
"        endif
"        return 0
"endfunction

"if MyOnBattery()
  "call neomake#configure#automake('w')
"else
  "call neomake#configure#automake('nw', 1000)
"endif
"==========================================================
