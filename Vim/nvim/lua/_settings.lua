local scopes = {o = vim.o, b = vim.bo, g = vim.g, w = vim.wo}
local set_options = function(locality,options)
local scope = scopes[locality]
    for key, value in pairs(options) do
        scope[key] = value
    end
end


set_options("g", {
    mapleader = " ",
})


set_options("o", {
    hlsearch = true, -- highlight matching search
    cursorline = true, -- enable cursorline
    number = true, -- enable line numbers
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
    autoread = true, -- loads file as soon as there are changes on disk
    wildmenu = true, -- enhanced tab completion for vim command bar
    wildmode = "list,full", -- Displays a handy list of commands we can tab thru"
    hidden = true, -- ENABLE BUFFERS TO HIDE - PREVENTS ERROR: E37: No write since last change (add ! to override) When opening a new buffer before saving current one
    relativenumber = true, -- Enable relative line numbers in ruler
    shiftround = true, -- Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up
    shortmess = "aF", -- abreviates messages and prevents file name being echoed when opened
    backspace = "indent,eol,start", -- this makes backspace work as normal
    scrolloff = 5, -- Set the cursor 5 lines down instead of at the top
    sidescroll = 2, -- make scrolling better, instead of wrap we sroll horizontally with the cursor
    wrap = false, -- dont wrap lines
    encoding = "UTF-8", -- REQUIRED BY DEV ICONS PLUGIN
    history = 200, -- keep 200 hungy commands in the stash
    updatetime = 200, -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable " delays and poor user experience. FOR ASYNC STUFF ONLY
    timeoutlen = 400, -- faster timeout wait time
    spelllang = "en", -- Set NEOVIMS NATIVE spell lang for spellchecker
    inccommand = "nosplit", -- This is Neovim only. inccommand shows you in realtime what changes your ex command should make. Right now it only supports s,but even that is incredibly useful. If you type :s/regex, it will highlight what matches regex. If you then add /change, it will show all matches replaced with change. This works with all of the regex properties, include backreferences and groups.
    clipboard = "unnamed", -- share system clipboard but also retain nvim clipboard (see += compared
    -- mouse = "a", -- allows me to scroll with my touchpad in two different splits just by hoevering the mouse in the split I wish to scroll
})





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
