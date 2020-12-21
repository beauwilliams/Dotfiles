" ===========================KEY MAPPINGS===============================



"+++++++BASIC NAVIGATION+++++++
"
"LEADER <leader> key is SPACE
"
"ENTER COMMAND MODE QUICKLY
"Mapping -> <leader><leader> (Hit Space Twice)
"
"ENTER NORMAL MODE QUICKLY
"Mapping -> jj (hit j twice)
"
"VIM COMMANDS CHEATSHEET / HELP MENU
"<leader>?
"
"VIM CONTROL P LIKE MENU (FUZZYMENU)
"<leader>p
"
"DITCH THOSE ARROW KEYS --> MOVE UP AND DOWN *IN INSERT MODE* WITH HJKL BY SIMPLY HOLDING CONTROL
"Mapping -> <c-h> --> move left
"Mapping -> <c-j> --> move down
"Mapping -> <c-k> --> move up
"Mapping -> <c-l> --> move right




"++++++++WINDOW NAVIGATION+++++++
"
"Open new splits, use leader + hjkl to specify which direction you want to create the
"split (up, down, let, right)
"Mapping -> <leader>h <leader>j .. etc
"
"Cycle between spilts/[w]indows in a clockwise motion, *hold shift key for anticlockwise
"Mapping -> <leader>w
"
"CHANGE A SPLIT ORENTATION FROM HORIZONTAL TO VERTICAL AND VICE VERSA
"Mapping -> <leader>[ & <leader>]




"++++++++FILE NAVIGATION AND FUZZY SEARCH++++++++
"
"Open file tree to [n]avigate files
"Mapping -> <leader>n
"
"[s]earch for files by filename in the current working directory
"Mapping -> <leader>s
"
"Search for content/strings within [f]iles in the current directory
"Mapping -> <leader>f
"
"List current [b]uffers and search by buffer filenames
"Mapping -> <leader>b
"
"List previously visited file history and [S]earch by filename
"Think s to search files, and shift+s to search file history
"Mapping -> <leader>S
"
"List ALL Possible [c]ommand Mode Commands, Search and Execute Them
"Mapping -> <leader>c




"++++++++CODE NAVIGATION AND RELATED TOOLS++++++++
"
"DIAGNOSTICS NAVIGATION
"Mapping -> [g
"Mapping -> ]g
"Use Command `:CocDiagnostics` to get all diagnostics of current buffer in location list.

"GO TO CODE NAVIGATION.
"Mapping -> gd --> Go to Definition
"Mapping -> gy --> Got to Type Definition
"Mapping -> gi --> Go to Implementation
"Mapping -> gr --> Go to References

"DOCUMENTATION VIEIWING
"Use K to show documentation in preview window.




"++++++++CODE REFACTORING AND RELATED TOOLS++++++++
"
"FIND AND REPLACE
"Replace/Delete words quick! ONE BY ONE.
"*NOTE* You must first search for a string and have it highlighted first before we can change and delete based on that pattern
"after searching for a word, use c for CHANGE & d for DELETE. We use , . to move back and forth between matches respectively
"Mapping -> c.
"Mapping -> c,
"Mapping -> d.
"Mapping -> d,
"
"QUICK COMMENTING
"NOTE: It is actually ++ but I used a trick for my mac to map that key to ++ in iterm
"Mapping -> cmd+/




"++++++++CODE FORMATTING AND RELATED TOOLS++++++++
"
"Remove indents from code! (a simple code formatter)
"Mapping -> <leader>i
"
"[f]ormat code
"Mapping -> <leader>f
"
"Remove superfluous [w]hitespaces at the end of lines
"Mapping -> <leader>W




"++++++++HANDY COMMANDS++++++++
"
"Speeding up auto correction toggle for my uni lectures
"Note plgn is Vim-you-autocorrect
"Command -> spellon
"Command -> spelloff




" ===========================END MAPPINGS===============================





" ===========================START MY PLUGINS===============================


try
let g:ale_disable_lsp = 1 "Required for ale so we dont double up lsp given coc has one
catch
    :PlugInstall
    echo 'Ale not installed.'
endtry

"have tested that I get better performance over sshfs with this on
"We need to set ale off it before we load our plugins
"
"if &compatible
"        set nocompatible " Using vim-plug we must set not compatible with old vim
"endif "NOTE: According to vim manual, if we use .vimrc it will auto set
"nocompatible - no need to specify manually


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')


"THEME/UX
Plug 'gruvbox-community/gruvbox' "Seemingly the most complete and best GB theme out there. Easy on the eyes. RETIRED DEC 20 for lua port
Plug 'mhinz/vim-startify' "startup screen for vim allowing you to open recent files and stuff
Plug 'vim-airline/vim-airline' "FROM HERE https://oracleyue.github.io/2019/11/07/vim-powerline/
Plug 'vim-airline/vim-airline-themes' "FROM HERE https://github.com/vim-airline/vim-airline-themes Once installed, use :AirlineTheme <theme> to set theme
Plug 'ryanoasis/vim-devicons' "NOTE THIS MUST BE RUN AFTER AIRLINE THEMES PLUGINS
Plug 'Yggdroot/indentLine' "Code indentations marks
Plug 'lukas-reineke/indent-blankline.nvim' "an addition to indentline, we get solid lines now even between methods etc
"Plug 'habamax/vim-gruvbit' Another gruvbox alternative
"Plug 'https://github.com/noscript/cSyntaxAfter' "Adds a little visual bling to () etc for semantic langs like c
"Plug 'tjdevries/colorbuddy.nvim' "REQUIRED for npxbr/gruvbox.nvim lua port of community/gruvbox
"Plug 'npxbr/gruvbox.nvim' "lua port of gruvbox community with treesitter support


"LANG PLUGS
Plug 'sbdchd/neoformat' "Code formatting plugin
Plug 'w0rp/ale' "provides errors in the gutter and linting
"NOTE: we need to clone eclips jdtls and run ./mvnw clean verify to get it working
Plug 'preservim/nerdcommenter' "quick and easy commenting- setup to cmd+/ using iterm binding
if has("nvim-0.5") "nerdtree requires most recent nvim 0.5 nightly as of dec 2020
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  "PARSER-BASED SYNTAX SERVICE --> INSTALL LANGS WITH CMD :tsinstall <lang>
endif
Plug 'luochen1990/rainbow' "colorises our brackets and braces to help identifying them | 4/12/20 disabled treesitter gihlighting of brackets to pave way for rainbow brakets plugin
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "Adds RGB/Color visualisations next to colors i.e CSS such as ... #f14b59 NOT WORKING WITHOUT GO
"Plug 'rust-lang/rust.vim' "5/12/20 Retiring for treesitter
"Plug 'uiiaoo/java-syntax.vim' "5/12/20 Retiring For Treesitter


" COC {Language Server} PLUGS
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has("nvim-0.5") "Only the 0.5 nightly version can issue the :UpdateRemotePlugins command
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
endif
"END COC PLUGS -- Note as of 8/20 - COC supports installing extensions via
"plugs -- we will migrate to this over time easier for automation this way
"Although we lose :CocUpdate functionality.. hmm..


"FILE NAV
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "FUZZY FINDER
Plug 'laher/fuzzymenu.vim' "HELP MENU FOR FF
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "FILE BROWSER
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


"SESSION/WORKSPACE MGMT -> :SaveSession :DeleteSession :ViewSession --> sessions saved
"to .config/nvim/.session and display in startify launch menu when booting nvim
Plug 'xolox/vim-misc' "Dependeny for vim session
Plug 'xolox/vim-session' "Centralise sessions to a .sessions folder and easily save sessions with :SaveSession <name>
"Plug 'tpope/vim-obsession' "Better vim sessions with :Obsess DEC20 Replace with vim-session for now as Obsess didn't fit me


"GIT PLUGINS
Plug 'airblade/vim-gitgutter' "Git diff gutter
Plug 'rhysd/git-messenger.vim' "leader-gb to GIT BLAME i.e who wrote that code commit info and navigate history at a glance
Plug 'tpope/vim-fugitive' "Adds 'native' git commands to vim. silent commands. e.g :Git add - won't prompt you to enter to confirm
Plug 'APZelos/blamer.nvim' "Adds a VSCode GitLens Style Git Blame feature. Display who commited what line automatically


"OTHER
Plug 'tpope/vim-eunuch' "Allows us to do cool UNIX CLI stuff like :SudoWrite to write to read only files
Plug 'airblade/vim-rooter' "sets cwd automatically if are in say a git folder etc
Plug 'voldikss/vim-floaterm' "Floating terminal popups for neovim - Toggle with <leader>t
Plug 'unblevable/quick-scope' "Adds a colour effect to letters to help you use the f key to move on a line left and right faster
Plug 'danilamihailov/beacon.nvim' "Adds a flash to the cursor when we move it a large amount. Helps to keep focus.
Plug 'psliwka/vim-smoothie' " some very smooth ass scrolling


"TESTING
Plug 'tpope/vim-surround' "all we need to remember is s, for surround. cs\" for ex OR ysiw' to surround current word with ''
Plug 'jez/vim-superman' "Read man pages in vim easily with vman or :Man
cnoreabbrev man Man
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } } "DOcumentation GEnerator
Plug 'lifepillar/vim-cheat40' "Adds configurable cheat sheet with <leader>? great for remembering my mappings and custom commands
"Plug 'michaelb/vim-tips' "Display vim tip at startup
"Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "A vim game


call plug#end()


"===========================END MY PLUGINS===============================




"BEAU CONFIGS
filetype plugin indent on "Indent and stuff based on ft
set number "enable line numbers"
set softtabstop=4 "option so make backspace delete entire tab"
set tabstop=4 "setting auto indent to 4 spaces"
set shiftwidth=4 "when we hit tab it moves 4 spaces
set expandtab "this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up"
set cursorline "enable line under cursor"
set shortmess=a "shorten message lengths in cmd bar
set incsearch "search as characters are entered"
set hlsearch "highlight matches"
set ignorecase "ignore cases when searching
set smartcase "However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
set backspace=indent,eol,start " this makes backspace work as normal
set scrolloff=5 "Set the cursor 5 lines down instead of at the top
set undofile "Keeps undo history even after we close a file
set encoding=UTF-8 "REQUIRED BY DEV ICONS PLUGIN
set showmatch "match opening and closing braces
set noshowmode "turns of the INSERT.. etc mode text at very bottom
set shortmess+=F  " to get rid of the file name displayed in the command line bar
set history=200 "keep 200 hungy commands in the stash
set lazyredraw "hopefully this speeds up vim!
set autoread "loads file as soon as there are changes on disk
set wildmenu "enhanced tab completion for vim command bar
set wildmode=list,full "Displays a handy list of commands we can tab thru"
set updatetime=50 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience. - some dude on the internet (not my idea)

"Wrapping theme in try catch block to help with fresh installs. Helpful errors
"on first boot
try
"THEME CONFIG
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="soft" " lightens up gruvbox, too dark otherwise
set termguicolors "enabling terminal color support
set t_Co=256 "enabling 256 color support
colorscheme gruvbox
"lua require("colorbuddy").colorscheme("gruvbox")

catch
    :PlugInstall
    echo 'Gruvbox not installed.'
endtry

" Backup Directories
if !isdirectory($HOME . "/.config/nvim/.backup")
    call mkdir($HOME . "/.config/nvim/.backup", "p", 0700)
endif
if !isdirectory($HOME . "/.config/nvim/.undo")
    call mkdir($HOME . "/.config/nvim/.undo", "p", 0700)
endif
if !isdirectory($HOME . "/.config/nvim/.swap")
    call mkdir($HOME . "/.config/nvim/.swap", "p", 0700)
endif
if !isdirectory($HOME . "/.config/nvim/.session")
    call mkdir($HOME . "/.config/nvim/.session", "p", 0700)
endif
set backupdir=~/.config/nvim/.backup//
set directory=~/.config/nvim/.swap//
if exists('&undodir')
  set undodir=~/.config/nvim/.undo//
endif



"============================START LUA TEST===============================
"lua require'init'

"============================END LUA TEST===============================
"

"============================END MY CONFIGS===============================



"============================START MY CONFIGS===============================


"=======================START CONFIGS UNDER TESTING=============================


"Enable use to write to ----READONLY---- files using --> w!! (i.e. Add an extra !)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


""""""""""""TREE-SITTER BASED SYNTAX HIGHLIGHTING --> CONFIGURATION""""""""""
"Enable treesitter syntax highlight
try
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

"Disable bracket, delimiter highlighting with treesitter --> so regex based luochen1990/rainbow
"can provide us rainbow brackets instead. great for c based langs
lua <<EOF
require "nvim-treesitter.highlight"
    local hlmap = vim.treesitter.highlighter.hl_map

    --Misc
    hlmap.error = nil
    hlmap["punctuation.delimiter"] = "Delimiter"
    hlmap["punctuation.bracket"] = nil
EOF
catch
    echo 'Treesitter not installed. It should work after running :PlugInstall or updating to the latest neovim 0.5 nightly with treesitter support'
endtry
""""""""""""""""""""""""""""END TREESITTER SCRIPTS"""""""""""""""""""""""""""""""""""""



"DITCH THOSE ARROW KEYS --> MOVE UP AND DOWN IN INSERT MODE WITH HJKL BY SIMPLY HOLDING CONTROL
inoremap <c-j> <esc>ji
inoremap <c-k> <esc>ki
inoremap <c-h> <esc>i
inoremap <c-l> <esc>la




"Stolen from sensible vim
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif



"This is Neovim only. inccommand shows you in realtime what changes your ex command should make. Right now it only supports s,but even that is incredibly useful. If you type :s/regex, it will highlight what matches regex. If you then add /change, it will show all matches replaced with change. This works with all of the regex properties, include backreferences and groups.
set inccommand=nosplit



"TURN OFF RELATIVE LINE NUMBERING WHEN WE ENTER INSERT MODE AND ENABLE OTHERWISE
 augroup every
  autocmd!
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
augroup END



"set autochdir "sets the cwd to whatever file is in view. This allows better ommicompletion
"This kind of makes workflows annoying where it screws up fzf if i enter a
"file within a tree, I cant get back to files at the root
"Seems like our completion is g anyways -- review later



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



"------AUTO RESIZING WINDOWS----------
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
""""""""""""""END AUTO RESIZING WINDOW CONFIG"""""""""""""""


"AUTO RELOAD VIM WHEN UPDATING INIT.VIM/CONFIG FILE
"We can set $MYVIMRC later on in our path but this serves just fine for now
autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim



"Auto make our C files on save
"autocmd BufWrite *.c make


"############COLOUR BRACES############
"SORT OF LIKE A PRETTIFIER FOR OUR BRACES AND STUFF TO GIVE THEM DIFFERENT
"COLOURS --> 4/12/20 DEPRECATED BUT KEEPING FOR REFERENCE FOR NOW
"autocmd! FileType .c,.cpp,.java,.php call CSyntaxAfter()
"if exists("*CSyntaxAfter")
        "call CSyntaxAfter()
     "endif



"LEAN GIT BLAME OUTPUT IN COMMAND BAR --> Run :GitBlame to see who wrote the commit
command! -range GitBlame echo join(systemlist("git -C " . shellescape(expand('%:p:h')) . " blame -L <line1>,<line2> " . expand('%:t')), "\n")


"##########SOMETIMES WE GET SPECS IN PDF FORM FOR CLASS############
"##### I LIKE TO KEEP THE SPECS FILE WITH MY CODE#################
"######WE HAVE AN AUTOFUNC HERE SO THAT WE CAN QUICKLY OPEN######
"######PDF's ETC IN DEFAULT APPLICATION INSTEAD OF OPENING ########
"########## THE FILE IN VIM AND GIVING A GARBLED OUTPUT############
augroup nonvim
   au!
   au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc*,*.rtf sil exe "!open " . shellescape(expand("%:p")) | bd | let &ft=&ft
augroup end



"INDENTATION TESTING
"Ref here: https://www.reddit.com/r/vim/wiki/vimrctips#wiki_do_not_use_smartindent
"Decided to turn of 'smartindent' which I had set up for ages
"As it seems might not be a good default nowadays
set autoindent "enable auto-indentation"
"set smartindent  " smart  autoindent (e.g. add indent after '{')





"AUTOMATICALLY CREATE NEW PARENT FOLDER ON SAVE IF NOT ALREADY CREATED
"SAVES A LOT OF MKDIR COMMANDS :)
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END



"ESCAPE VIM TERMINAL MODE WITH ESC LIKE ALL OTHER MODES
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif



"=======================END CONFIGS UNDER TESTING=============================



"=============================START REMAPS========================================



"LEADER KEY IS THE SPACE BAR
let mapleader = "\<Space>"


"i've been using the shift key w my pinky so much lately its getting sore
"realised leader leader is free so its now an easy way to enter cmd mode
map <leader><leader> :


"Speeding up auto correction toggle for my uni lectures
"Note plgn is Vim-you-autocorrect
cnoreabbrev spellon EnableAutocorrect
cnoreabbrev spelloff  DisableAutocorrect


"Clear highlights quick!
noremap <silent><leader>/ :nohlsearch<cr>


"FORMATTERS
"Remove indents from code! (a simple code formatter)
nnoremap <silent><leader>i gg=G<c-o>
"Run Neoformat
nnoremap <silent><leader>F :Neoformat<CR>



"FIND AND REPLACE
"Replace/Delete words quick! ONE BY ONE.
"c. c, d. d,
"nnoremap ,x *``cgn
nnoremap <silent>c. /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <silent>c, ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap <silent>d. /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap <silent>d, ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN


"jj to escape quick yo
"turns out there arent many words with jj in them
"so its okay if we steal it
"if you really need to type a word with jj in it
"just type it slowly
"this also has a bonus side effect of keeping ur hands on hjkl
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



"FuzzyFinderMappings AKA ctrl+p search like say vscode
nnoremap <silent><Leader>s :Files<cr>
vnoremap <silent><Leader>s :Files<cr>
"SHIFT-P for file history
nnoremap <silent> <Leader>S :History<CR>
vnoremap <silent> <Leader>S :History<CR>
nnoremap <silent> <Leader>gf :GitFiles<CR>
vnoremap <silent> <Leader>gf :GitFiles<CR>



"Ripgrep Mappings / NOTE We also have Silver Searcher Optionally Available :Ag
"FIND WORDS RECURSIVELY AND FAST IN YOUR CWD
"leader-f for search-FILES
nnoremap <silent> <Leader>f :RG<CR>
vnoremap <silent> <Leader>f :RG<CR>


"leader-b for BUFFER LIST (show buffers)
"leader-w for SPLIT CYCLING (cycle current windows)
"leader-W takes us anticlockwise
nnoremap <silent> <Leader>b :FzfPreviewAllBuffers<CR>
vnoremap <silent> <Leader>b :FzfPreviewAllBuffers<CR>
nnoremap <silent> <leader>w <C-w>w
vnoremap <silent> <leader>w <C-w>w
nnoremap <silent> <leader>W <C-w>W
vnoremap <silent> <leader>W <C-w>W



"COMMANDS MENU/SEARCH Mappings
nnoremap <silent><Leader>c :Commands<CR>
vnoremap <silent><Leader>c :Commands<CR>

"Fuzzymenu Mappings (ctrl+p)
nmap <silent><leader>p <Plug>(Fzm)
vmap <silent> <leader>p <Plug>(FzmVisual)


"File Tree Mappings
nnoremap <silent><Leader>n :NERDTreeToggle<cr>
vnoremap <silent><Leader>n :NERDTreeToggle<cr>






"Resize our splits with <leader> +/- easily
nnoremap <silent> <Leader>' :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>; :exe "resize " . (winheight(0) * 3/4)<CR>
"NOTE: DUE TO LIMITATION IN VIM, its going to go left when you think it will
"go right due to it simply being +/- pixels and not dependenent on direction
nnoremap <silent> <leader>, :vertical resize -10<CR>
nnoremap <silent> <leader>. :vertical resize +10<CR>

"CHANGE A SPLIT ORENTATION FROM HORIZONTAL TO VERTICAL AND VICE VERSA
"<leader>H K
nnoremap <silent><leader>[ <c-w>H
nnoremap <silent><leader>] <c-w>K


"SHOW GIT COMMIT / GIT BLAME POPUP
"Show git commit that introduced line after cursor, bit like GIT BLAME, BUT
"NOW WE CAN INCLUDE OUR VIM ;) Note leader-gm is mapped automatically too
nnoremap <silent><leader>gb :GitMessenger<CR>



"QUICK COMMENTING
"NOTE: Mapped iTERM2 CMD+/ to "++" so we can overload the vim + function
"already there
"Comment line of code in Nmode, even sections in Vmode too with just cmd-/ !!
nnoremap <silent> ++ <plug>NERDCommenterToggle
vnoremap <silent> ++ <plug>NERDCommenterToggle




"=============================END REMAPS========================================





"==========================START MAPPINGS UNDER TESING=============================





"==========================END MAPPINGS UNDER TESING=============================







"============================BEGIN FUNCTIONS CONFIG=======================




"ENABLE SYNTAX ONLY ONCE, TO PREVENT OVERWRITING
if !exists("g:syntax_on")
        syntax enable
endif



"self descriptive -- highlights yanked text for a little extra visual feedback
"so we don't need to rely on visual mode as much, try yip or y4y
"NOTE REQUIRES NVIM V5
augroup highlight_yank
    if has("nvim-0.5")
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    endif
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



"MOVE BETWEEN SPLITS DIRECTIONALLY SUPER QUICK
"OPEN NEW SPLIT IF NO SPLITS EXIST IN THAT POSITION,
"SORTA LIKE WE HAVE OVERLOADED IT :P
"Just space-hjkl
nnoremap <silent><leader>h :call WinMove('h')<CR>
nnoremap <silent><leader>j :call WinMove('j')<CR>
nnoremap <silent><leader>k :call WinMove('k')<CR>
nnoremap <silent><leader>l :call WinMove('l')<CR>







"============================END FUNCTIONS CONFIG=======================




"=======================START EXTENSION CONFIGS=============================




"Enhanced Sessions --> COMPANION CONFIG TO vim-session
try
"keep all sessions in one location
let g:session_directory='~/.config/nvim/.session'
"remove .vim from end of files so it looks nicer in startify
let g:session_extension=''
"Remove pop-up each time we close to ask to save session
let g:session_autosave = 'no'
"If I want to load a session I will specify it. We also have a start page
"which displays recent sessions too so not need to auto load them
let g:session_autoload = 'no'
cnoreabbrev mks SaveSession
cnoreabbrev mksession SaveSession
catch
    :PlugInstall
    echo 'Vim-Session not installed.'
endtry


"CURSOR FLASH --> COMPANION CONFIG TO Ydanilamihailov/beacon.nvim plugin

try
let g:beacon_size = 90
let g:beacon_minimal_jump = 25
let g:beacon_shrink = 0
catch
    :PlugInstall
    echo 'Beacon not installed.'
endtry

"GIT LENS --> COMPANION CONFIG TO APZelos/blamer.nvim
try
let g:blamer_enabled = 1
catch
    :PlugInstall
    echo 'Blamer not installed.'
endtry



"INDENT GUIDES --> COMPANION CONFIG TO Yggdroot/indentLine plugin
try
    let g:indentLine_char = '│'
catch
    :PlugInstall
    echo 'Indentline not installed.'
endtry

"RAINBOW BRACES --> COMPANION CONFIG TO luochen1990/rainbow
try
let g:rainbow_active = 1 "set to 0 if you want to enable rainbow later via :RainbowToggle
catch
    :PlugInstall
    echo 'Rainbow not installed.'
endtry


"ALE CONFIG --> LANGUAGE ERROR DETECTION AND LINTING SERVICE
" Shorten error/warning flags
try
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" I have some custom icons for errors and warnings but feel free to change them.
"let g:ale_sign_error = '✘'
"let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 1 "Don't lint on enter hope this speeds things up/prevents lag


catch
    :PlugInstall
    echo 'Ale not installed.'
endtry


"FUZZYMENU POPUP WINDOW CONFIG
try
let g:fuzzymenu_position =  'window'
let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}
catch
    :PlugInstall
    echo 'Fuzzymenu not installed.'
endtry


""""""""""""""FLOATING TERMINAL CONFIG --> voldikss/vim-floaterm
try
let g:floaterm_keymap_toggle = '<Leader>t'
let g:floaterm_width = 0.7
"let g:floaterm_winblend = 5 "Transparency
"let g:floaterm_wintype = 'floating' "neovim must have floating windows
catch
    :PlugInstall
    echo 'Floaterm not installed.'
endtry





"VIM QUICKSCOPE --> COMPANION CONFIG TO unblevable/quick-scope
try
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:qs_buftype_blacklist = ['terminal', 'nofile']
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_lazy_highlight = 1
catch
    :PlugInstall
    echo 'Quickscope not installed.'
endtry



"=======================END EXTENSION CONFIGS=============================




"============================BEGIN STATUSLINE CONFIG=======================



"I wrap these configs in try/catch to avoid errors on initial install before plugin is available
"Mostly for anyone who uses my dockerfile thats sets up a working nvim env
try
let g:airline_theme='gruvbox' "SET GRUVBOX AS STATUS BAR THEME

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
" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


catch
    :PlugInstall
  echo 'Airline not installed.'
endtry




"=============================END STATUSLINE CONFIG=================================







"================================BEGIN COC CONFIG=========================



try
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-java',
            \ 'coc-java-debug',
            \ 'coc-python',
            \ 'coc-dictionary',
            \ 'coc-pairs',
            \ 'coc-highlight',
            \ 'coc-rust-analyzer',
            \ 'coc-snippets',
            \ 'coc-prettier',
            \ 'coc-xml',
            \ ]

"PRETTIER FORMATTER --> COMPANION CONFIG TO neoclide/coc.nvim
try
"Part of prettier recommended configs
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"NOTE -- SET Prettier languages with :CocConfig
"Prettier seems to format java okay which is neat :)
catch
    :PlugInstall
    echo 'Prettier not installed.'
endtry


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

if has_key(plugs, 'coc.nvim')
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" Symbol renaming - RENAME / REFACTOR FILES QUICK.
nmap <leader>rn <Plug>(coc-rename)

"Terminal Window Mappings --> 8/12/20 RETIRED FOR TERMINAL POPUPS
"nnoremap <silent><leader>t :CocCommand terminal.Toggle<CR>


catch
    :PlugInstall
    echo "COC Not installed."
endtry




"================================END COC CONFIG=========================







"==========================START FZF CONFIGS=============================



" Wrap in try/catch to avoid errors on initial install before plugin is available
try
"
"
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
"Note, can only figure out how to ignore folders for now. tried **.classes for
"java classes sended up blocking the classes folder itself.
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden --follow -g "!{.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes}/*"'

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


catch
    :PlugInstall
    echo 'FZF not installed.'
endtry




"==========================END FZF CONFIGS=============================




"==========================START RIPGREP CONFIGS=============================




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




"==========================START STARTIFY CONFIGS=============================





"let g:startify_custom_header = [
        "\ '   ███╗   ██╗███████╗ ██████╗     ██╗   ██╗██╗███╗   ███╗',
        "\ '   ████╗  ██║██╔════╝██╔═══██╗    ██║   ██║██║████╗ ████║',
        "\ '   ██╔██╗ ██║█████╗  ██║   ██║    ██║   ██║██║██╔████╔██║',
        "\ '   ██║╚██╗██║██╔══╝  ██║   ██║    ╚██╗ ██╔╝██║██║╚██╔╝██║',
        "\ '   ██║ ╚████║███████╗╚██████╔╝     ╚████╔╝ ██║██║ ╚═╝ ██║',
        "\ '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝       ╚═══╝  ╚═╝╚═╝     ╚═╝',
        "\]

"let g:startify_custom_header = [
"\ '    ███████╗██╗   ██╗██████╗     ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗ ',
"\ '    ██╔════╝██║   ██║██╔══██╗    ████╗ ████║██╔══██╗████╗  ██║██╔════╝ ',
"\ '    ███████╗██║   ██║██████╔╝    ██╔████╔██║███████║██╔██╗ ██║██║  ███╗',
"\ '    ╚════██║██║   ██║██╔═══╝     ██║╚██╔╝██║██╔══██║██║╚██╗██║██║   ██║',
"\ '    ███████║╚██████╔╝██║         ██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╔╝',
"\ '    ╚══════╝ ╚═════╝ ╚═╝         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ',
"\]
"

"let g:startify_custom_header = [
"\ '   ███╗   ███╗ █████╗  ██████╗███████╗██╗',
"\ '   ████╗ ████║██╔══██╗██╔════╝██╔════╝██║',
"\ '   ██╔████╔██║███████║██║     ███████╗██║',
"\ '   ██║╚██╔╝██║██╔══██║██║     ╚════██║╚═╝',
"\ '   ██║ ╚═╝ ██║██║  ██║╚██████╗███████║██╗',
"\ '   ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝',
"\]

try
let g:startify_custom_header = [
\ '   ██╗     ███████╗████████╗███████╗     ██████╗ ███████╗████████╗    ██╗████████╗██╗',
\ '   ██║     ██╔════╝╚══██╔══╝██╔════╝    ██╔════╝ ██╔════╝╚══██╔══╝    ██║╚══██╔══╝██║',
\ '   ██║     █████╗     ██║   ███████╗    ██║  ███╗█████╗     ██║       ██║   ██║   ██║',
\ '   ██║     ██╔══╝     ██║   ╚════██║    ██║   ██║██╔══╝     ██║       ██║   ██║   ╚═╝',
\ '   ███████╗███████╗   ██║   ███████║    ╚██████╔╝███████╗   ██║       ██║   ██║   ██╗',
\ '   ╚══════╝╚══════╝   ╚═╝   ╚══════╝     ╚═════╝ ╚══════╝   ╚═╝       ╚═╝   ╚═╝   ╚═╝',
\]



let g:startify_session_dir = '~/.config/nvim/.session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent Files']                 },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]

let g:startify_bookmarks = [
            \ { 'v': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ { 's': '~/.ssh/config' }
            \ ]

"let g:startify_session_autoload = 1
"let g:startify_session_delete_buffers = 1
"let g:startify_change_to_vcs_root = 1
"let g:startify_fortune_use_unicode = 1
"let g:startify_session_persistence = 1
"let g:startify_enable_special = 1

"let g:webdevicons_enable_startify = 1

"function! StartifyEntryFormat()
        "return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    "endfunction

catch
    :PlugInstall
    echo 'Startify not installed.'
endtry


"===============================END STARIFY CONFIG=================================




"===============================END VIM CONFIG=================================






"===============================DEPRECATED CODE==================================




"Removed because I ended up just configuring fzf myself before I even got into
"using this plugin
"=========
""UNDER TESTING -- FZF PREVIEW VIM AS REPLACEMENT FOR FZF VIM, ITS S SUPER UP
"VERSION, BASICALLY A PREMADE CONFIG OF FZF WITH DEV ICONS ETC.
"let g:fzf_preview_use_dev_icons = 1
"let g:fzf_preview_command = 'bat --color=always --plain {-1}'
" https://github.com/yuki-ycino/fzf-preview.vim/blob/master/README.md
"========



"""""""""""""""""""""""""""""""""""""""""""""
"ANOTHER SPLIT MOVEMENT METHOD, USING ALT, NOT SURE WHICH I LIKE MORE
"This one won't create splits for us though
"if has('nvim')
  " Terminal mode:
  "tnoremap <Leader>h <c-\><c-n><c-w>h
  "tnoremap <Leader>j <c-\><c-n><c-w>j
  "tnoremap <Leader>k <c-\><c-n><c-w>k
  "tnoremap <Leader>l <c-\><c-n><c-w>l
  "" Insert mode:
  "inoremap <leader>h <Esc><c-w>h
  "inoremap <leader>j <Esc><c-w>j
  "inoremap <leader>k <Esc><c-w>k
  "inoremap <leader>l <Esc><c-w>l
  "" Visual mode:
  "vnoremap <leader>h <Esc><c-w>h
  "vnoremap <leader>j <Esc><c-w>j
  "vnoremap <leader>k <Esc><c-w>k
  "vnoremap <leader>l <Esc><c-w>l
  "" Normal mode:
  "nnoremap <leader>h <c-w>h
  "nnoremap <leader>j <c-w>j
  "nnoremap <leader>k <c-w>k
  "nnoremap <leader>l <c-w>l
"endif
"""""""""""""""""""""""""""""""""""""""""""""""""




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




"=========================END OF FILE=================================

