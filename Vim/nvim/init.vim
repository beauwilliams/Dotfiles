"============================START MY PLUGINS===============================
"
"
"
"
if &compatible
  set nocompatible               " Using vim-plug
endif
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Gruvbox Theme
Plug 'gruvbox-community/gruvbox'
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'mhinz/vim-startify' "startup screen for vim allowing you to open recent files and stuff
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'laher/fuzzymenu.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'rust-lang/rust.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"============================START MY CONFIGS===============================
"
"
"BEAU CONFIGS
set autoindent "enable auto-indentation"
set smartindent  " smart  autoindent (e.g. add indent after '{')
syntax on  "enable syntax highlighting"
set number "enable line numbers"
set softtabstop=4 "option so make backspace delete entire tab"
set tabstop=4 "setting tab to 4 spaces"
set expandtab "this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up"
set cursorline "enable line under cursor"
"let skip_defaults_vim=1 "is this useful? - Disabled 14/apr/20
set incsearch "search as characters are entered"
set hlsearch "highlight matches"
set ignorecase "Ignore cases when searching
set smartcase "However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
set backspace=indent,eol,start " this makes backspace work as normal
set scrolloff=5 "Set the cursor 5 lines down instead of at the top
set undofile "Keeps undo history even after we close a file
set encoding=UTF-8 "REQUIRED BY DEV ICONS PLUGIN
"match opening and closing braces
set showmatch
"hopefully this speeds up vim!
set lazyredraw
set autochdir "sets the cwd to whatever file is in view. This allows better ommicompletion
set wildmenu "enhanced tab completion for vim command bar
"making vim autocomplete more bash-autocomplete like - NOTE we are also
"setting it to display a list of suggestions, and a bar that lets us select
"which completion we would like using wildmode var
set wildmode=list,full
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50


"THEME CONFIG
syntax enable
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='soft' " lightens up gruvbox, too dark otherwise
"let g:solarized_termcolors=256
set t_Co=256 "enabling 256 color support
"set termguicolors "enabling terminal color support
"let g:rehash256 = 1 "enabling 256 support for molokai


"==========================CONFIGS UNDER TESTING=============================
"
"
"
"FROM https://github.com/erkrnt/awesome-streamerrc/blob/master/ThePrimeagen/.vimrc

"Auto Whitspace trimming!!
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()


"FZF CONFIGS
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } } "fzf opens in pop up window instead of down bottom
"Enabling :find to search entire current directory of project you are working in using recursion
set path+=**

" share system clipboard but also retain nvim clipboard (see += compared
"to just =) essentially instead of overwriting we are appending to a list of
"copied things to the clipboard
set clipboard+=unnamed


"TESTING https://github.com/ycm-core/YouCompleteMe/issues/560
"let g:ycm_collect_identifiers_from_tags_files = 1

"Highlight whitespaces in white so I can easily find and remove them
"use :help highlight to find highlight groups like one used below
"match StatusLineNC /\s\+$/
"==============================END CONFIGS=======================================
"
"
"
"
"
"=============================START REMAPS========================================

"Go to start and end of line quick!
"nmap e $ use shift+A and shift+S instead :)
"nmap s 0
nmap ; :
"NO MORE SHIFT KEY :D
"Using this will give you an error, user defnd cmds in vim must start with
"capital letter command fzf execute "FZF"
"The below works beautifully!
cnoreabbrev fzf FZF
"
"Speeding up auto correction toggle for my uni lectures
"Note plgn is Vim-you-autocorrect
cnoreabbrev spellon EnableAutocorrect
cnoreabbrev spelloff  DisableAutocorrect


"Clear highlights quick!
nnoremap c<space> :nohlsearch<cr>
"Replace/Delete words quick!
"nnoremap ,x *``cgn
nnoremap c. /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c, ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap d. /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap d, ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN

imap jj <ESC>

"Remove superfluous whitespaces with F2!
nnoremap <F2> :let _save_pos=getpos(".") <Bar>
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
nmap <Leader>p :FZF<cr>
vmap <Leader>p :FZF<cr>
"Fuzzymenu Mappings
nmap <Leader><Leader> <Plug>Fzm
vmap <Leader><Leader> <Plug>FzmVisual

"NERD TREE - FILE SIDEBAR MAPPINGS
"note the cr is an enter, i.e it hits enter and does the command
nmap <Leader>n :NERDTreeToggle<cr>



"==========================MAPPINGS UNDER TESING=============================

"Lets see what all this hype is about.. the CHAD of file tree viewers, CHADtree
nnoremap <leader>v <cmd>CHADopen<cr>
"=============================END REMAPPINGS===============================
"
"
"============================BEGIN STATUSLINE CONFIG=======================
"
"
"===============================END VIM CONFIG=================================
"


function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elseif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction

"if MyOnBattery()
  "call neomake#configure#automake('w')
"else
  "call neomake#configure#automake('nw', 1000)
"endif
"
" Copy to clipboard -- RETIRED, just remember "+y
"vnoremap  <leader>y  "+y
"nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+y
"nnoremap  <leader>yy  "+yy

" " Paste from clipboard
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P
"vnoremap <leader>p "+p
"vnoremap <leader>P "+P
