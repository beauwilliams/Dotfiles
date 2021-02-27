" TODO
" Set Up LSP Status progress in statusline using lsp status as inspo
" inspo -> https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/plugin/statusline.vim & https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/plugin/statusline.vim



"DEBUG
function! Test()
    echo "test"
    return "test"
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
endif
  return ''
endfunction

" set statusline+=%{LspStatus()} --> Works
"





"===========================KEY MAPPINGS===============================
   "____    __  __    ____   ______    __ __          ______   __  __    ____    ____     ______
  "/ __ \  / / / /   /  _/  / ____/   / //_/         / ____/  / / / /   /  _/   / __ \   / ____/
 "/ / / / / / / /    / /   / /       / ,<           / / __   / / / /    / /    / / / /  / __/
"/ /_/ / / /_/ /   _/ /   / /___    / /| |         / /_/ /  / /_/ /   _/ /    / /_/ /  / /___
"\___\_\ \____/   /___/   \____/   /_/ |_|         \____/   \____/   /___/   /_____/  /_____/


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
"REPLACE ALL WORDS QUICKLY WITH SHIFT+R
"OR........
"Replace/Delete words quick! ONE BY ONE.
"*NOTE* You must first search for a string and have it highlighted first [can use SHIFT+R as above] before we can change and delete based on that pattern
"after searching for a word, use c for CHANGE & d for DELETE. We use , . to move back and forth between matches respectively
"Mapping -> c.
"Mapping -> c,
"Mapping -> d.
"Mapping -> d,
"NOTE: CLEAR HIGHLIGHTS WITH <leader>/
"
"QUICK COMMENTING
"NOTE: It is actually ++ but I used a trick for my mac to map that key to ++ in iterm
"Mapping -> cmd+/




"++++++++CODE FORMATTING AND RELATED TOOLS++++++++
"
"Remove indents from code! (a simple code formatter)
"Mapping -> <leader>i
"
"[F]ormat code
"Mapping -> <leader>F
"
"Remove superfluous [w]hitespaces at the end of lines
"Mapping -> <leader>W




"++++++++HANDY COMMANDS++++++++
"
"Speeding up auto correction toggle for my uni lectures
"Also spellchecking using native neovim
"Note plgn is Vim-you-autocorrect
"Command -> spellon
"Command -> spelloff
"Command -> spellcheck
"[s  -> go to previous spell error
"]s  -> go to next spell error
"zg  -> add word to dictionary
"z=  -> pop up list of word corrections/suggestions
"1z= -> correct spelling using first given suggestion




" ===========================END MAPPINGS===============================





" ===========================START MY PLUGINS===============================

    "____    _   __    ____  ______   _____
   "/  _/   / | / /   /  _/ /_  __/  / ___/
   "/ /    /  |/ /    / /    / /     \__ \
 "_/ /    / /|  /   _/ /    / /     ___/ /
"/___/   /_/ |_/   /___/   /_/     /____/

"have tested that I get better performance over sshfs with this on
"We need to set ale off it before we load our plugins

"NOTE: DEC 2020 --> Moved to packer, moving to lua gradually.
"TODO: ENSURE COMPATIBILITY WITH VSC && NVIM < 0.5


" Determine whether or not we're inside vscode
let g:using_vscode = exists('g:vscode')

 "Determine whether or not to use the built-in LSP.
if !exists('g:using_nvim_lsp')
    let g:using_nvim_lsp = has('nvim-0.5') && !g:using_vscode
endif

if has('nvim-0.5')
    lua require("init")
else
    runtime init_pre_0.5.vim " Source Vim-Plug configuration
endif



"===========================END MY PLUGINS===============================

    "__  _____  __          ______   ____     _   __    ______    ____   ______   _____
   "/  |/  /\ \/ /         / ____/  / __ \   / | / /   / ____/   /  _/  / ____/  / ___/
  "/ /|_/ /  \  /         / /      / / / /  /  |/ /   / /_       / /   / / __    \__ \
 "/ /  / /   / /         / /___   / /_/ /  / /|  /   / __/     _/ /   / /_/ /   ___/ /
"/_/  /_/   /_/          \____/   \____/  /_/ |_/   /_/       /___/   \____/   /____/


"BEAU CONFIGS
filetype plugin indent on "Indent and stuff based on ft NOTE: have polyglot installed providing ftplugins
" set cursorline "enable cursorline
set number "enable line numbers"
set softtabstop=4 "option so make backspace delete entire tab"
set tabstop=4 "setting auto indent to 4 spaces"
set shiftwidth=4 "when we hit tab it moves 4 spaces
set expandtab "this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up"
" set cursorline "enable line under cursor"
set shortmess=a "shorten message lengths in cmd bar
set incsearch "search as characters are entered"
" set hlsearch "highlight matches"
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
set updatetime=20 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable " delays and poor user experience. FOR ASYNC STUFF ONLY
set hidden "ENABLE BUFFERS TO HIDE - PREVENTS ERROR: "E37: No write since last change (add ! to override) When opening a new buffer before saving current one
set relativenumber "SET RELATIVE LINE NUMBERS IN RULER
set shiftround "Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up
if has('nvim')
set spelllang=en "Set NEOVIMS NATIVE spell lang for spellchecker
set inccommand=nosplit "This is Neovim only. inccommand shows you in realtime what changes your ex command should make. Right now it only supports s,but even that is incredibly useful. If you type :s/regex, it will highlight what matches regex. If you then add /change, it will show all matches replaced with change. This works with all of the regex properties, include backreferences and groups.
set clipboard+=unnamed " share system clipboard but also retain nvim clipboard (see += compared
"to just =) essentially instead of overwriting we are appending to a list of copied things to the clipboard
endif



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
set swapfile

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

"TURN OFF RELATIVE LINE NUMBERING WHEN WE ENTER INSERT MODE AND ENABLE OTHERWISE
augroup AutoRelativeLineNums
  autocmd!
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
augroup END



"============================END MY CONFIGS===============================



"============================START MY CONFIGS===============================


"=======================START CONFIGS UNDER TESTING=============================

  "______    ______   _____  ______          ______   ____     _   __    ______    ____   ______   _____
 "/_  __/   / ____/  / ___/ /_  __/         / ____/  / __ \   / | / /   / ____/   /  _/  / ____/  / ___/
  "/ /     / __/     \__ \   / /           / /      / / / /  /  |/ /   / /_       / /   / / __    \__ \
 "/ /     / /___    ___/ /  / /           / /___   / /_/ /  / /|  /   / __/     _/ /   / /_/ /   ___/ /
"/_/     /_____/   /____/  /_/            \____/   \____/  /_/ |_/   /_/       /___/   \____/   /____/




"augroup illuminate_augroup
    "autocmd!
    "autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
"augroup END
augroup illuminate_augroup "NOTE: WE MUST SET UNDER CURSOR SETTING SEPERATELY I DISABLED HL FOR UNDER CURSOR
    autocmd!
    autocmd VimEnter * hi illuminatedWord guibg=#504648 guifg=none "cterm=grey gui=grey
    autocmd VimEnter * hi illuminatedCurWord cterm=none gui=none
augroup END


"Setting curstom cursorline colour for the vim-illuminate plugin
"STOLEN FROM --> https://github.com/haorenW1025/dotfiles/blob/master/nvim/plugin/plugin-setting.vim
"function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction

"inoremap <silent><expr> <TAB>
  "\ pumvisible() ? "\<C-n>" :
  "\ <SID>check_back_space() ? "\<TAB>" :
  "\ completion#trigger_completion()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"Enable use to write to ----READONLY---- files using --> w!! (i.e. Add an extra !)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


"DITCH THOSE ARROW KEYS --> MOVE UP AND DOWN IN INSERT MODE WITH HJKL BY SIMPLY HOLDING CONTROL
inoremap <c-j> <esc>ji
inoremap <c-k> <esc>ki
inoremap <c-h> <esc>i
inoremap <c-l> <esc>la



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




"------AUTO RESIZING WINDOWS----------
"UNDER TESTING LETS SEE IF WE LIKE THIS WORKFLOW
" From https://github.com/knubie/dotfiles/blob/fe7967f875945e54d49fc672f575c47691a1e4cc/.vimrc#L136
" augroup ReduceNoise
        " autocmd!
        " Automatically resize active split to 85 width
        " autocmd WinEnter * :call ResizeSplits()

        " autocmd WinEnter * setlocal cursorline
        " autocmd WinEnter * setlocal signcolumn=auto

        " autocmd WinLeave * setlocal nocursorline
        " autocmd WinLeave * setlocal signcolumn=no
" augroup END

function! ResizeSplits()
        if &ft == 'NvimTree'
                return
        elseif &ft == 'qf'
                " Always set quickfix list to a height of 10
                resize 10
                return
        else
                set winwidth=120
                " wincmd =
        endif
endfunction
""""""""""""""END AUTO RESIZING WINDOW CONFIG"""""""""""""""


"AUTO RELOAD VIM WHEN UPDATING INIT.VIM/CONFIG FILE
"We can set $MYVIMRC later on in our path but this serves just fine for now
"autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
au BufWritePost ~/.config/nvim/** so $MYVIMRC "This version is better, works for all config files
" au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC "This version is better, works for all config files


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
" set autoindent enable auto-indentation"
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
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

"NOTE: DEPRECTATED THIS HAS A BUG THAT STOPS FZF CLOSING WHEN ESC PRESSED
"if has('nvim')
  "tnoremap <Esc> <C-\><C-n>
  "tnoremap <M-[> <Esc>
  "tnoremap <C-v><Esc> <Esc>
"endif

"=======================END CONFIGS UNDER TESTING=============================



"=============================START REMAPS========================================

    "____     ______    __  ___    ___     ____    _____
   "/ __ \   / ____/   /  |/  /   /   |   / __ \  / ___/
  "/ /_/ /  / __/     / /|_/ /   / /| |  / /_/ /  \__ \
 "/ _, _/  / /___    / /  / /   / ___ | / ____/  ___/ /
"/_/ |_|  /_____/   /_/  /_/   /_/  |_|/_/      /____/


"LEADER KEY IS THE SPACE BAR
let mapleader = "\<Space>"


"i've been using the shift key w my pinky so much lately its getting sore
"realised leader leader is free so its now an easy way to enter cmd mode
map <leader><leader> :

"Explanation: The 0 (Zero) register is special because it only stores the last item you yank
"and only if you yank it, not if you delete it with any of d,x,c,s.
"We use this because we have the vim register synced with the system
"clipboard. Meaning we can't do simple text replacement easily as deleting
"text will overwrite yanked text in the register.
nnoremap yp "0p
nnoremap yP "0P


"Speeding up auto correction toggle for my uni lectures
"NOTE: plgn is vim-you/autocorrect
"Note we are using neovims built in spellcheck and dictionary
cnoreabbrev <silent>spellcheck :set spell!<cr>
cnoreabbrev spellon :EnableAutocorrect
cnoreabbrev spelloff  DisableAutocorrect



"Clear highlights quick!
noremap <silent><leader>/ :nohlsearch<cr>


"FORMATTERS
"Remove indents from code! (a simple code formatter)
nnoremap <silent><leader>i gg=G<c-o>
"Run Neoformat
nnoremap <silent><leader>F :Neoformat<CR>
"AUGROUPS FOR FORMATTERS --> Wait until neovim implements augroup API
augroup formatpython
  autocmd!
  autocmd BufWritePre *.py undojoin | Neoformat
augroup END



"FIND AND REPLACE
nnoremap R :%s/\<<C-r><C-w>\>//g<Left><Left><C-r><C-w>
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



"CLOSE FLOATING TERMINAL ON ESCAPE
"autocmd FileType floaterm tnoremap <buffer> <Esc> <plug>floaterm#toggle





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
" nnoremap <silent><Leader>q :Telescope find_files<cr>
" vnoremap <silent><Leader>q :Telescope find_files<cr>

"SHIFT-P for file history
" nnoremap <silent> <Leader>S :History<CR>
" vnoremap <silent> <Leader>S :History<CR>
" nnoremap <silent> <Leader>gf :GitFiles<CR>
" vnoremap <silent> <Leader>gf :GitFiles<CR>



"Ripgrep Mappings / NOTE We also have Silver Searcher Optionally Available :Ag
"FIND WORDS RECURSIVELY AND FAST IN YOUR CWD
"leader-f for search-FILES
" nnoremap <silent> <Leader>f :RG<CR>
" vnoremap <silent> <Leader>f :RG<CR>


"leader-b for BUFFER LIST (show buffers)
"leader-w for SPLIT CYCLING (cycle current windows)
"leader-W takes us anticlockwise
"WAS BEFORE UPGRADE TO packer :FzfPreviewAllBuffers<CR>
" nnoremap <silent> <Leader>b :Buffers<CR>
" vnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <leader>w <C-w>w
vnoremap <silent> <leader>w <C-w>w
nnoremap <silent> <leader>W <C-w>W
vnoremap <silent> <leader>W <C-w>W



"COMMANDS MENU/SEARCH Mappings
" nnoremap <silent><Leader>c :Commands<CR>
" vnoremap <silent><Leader>c :Commands<CR>

" Saves the shift key I force quit a lot!
cnoreabbrev qqq q!

"CODE ACTION (LSP) MENU/SEARCH Mappings
nnoremap <silent><Leader>ca :lua vim.lsp.buf.code_action()<CR>
vnoremap <silent><Leader>ca :lua vim.lsp.buf.code_action()<CR>

"Fuzzymenu Mappings (ctrl+p)
nmap <silent><leader>p <Plug>(Fzm)
vmap <silent> <leader>p <Plug>(FzmVisual)


"File Tree Mappings
nnoremap <silent><Leader>n :NvimTreeToggle<cr>
vnoremap <silent><Leader>n :NvimTreeToggle<cr>

"Documentation Generator Mappings
nnoremap <Leader>D :DogeGenerate
vnoremap <Leader>D :DogeGenerate
cnoreabbrev docgen DogeGenerate






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


"FUGITIVE/GIT
cnoreabbrev <silent>gp :G push

"SHOW GIT COMMIT / GIT BLAME POPUP
"Show git commit that introduced line after cursor, bit like GIT BLAME, BUT
"NOW WE CAN INCLUDE OUR VIM ;) Note leader-gm is mapped automatically too
nnoremap <silent><leader>6 :GitMessenger<CR>



"QUICK COMMENTING
"NOTE: Mapped iTERM2 CMD+/ to "++" so we can overload the vim + function
"already there
"Comment line of code in Nmode, even sections in Vmode too with just cmd-/ !!
"NOTE: Replacing NERDComment with my own script, togglecomment.vim
"nnoremap <silent>++ :call NERDComment('n', "Invert")<CR>
"vnoremap <silent>++ :call NERDComment('n', "Invert")<CR>
" nnoremap <silent>++ :call ToggleComment()<CR>
" vnoremap <silent>++ :call ToggleComment()<CR>
" nnoremap <silent>++ :TComment<CR>
" vnoremap <silent>++ :TComment<CR>

"=============================END REMAPS========================================





"==========================START REMAPS UNDER TESING=============================





"==========================END MAPPINGS UNDER TESING=============================







"============================BEGIN FUNCTIONS CONFIG=======================

    "________  ___   ______________________  _   _______
   "/ ____/ / / / | / / ____/_  __/  _/ __ \/ | / / ___/
  "/ /_  / / / /  |/ / /     / /  / // / / /  |/ /\__ \
 "/ __/ / /_/ / /|  / /___  / / _/ // /_/ / /|  /___/ /
"/_/    \____/_/ |_/\____/ /_/ /___/\____/_/ |_//____/


"autocmd InsertLeave,WinEnter * set cursorline
"autocmd InsertEnter,WinLeave * set nocursorline


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


" jump to the last non-whitespace char on line, or eol if already there
"map <End> :call LineEnd()<CR>:echo<CR>
"imap <End> <C-R>=LineEnd()<CR>
"function! LineEnd()
  "let x = col('.')
    "execute "normal g_"
  "if x == col('.')
    "execute "normal $"
  "endif
 "return ""
"endfunction
"jump to first non-whitespace on line, jump to begining of line if already at first non-whitespace
"map <Home> :call LineHome()<CR>:echo<CR>
"imap <Home> <C-R>=LineHome()<CR>
"map ^[[1~ :call LineHome()<CR>:echo<CR>
"imap ^[[1~ <C-R>=LineHome()<CR>
"function! LineHome()
  "let x = col('.')
  "execute "normal ^"
  "if x == col('.')
    "execute "normal 0"
  "endif
  "return ""
"endfunction



"============================END FUNCTIONS CONFIG=======================




"===============================END NEOVIM CONFIG=================================
    "______    _   __    ____           ______   ____     _   __    ______    ____   ______   _____
   "/ ____/   / | / /   / __ \         / ____/  / __ \   / | / /   / ____/   /  _/  / ____/  / ___/
  "/ __/     /  |/ /   / / / /        / /      / / / /  /  |/ /   / /_       / /   / / __    \__ \
 "/ /___    / /|  /   / /_/ /        / /___   / /_/ /  / /|  /   / __/     _/ /   / /_/ /   ___/ /
"/_____/   /_/ |_/   /_____/         \____/   \____/  /_/ |_/   /_/       /___/   \____/   /____/





"===============================DEPRECATED CODE==================================

    "____     ______    ____     ____     ______   ______    ___   ______    ______    ____
   "/ __ \   / ____/   / __ \   / __ \   / ____/  / ____/   /   | /_  __/   / ____/   / __ \
  "/ / / /  / __/     / /_/ /  / /_/ /  / __/    / /       / /| |  / /     / __/     / / / /
 "/ /_/ /  / /___    / ____/  / _, _/  / /___   / /___    / ___ | / /     / /___    / /_/ /
"/_____/  /_____/   /_/      /_/ |_|  /_____/   \____/   /_/  |_|/_/     /_____/   /_____/


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
"                return match(system('pmset -g batt'), \"Now drawing from 'Battery Power'\") != -1
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
