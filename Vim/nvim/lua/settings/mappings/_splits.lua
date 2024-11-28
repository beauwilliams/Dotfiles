local utils = safe_require('libraries._set_mappings')
if not utils then
	return
end

local leader = '<space>'
local g = vim.g
--- @diagnostic disable-next-line: unused-local
local api = vim.api
local cmd = vim.cmd
local set_keymap = vim.keymap.set

-- NOTE: WINDOW NAVIGATION
-- leader-w for SPLIT CYCLING (cycle current windows)
-- leader-W takes us anticlockwise
set_keymap('n', '<Leader>k', ':FocusSplitUp<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>j', ':FocusSplitDown<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>h', ':FocusSplitLeft<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>l', ':FocusSplitRight<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>w', ':FocusSplitCycle<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>W', ':FocusSplitCycle reverse<CR>', { noremap = true, silent = true })

-- Resize our splits with <leader> ;/'/,/.- easily
set_keymap('n', '<Leader>.', ':exe "resize " . (winheight(0) * 4/3)<CR>', { silent = true, noremap = true })
set_keymap('n', '<Leader>,', ':exe "resize " . (winheight(0) * 3/4)<CR>', { silent = true, noremap = true })
set_keymap('n', '<leader>;', ':exe "vertical resize " . (winwidth(0) * 3/4)<CR>', { silent = true, noremap = true })
set_keymap('n', "<leader>'", ':exe "vertical resize " . (winwidth(0) * 4/3)<CR>', { silent = true, noremap = true })

-- CHANGE A SPLIT ORENTATION FROM HORIZONTAL TO VERTICAL AND VICE VERSA
set_keymap('n', '<leader>[', '<c-w>H', { silent = true, noremap = true })
set_keymap('n', '<leader>]', '<c-w>K', { silent = true, noremap = true })
