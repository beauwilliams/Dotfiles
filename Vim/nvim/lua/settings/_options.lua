local o = vim.opt

local options = safe_require('libraries._set_options')
local utils = safe_require('libraries._utils')

if not options or not utils then
    return
end


options.set_options(
    "g",
    {
        mapleader = " "
    }
)

-- colorcolumn = '80' --80 column width marker for when we need it
o.termguicolors = true --uses your colorscheme and init. vim's gui values. CUSTOM COLORSCHEME NOT WORK RIGHT WITHOUT ME....
o.confirm = true -- When 'confirm' is on, certain operations that would normally fail because of unsaved changes to a buffer, e.g. ":q" and ":e", instead raise a dialog asking if you wish to save the current file(s).
o.hlsearch = true -- highlight matching search
o.wrapscan = true -- begin search from top of the file when nothng is found
o.cursorline = true -- enable cursorline
o.cursorlineopt = "screenline" -- cursorline look
o.number = true -- enable line numbers
o.signcolumn = "number" -- show errors in number column - or 'auto'
o.expandtab = true -- this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up
o.shiftwidth = 4 -- when we hit tab it moves 4 spaces
o.tabstop = 4 -- setting auto indent to 4 spaces
o.softtabstop = 4 --option so make backspace delete entire tab
o.ignorecase = true -- ignore cases when searching
o.smartcase = true -- However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
o.smartindent = true -- smarter indentation
o.smarttab = true -- make tab behaviour smarter
o.undofile = true -- Keeps undo history even after we close a file
o.showmatch = true -- match opening and closing braces
o.showmode = false -- turns off the --INSERT-- etc mode messages at very bottom
o.fileformats:append { "mac" } -- This gives the end-of-line (<EOL>) formats that will be tried when starting to edit a new buffer and when reading a file into an existing buffer
--SET IN AutoRead.vim -- o.autoread = true -- loads file as soon as there are changes on disk, not working when I do :Shell stylua .
o.hidden = true -- ENABLE BUFFERS TO HIDE - PREVENTS ERROR: E37: No write since last change (add ! to override) When opening a new buffer before saving current one
-- relativenumber = true -- Enable relative line numbers in ruler
o.shiftround = true -- Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up
o.shortmess = "aF" -- abreviates messages and prevents file name being echoed when opened
o.backspace = "indent,eol,start" -- this makes backspace work as normal
o.scrolloff = 5 -- Set the cursor 5 lines down instead of at the top
o.sidescrolloff = 5 -- Set the cursor 5 lines down instead of at the top
o.sidescroll = 2 -- make scrolling better, instead of wrap we sroll horizontally with the cursor
o.wrap = false -- dont wrap lines
o.encoding = "UTF-8" -- REQUIRED BY DEV ICONS PLUGIN
o.history = 200 -- keep 200 hungy commands in the stash
o.updatetime = 1000 -- If this many milliseconds nothing is typed the swap file will be written to disk (see |crash-recovery|).  Also used for the |CursorHold| autocommand event. Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable " delays and poor user experience. FOR ASYNC STUFF ONLY
o.timeoutlen = 400 -- faster timeout wait time
o.redrawtime = 10000 -- Time in milliseconds for redrawing the display.  Applies to 'hlsearch', 'inccommand', |:match| highlighting and syntax highlighting.
o.lazyredraw = false -- When this option is set, the screen will not be redrawn while executing macros, registers and other commands that have not been typed.  Also, updating the window title is postponed.  To force an
o.spelllang = "en" -- Set NEOVIMS NATIVE spell lang for spellchecker
o.clipboard = "unnamedplus" -- share system clipboard but also retain nvim clipboard (see += compared
o.mouse = "a" -- allows me to scroll with my touchpad in two different splits just by hoevering the mouse in the split I wish to scroll
-- cpoptions = vim.o.cpoptions .. 'x' -- stay at seach item when <esc> (ENTERS COMMAND WHEN HIT ESC from : MODE, DONT USE)

o.whichwrap:append "<>[]hl" -- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line

o.shortmess:append "sI"

o.pumheight = 15 -- limit lsp completion items length to 15 (note: you can still scroll to overloaded suggestions)
o.pumblend = 10 -- Enables pseudo-transparency for the popup-menu
-- o.pumwidth = 50 -- number  (default 15) global Minimum width for the popup menu (|ins-completion-menu|).  If the cursor column + 'pumwidth' exceeds screen width, the popup menu is nudged to fit on the screen.

o.menuitems = 20 --Maximum number of items to use in a menu.  Used for menus that are generated from a list of items, e.g., the Buffers menu

-- o.winblend = 10 -- (default 0) local to window Enables pseudo-transparency for a floating window. Valid values are in the range of 0 for fully opaque window (disabled) to 100 for fully transparent background. Values between 0-30 are typically most useful.


o.matchpairs:append { "<:>,「:」,『:』,【:】,“:”,‘:’,《:》" } -- Characters that form pairs. The % command jumps from one to the other

--[[ o.list = true -- List hidden chars mode: By default, show tabs as ">", trailing spaces as "-", and
o.listchars = {
    tab = '▷─',
    trail = '·',
    space = ' ',
    eol = '↲',
    nbsp = '⦸',
    extends = '',
    precedes = '',
    conceal = '┊'
} ]]

--NOTE: completion options not needed with cmp
-- o.completeopt = {"menu", "menuone", "noselect"} --show a menu for completions, even when only 1 item, don't autoselect completions
-- o.wildmenu = false -- enhanced tab completion for vim command bar
-- o.wildmode = "list,full" -- Displays a handy list of commands we can tab thru"
--NOTE: end completion options

o.shortmess:append("csa") -- This option helps to avoid all the |hit-enter| prompts caused by file messages


if utils.hasVersion("0.7") then
    o.laststatus = 3 --enable global statusline
end

--[[ vim.g.markdown_fenced_languages = {
  'vim',
  'lua',
  'cpp',
  'sql',
  'python',
  'bash=sh',
  'console=sh',
  'javascript',
  'typescript',
  'js=javascript',
  'ts=typescript',
  'yaml',
  'json',
} ]]

--[[ vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- ?? ]]

--[[ local options_buffer = {
} ]]

--[[ local options_window = {
} ]]

--set locally. no need to call elsewhere
-- set_options(bo,options_buffer)
-- set_options(wo,options_window)

--[[
  -- Boolean value
  autoindent = true, -- enable autoindent
  backup = false, -- disable backup
  cursorline = true, -- enable cursorline
  expandtab = true, -- use spaces instead of tabs
  hidden = true, -- keep hidden buffers
  hlsearch = false, -- don't highlight matching search
  ignorecase = true, -- case insensitive on search
  lazyredraw = true, -- lazyredraw to make macro faster
  list = true, -- display listchars
  number = true, -- enable number
  relativenumber = true, -- enable relativenumber
  showmode = false, -- don't show mode
  smartcase = true, -- improve searching using '/'
  smartindent = true, -- smarter indentation
  smarttab = true, -- make tab behaviour smarter
  splitbelow = true, -- split below instead of above
  splitright = true, -- split right instead of left
  startofline = false, -- don't go to the start of the line when moving to another file
  swapfile = false, -- disable swapfile
  termguicolors = true, -- truecolours for better experience
  wrap = false, -- dont wrap lines
  writebackup = false, -- disable backup

  -- String value
  backupcopy = "yes", -- fix weirdness for postcss
  completeopt = 'menu,menuone,noselect,noinsert', -- better completion
  encoding = "UTF-8", -- set encoding
  fillchars = "vert:│,eob:\\ ", -- make vertical split sign better
  foldmethod = "marker", -- foldmethod using marker
  inccommand = "split", -- incrementally show result of command
  listchars = "eol:↲,tab:»\\ ", -- set listchars
  mouse = "a", -- enable mouse support
  signcolumn = "yes", -- enable sign column all the time, 4 column

  -- Number value
  colorcolumn = 80, -- 80 chars color column
  laststatus = 2, -- always enable statusline
  pumheight = 10, -- limit completion items
  re = 0, -- set regexp engine to auto
  scrolloff = 2, -- make scrolling better
  shiftwidth = 2, -- set indentation width
  sidescroll = 2, -- make scrolling better
  sidescrolloff = 15, -- make scrolling better
  synmaxcol = 300, -- set limit for syntax highlighting in a single line
  tabstop = 2, -- tabsize
  timeoutlen = 400, -- faster timeout wait time
  updatetime = 100, -- set faster update time
]]
