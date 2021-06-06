--don't call globals unneccessarily
local o = vim.o
local g = vim.g
--[[ local bo = vim.bo --> buffer only use bo
local wo = vim.wo --> window only use wo ]]

-- no need for a global function
local set_options = function(locality,options)
    for key, value in pairs(options) do
        locality[key] = value
    end
end

local options_o = {
  hlsearch = true, -- highlight matching search
  cursorline = true, -- enable cursorline
  number = true, -- enable line numbers
  expandtab = true, -- this feature means that tabs are actually whitespaces so when we send code to friend indentation is not messed up
  ignorecase = true, -- ignore cases when searching
  smartcase = true, -- However if we use a capital in search string we then consider case-sensitivity, ignorecase is disabled
  undofile = true, -- Keeps undo history even after we close a file
  showmatch = true, -- match opening and closing braces
  showmode = false, -- turns off the --INSERT-- etc mode messages at very bottom
  lazyredraw = true, -- hopefully this speeds up vim!
  autoread = true, -- loads file as soon as there are changes on disk
  wildmenu = true, -- enhanced tab completion for vim command bar
  hidden = true, -- ENABLE BUFFERS TO HIDE - PREVENTS ERROR: "E37: No write since last change (add ! to override) When opening a new buffer before saving current one
  shiftround = true, -- Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up


}

local options_g = {
    mapleader = " ", -- leader is the space key
    softtabstop = "4", --option so make backspace delete entire tab
    tabstop = "16",
    shiftwidth = "4",
    -- shortmess = "w",
    backspace = {"indent", "eol", "start"},
    scrolloff = "5",
    encoding = "UTF-8",
    -- shortmess


}

--[[ local options_buffer = {
} ]]

--[[ local options_window = {
} ]]

--set locally. no need to call elsewhere
set_options(o,options_o) --set global options
set_options(g,options_g) --set global vars
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







-- ANOTHER METHOD
--[[ local apply_options = function(opts)
  for k, v in pairs(opts) do
    if v == true then
      cmd('set ' .. k)
    elseif v == false then
      cmd(string.format('set no%s', k))
    else
      cmd(string.format('set %s=%s', k, v))
    end
  end
end ]]
