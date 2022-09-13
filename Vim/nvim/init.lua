require("init")

--TODO: Refactor these to lua
-- vim.o.spell = false
-- vim.o.spellfile = vim.fn.stdpath 'config' .. '/spellfile.utf-8.add'

-- vim.o.undofile = true
-- vim.o.undodir = vim.fn.stdpath 'cache' .. '/undo'

-- vim.o.backup = true
-- vim.o.backupdir = vim.fn.stdpath 'data' .. '/backup'

vim.cmd([[
if !isdirectory($HOME . "/.cache/nvim/.backup")
    call mkdir($HOME . "/.cache/nvim/.backup", "p", 0700)
endif
if !isdirectory($HOME . "/.cache/nvim/.undo")
    call mkdir($HOME . "/.cache/nvim/.undo", "p", 0700)
endif
if !isdirectory($HOME . "/.cache/nvim/.swap")
    call mkdir($HOME . "/.cache/nvim/.swap", "p", 0700)
endif
if !isdirectory($HOME . "/.cache/nvim/.session")
    call mkdir($HOME . "/.cache/nvim/.session", "p", 0700)
endif
set backupdir=~/.cache/nvim/.backup//
set directory=~/.cache/nvim/.swap//
if exists('&undodir')
  set undodir=~/.cache/nvim/.undo//
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

"DEBUG
function! Test()
    echo "test"
    return "test"
endfunction

"AUTO SAVES HELP TAGS"
autocmd BufWritePost ~/.config/nvim/doc/* :helptags ~/.config/nvim/doc
]])

--NOTE: This refuses to work in /ftplugin /ftdetect
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufRead"},
  {
    pattern = {"*.prisma"},
    callback = function()
      vim.bo.filetype = "prisma"
    end
  }
)

