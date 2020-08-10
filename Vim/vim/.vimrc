" Makes vim not compatible with vi, no need for that old stuff!
set nocompatible

"===============================START VUNDLE==================================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git BEAU NOTE this is not working
"there is a ruby version symlink issue
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


"BEAU PLUGINS

"TEST PLUGINS

"STATUSLINE CONFIG
Plugin 'vim-airline/vim-airline' "FROM HERE https://oracleyue.github.io/2019/11/07/vim-powerline/
Plugin 'vim-airline/vim-airline-themes' "FROM HERE https://github.com/vim-airline/vim-airline-themes Once installed, use :AirlineTheme <theme> to set the theme, e.g. :AirlineTheme simple CURRENTLY USING
let g:airline_theme='gruvbox' "copies vim colours
set noshowmode "Don't need to see insert mode twice when using airline"
set shortmess+=F  " to get rid of the file name displayed in the command line bar

"GLYPH SUPPORT
Plugin 'ryanoasis/vim-devicons' "Dev icons for vim plugins - for vim airline

"AUTOCLOSING BRACKETS ETC
Plugin 'Raimondi/delimitMate'


"AUTOCOMPLETION, SYNTAX
"Plugin 'https://github.com/ycm-core/YouCompleteMe.git' "Autocompletion - using for java --- NOPE, I AM DONE. SCREW THIS DAMN SOFTWARE. YCM needs to be recompiled each update and its a total bitch to recompile and does not like conda
"Disabling YCM preview window they displays up the top
"DONT FORGET YCM NEED TO BE RE-MAKED after each update https://github.com/ycm-core/YouCompleteMe
set completeopt-=preview
"Disabling Syntastic think it was causing issues with java files for now
"Plugin 'https://github.com/vim-syntastic/syntastic.git' "Syntax highlighting

"SNIPPETS
"Adding snippets, using YCM for poups
Plugin 'SirVer/ultisnips'
"The ultisnips engine is seperate from snippets so we will add this repo
Plugin 'honza/vim-snippets'

"TAB OVERLOADING FOR SNIPPETS & AUTOCOMPLETE
Plugin 'ervandew/supertab'

"LINTING
" Ale linter extension, using YCM config for C, provideds symantic error
" detection
Plugin 'dense-analysis/ale'

"AUTOCORRECTION
"Vim auto- autocorrect uses vim 'spell' automagically
" Use :EnableAutocorrect
Plugin 'sedm0784/vim-you-autocorrect'

"COMMENT STUFF FAST
Plugin 'preservim/nerdcommenter'

"FILE BROSWER
"Plugin 'preservim/nerdtree' "Adds file system tree - if you want it = D NOTE:
"Disabled this based on advice from https://shapeshed.com/vim-netrw/ - trying
"netrw instead - less dependencies

"FUZZY FINDER
"Commenting this out, not sure if neccesary? - Plugin 'junegunn/fzf', { 'do': './install --bin' } "ensures we have most recent binaries for fzf
Plugin 'junegunn/fzf.vim' "https://github.com/junegunn/fzf.vim SEE HERE FOR MORE DETAILS
"FZF Vim config - fzf wont work without it
set rtp+=/usr/local/opt/fzf
Plugin 'https://github.com/laher/fuzzymenu.vim'


"NOTEBOOK SUPPORT (JOPLIN)
"Markdown Support for Joplin CLI
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'


"CURRENT THEME CONFIG OPTIONS
Plugin 'morhetz/gruvbox' "Theme is already downloaded but incase updates will keep here

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
"VUNDLE DOCUMENTATION
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"===========================END VUNDLE======================================
"
"
"===========================START MACVIM================================


" System vimrc file for MacVim
"
" Author:       Bjorn Winckler <bjorn.winckler@gmail.com>
" Maintainer:   macvim-dev (https://github.com/macvim-dev)

"set nocompatible we have already set this above

" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none

" Python2
" MacVim is configured by default to use the pre-installed System python2
" version. However, following code tries to find a Homebrew, MacPorts or
" an installation from python.org:
if exists("&pythondll") && exists("&pythonhome")
  if filereadable("/usr/local/Frameworks/Python.framework/Versions/2.7/Python")
    " Homebrew python 2.7
    set pythondll=/usr/local/Frameworks/Python.framework/Versions/2.7/Python
  elseif filereadable("/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python")
    " MacPorts python 2.7
    set pythondll=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python
  elseif filereadable("/Library/Frameworks/Python.framework/Versions/2.7/Python")
    " https://www.python.org/downloads/mac-osx/
    set pythondll=/Library/Frameworks/Python.framework/Versions/2.7/Python
  endif
endif

" Python3
" MacVim is configured by default to use Homebrew python3 version
" If this cannot be found, following code tries to find a MacPorts
" or an installation from python.org:
if exists("&pythonthreedll") && exists("&pythonthreehome") &&
      \ !filereadable(&pythonthreedll)
  if filereadable("/opt/local/Library/Frameworks/Python.framework/Versions/3.7/Python")
    " MacPorts python 3.7
    set pythonthreedll=/opt/local/Library/Frameworks/Python.framework/Versions/3.7/Python
  elseif filereadable("/Library/Frameworks/Python.framework/Versions/3.7/Python")
    " https://www.python.org/downloads/mac-osx/
    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.7/Python
  endif
endif

"==============================END MACVIM====================================
"
"
"============================START MY CONFIGS===============================

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

"THEME CONFIG
colorscheme gruvbox
set t_Co=256 "enabling 256 color support
"set termguicolors "enabling terminal color support
"let g:rehash256 = 1 "enabling 256 support for molokai

"
"
"==========================CONFIGS UNDER TESTING=============================
"
"
"
"FROM https://github.com/erkrnt/awesome-streamerrc/blob/master/ThePrimeagen/.vimrc
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

"Auto Whitspace trimming!!
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun



set wildmenu "enables visual autocomplete for vim command NOTE, use tab to enable
"Essentially you don't have to hit a button for suggestions to come up
"BEAU - making vim autocomplete more bash like - NOTE there is an option
"<full> which prints a full list, not really a fan as it confuses me too much
"text on screen and lose my flow
set wildmode=list,full

"Enabling :find to search entire current directory of project you are working in using recursion
set path+=**

"TESTING https://github.com/ycm-core/YouCompleteMe/issues/560
let g:ycm_collect_identifiers_from_tags_files = 1

"Highlight whitespaces in white so I can easily find and remove them
"use :help highlight to find highlight groups like one used below
match StatusLineNC /\s\+$/
"==============================END CONFIGS=======================================
"
"
"
"
"
"=============================START REMAPS========================================

"Go to start and end of line quick!
"nmap e $
"nmap s 0
"nmap ; :
"when using brace matching with % its also highlights it for us :)
noremap % v%
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


"adding autoclosing brackets map
"inoremap {<CR> {<CR>}<ESC>O
"NOTE TO SELF - REPLACED with delimitMate :help delimitmate
let g:delimitMate_expand_cr = 1


"NOTE, WE ARE USING SUPERTAB TO HELP WITH MAPPINGS
fun! GoYCM()
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
endfun

fun! GoSupertab()
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabCrMapping = 0
endfun

"fun! GoUltisnips()
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
"Disabling, so I can use s-tab to expand trigger g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"endfun


"TEST MAPPINGS
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

"NOTE: Mapped iTERM2 CMD+/ to "++" so we can overload the vim + function
"already there
"Comment line of code in Nmode, even sections in Vmode too with just cmd-/ !!
nmap ++ <plug>NERDCommenterToggle
vmap ++ <plug>NERDCommenterToggle


"=============================END REMAPPINGS===============================
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
"let g:airline#extensions#wordcount#formatter#default#fmt = '%d w'
"let g:airline#extensions#wordcount#format = '%d w'
"let g:airline#extensions#wordcount#enabled = 1

"=============================END STATUSLINE CONFIG=================================
"
"
"
"
"===============================BEGIN FUNCTION CALLS===============================
"Auto remove whitespaces!
autocmd BufWritePre * :call TrimWhitespace()
"Only enable YCM for the below files!
autocmd FileType java,python,javascript,c :call GoSupertab()
"For some reason mapping ultisnips to fn causes an issue with tabs
"autocmd FileType java,python,javascript,c :call GoUltisnips()
autocmd FileType java,python,javascript,c :call GoYCM()
"autocmd FileType cpp,cxx,h,hpp,c :call GoCoc()

"===============================END FUNCTION CALLS===============================

"
"===============================END VIM CONFIG=================================
"


