require("init")

--TODO: Refactor these to lua
-- vim.o.spell = false
-- vim.o.spellfile = vim.fn.stdpath 'config' .. '/spellfile.utf-8.add'

-- vim.o.undofile = true
-- vim.o.undodir = vim.fn.stdpath 'cache' .. '/undo'

-- vim.o.backup = true
-- vim.o.backupdir = vim.fn.stdpath 'data' .. '/backup'

vim.o.history = 1000 --> cmd history depth
vim.o.undolevels = 1000 --> how many undos
vim.o.undoreload = 10000 --> number of lines to save for undo
vim.o.tabpagemax = 50 --> max number of tabs
if vim.fn.isdirectory(os.getenv( "HOME" )..'/.cache/nvim/.backup') == 0 then
vim.fn.mkdir(os.getenv("HOME")..'/.cache/nvim/.backup', 'p')
end
if vim.fn.isdirectory(os.getenv( "HOME" )..'/.cache/nvim/.swap') == 0 then
  vim.fn.mkdir(os.getenv("HOME")..'/.cache/nvim/.swap', 'p')
end
if vim.fn.isdirectory(os.getenv( "HOME" )..'/.cache/nvim/.undo') == 0 then
  vim.fn.mkdir(os.getenv("HOME")..'/.cache/nvim/.undo', 'p')
end
if vim.fn.isdirectory(os.getenv( "HOME" )..'/.cache/nvim/.session') == 0 then
  vim.fn.mkdir(os.getenv("HOME")..'/.cache/nvim/.session', 'p')
end

vim.opt.backupdir = os.getenv("HOME")..'/.cache/nvim/.backup'
vim.opt.directory = os.getenv("HOME")..'/.cache/nvim/.swap'
vim.opt.undodir = os.getenv("HOME")..'/.cache/nvim/.undo'
vim.opt.swapfile = true
