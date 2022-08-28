local options = require('libraries._set_options')
local utils = require('libraries._utils')
local opt = vim.opt

options.set_options('g', {
	mapleader = ' ',
})

options.set_options( 'o', {
	-- colorcolumn = '80', --80 column width marker for when we need it
	termguicolors = true, --uses your colorscheme and init. vim's gui values. CUSTOM COLORSCHEME NOT WORK RIGHT WITHOUT ME....
	-- confirm = true, --
	hlsearch = true, -- highlight matching search
	wrapscan = true, -- begin search from top of the file when nothng is found
	cursorline = true, -- enable cursorline
	number = true, -- enable line numbers
	signcolumn = 'number', -- show errors in number column - or 'auto'
	expandtab = true, -- this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up
	shiftwidth = 4, -- when we hit tab it moves 4 spaces
	tabstop = 4, -- setting auto indent to 4 spaces
	softtabstop = 4, --option so make backspace delete entire tab
	ignorecase = true, -- ignore cases when searching
	smartcase = true, -- However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
	smartindent = true, -- smarter indentation
	smarttab = true, -- make tab behaviour smarter
	undofile = true, -- Keeps undo history even after we close a file
	showmatch = true, -- match opening and closing braces
	showmode = false, -- turns off the --INSERT-- etc mode messages at very bottom
	lazyredraw = true, -- hopefully this speeds up vim!
	--SET IN AutoRead.vim -- autoread = true, -- loads file as soon as there are changes on disk, not working when I do :Shell stylua .
	wildmenu = true, -- enhanced tab completion for vim command bar
	wildmode = 'list,full', -- Displays a handy list of commands we can tab thru"
	hidden = true, -- ENABLE BUFFERS TO HIDE - PREVENTS ERROR: E37: No write since last change (add ! to override) When opening a new buffer before saving current one
	-- relativenumber = true, -- Enable relative line numbers in ruler
	shiftround = true, -- Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up
	shortmess = 'aF', -- abreviates messages and prevents file name being echoed when opened
	backspace = 'indent,eol,start', -- this makes backspace work as normal
	scrolloff = 5, -- Set the cursor 5 lines down instead of at the top
	sidescrolloff = 5, -- Set the cursor 5 lines down instead of at the top
	sidescroll = 2, -- make scrolling better, instead of wrap we sroll horizontally with the cursor
	wrap = false, -- dont wrap lines
	encoding = 'UTF-8', -- REQUIRED BY DEV ICONS PLUGIN
	history = 200, -- keep 200 hungy commands in the stash
	updatetime = 100, -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable " delays and poor user experience. FOR ASYNC STUFF ONLY
	timeoutlen = 400, -- faster timeout wait time
	spelllang = 'en', -- Set NEOVIMS NATIVE spell lang for spellchecker
	-- inccommand = 'nosplit', -- Deault in 0.6. This is Neovim only. inccommand shows you in realtime what changes your ex command should make. Right now it only supports s,but even that is incredibly useful. If you type :s/regex, it will highlight what matches regex. If you then add /change, it will show all matches replaced with change. This works with all of the regex properties, include backreferences and groups.
	clipboard = 'unnamed', -- share system clipboard but also retain nvim clipboard (see += compared
	mouse = "a", -- allows me to scroll with my touchpad in two different splits just by hoevering the mouse in the split I wish to scroll
	-- cpoptions = vim.o.cpoptions .. 'x', -- stay at seach item when <esc> (ENTERS COMMAND WHEN HIT ESC from : MODE, DONT USE)
})

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
-- disable nvim intro
opt.shortmess:append "sI"

if utils.hasVersion("0.7") then
	options.set_options( 'o', {
		laststatus = 3
	})
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
  autowrite = true, -- autowrite buffer when it's not focused
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
  shortmess = "csa", -- disable some stuff on shortmess
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
