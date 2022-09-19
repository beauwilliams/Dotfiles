local opt = vim.opt

local options = safe_require('libraries._set_options')
local utils = safe_require('libraries._utils')

if not options or not utils then
	return
end

options.set_scoped_options('g', {
	mapleader = ' ',
})

if vim.fn.isdirectory(os.getenv('HOME') .. '/.cache/nvim/.backup') == 0 then
	vim.fn.mkdir(os.getenv('HOME') .. '/.cache/nvim/.backup', 'p')
end
if vim.fn.isdirectory(os.getenv('HOME') .. '/.cache/nvim/.swap') == 0 then
	vim.fn.mkdir(os.getenv('HOME') .. '/.cache/nvim/.swap', 'p')
end
if vim.fn.isdirectory(os.getenv('HOME') .. '/.cache/nvim/.undo') == 0 then
	vim.fn.mkdir(os.getenv('HOME') .. '/.cache/nvim/.undo', 'p')
end
if vim.fn.isdirectory(os.getenv('HOME') .. '/.cache/nvim/.session') == 0 then
	vim.fn.mkdir(os.getenv('HOME') .. '/.cache/nvim/.session', 'p')
end
if vim.fn.isdirectory(vim.fn.stdpath('config') .. '/spell') == 0 then
	vim.fn.mkdir(vim.fn.stdpath('config') .. '/spell', 'p')
end

--NOTE: caches, history, etc
opt.backupdir = os.getenv('HOME') .. '/.cache/nvim/.backup'
opt.directory = os.getenv('HOME') .. '/.cache/nvim/.swap'
opt.undodir = os.getenv('HOME') .. '/.cache/nvim/.undo'
opt.spellfile = vim.fn.stdpath('config') .. '/spell/spellfile.utf-8.add'
opt.history = 1000 --> cmd history depth
opt.undolevels = 1000 --> how many undos
opt.undoreload = 10000 --> number of lines to save for undo
opt.tabpagemax = 50 --> max number of tabs
opt.writebackup = true -- enabled default
opt.backup = true -- overwrites previous backups instead of making new one


--NOTE: Theme/UI
  -- uses your colorscheme and init. vim's gui values. CUSTOM COLORSCHEME NOT WORK RIGHT WITHOUT ME....
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end



-- colorcolumn = '80' --80 column width marker for when we need it
opt.confirm = true -- When 'confirm' is on, certain operations that would normally fail because of unsaved changes to a buffer, e.g. ":q" and ":e", instead raise a dialog asking if you wish to save the current file(s).
opt.hlsearch = true -- highlight matching search
opt.wrapscan = true -- begin search from top of the file when nothng is found
opt.cursorline = true -- enable cursorline
opt.cursorlineopt = 'screenline' -- cursorline look
opt.number = true -- enable line numbers
opt.signcolumn = 'number' -- show errors in number column - or 'auto'
opt.expandtab = true -- this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up
opt.shiftwidth = 4 -- when we hit tab it moves 4 spaces
opt.tabstop = 4 -- setting auto indent to 4 spaces
opt.softtabstop = 4 --option so make backspace delete entire tab
opt.ignorecase = true -- ignore cases when searching
opt.smartcase = true -- However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
opt.smartindent = true -- smarter indentation
opt.smarttab = true -- make tab behaviour smarter
opt.undofile = true -- Keeps undo history even after we close a file
opt.showmatch = true -- match opening and closing braces
opt.showmode = false -- turns off the --INSERT-- etc mode messages at very bottom
opt.fileformats:append({ 'mac' }) -- This gives the end-of-line (<EOL>) formats that will be tried when starting to edit a new buffer and when reading a file into an existing buffer
--SET IN AutoRead.vim -- opt.autoread = true -- loads file as soon as there are changes on disk, not working when I do :Shell stylua .
opt.hidden = true -- ENABLE BUFFERS TO HIDE - PREVENTS ERROR: E37: No write since last change (add ! to override) When opening a new buffer before saving current one
-- relativenumber = true -- Enable relative line numbers in ruler
opt.shiftround = true -- Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up
opt.shortmess = 'aF' -- abbreviates messages and prevents file name being echoed when opened
opt.backspace = 'indent,eol,start' -- this makes backspace work as normal
opt.scrolloff = 5 -- Set the cursor 5 lines down instead of at the top
opt.sidescrolloff = 5 -- Set the cursor 5 lines down instead of at the top
opt.sidescroll = 2 -- make scrolling better, instead of wrap we sroll horizontally with the cursor
opt.wrap = false -- dont wrap lines
opt.encoding = 'UTF-8' -- REQUIRED BY DEV ICONS PLUGIN
opt.history = 200 -- keep 200 hungy commands in the stash
opt.updatetime = 1000 -- affects CursorHold speed and subsequently things like highlighting Code Actions
opt.timeoutlen = 400 -- faster timeout wait time
opt.redrawtime = 10000 -- Time in milliseconds for redrawing the display.  Applies to 'hlsearch', 'inccommand', |:match| highlighting and syntax highlighting.
opt.lazyredraw = false -- When this option is set, the screen will not be redrawn while executing macros, registers and other commands that have not been typed.  Also, updating the window title is postponed.  To force an
opt.spelllang = 'en' -- Set NEOVIMS NATIVE spell lang for spellchecker
opt.clipboard = 'unnamedplus' -- share system clipboard but also retain nvim clipboard (see += compared
opt.mouse = 'a' -- allows me to scroll with my touchpad in two different splits just by hoevering the mouse in the split I wish to scroll
-- opt.cpoptions = opt.cpoptions .. 'x' -- stay at search item when <esc> (ENTERS COMMAND WHEN HIT ESC from : MODE, DONT USE)
opt.whichwrap:append('<>[]hl') -- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
opt.shortmess:append('sI')
opt.pumheight = 15 -- limit lsp completion items length to 15 (note: you can still scroll to overloaded suggestions)
opt.pumblend = 10 -- Enables pseudo-transparency for the popup-menu
-- opt.pumwidth = 50 -- number  (default 15) global Minimum width for the popup menu (|ins-completion-menu|).  If the cursor column + 'pumwidth' exceeds screen width, the popup menu is nudged to fit on the screen.
opt.menuitems = 20 --Maximum number of items to use in a menu.  Used for menus that are generated from a list of items, e.g., the Buffers menu
-- opt.winblend = 10 -- (default 0) local to window Enables pseudo-transparency for a floating window. Valid values are in the range of 0 for fully opaque window (disabled) to 100 for fully transparent background. Values between 0-30 are typically most useful.
opt.shortmess:append('csa') -- This option helps to avoid all the |hit-enter| prompts caused by file messages
opt.matchpairs:append({ '<:>,「:」,『:』,【:】,“:”,‘:’,《:》' }) -- Characters that form pairs. The % command jumps from one to the other


--NOTE: ripgrep
opt.grepprg = "rg --vimgrep"


-- NOTE: enable global statusline
if utils.hasVersion('0.7') then
	opt.laststatus = 3
end

--[[ opt.list = true -- List hidden chars mode: By default, show tabs as ">", trailing spaces as "-", and
opt.listchars = {
    tab = '▷─',
    trail = '·',
    space = ' ',
    eol = '↲',
    nbsp = '⦸',
    extends = '',
    precedes = '',
    conceal = '┊'
} ]]

-- NOTE: completion options not needed with cmp
-- opt.completeopt = {"menu", "menuone", "noselect"} --show a menu for completions, even when only 1 item, don't autoselect completions
-- opt.wildmenu = false -- enhanced tab completion for vim command bar
-- opt.wildmode = "list,full" -- Displays a handy list of commands we can tab thru"

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

--[[
  vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- ??
  ]]
