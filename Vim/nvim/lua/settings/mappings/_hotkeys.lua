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

--TODO: command refactor
------------------------------------------------------------------------------------------------------------------------------------------------
-- HOT KEYS
------------------------------------------------------------------------------------------------------------------------------------------------
set_keymap('n', '<leader>2', ':MySearchDotfiles<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>2', ':MySearchDotfiles<CR>', { noremap = true, silent = true })
utils.nnoremap(
	leader .. 1,
	":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown({}))<CR>"
)

utils.nnoremap(
	leader .. '3',
	":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>"
)
utils.vnoremap(
	leader .. '3',
	":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>"
)
utils.nnoremap(
	leader .. '4',
	":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.vnoremap(
	leader .. '4',
	":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.nnoremap(leader .. '5', ':Startify<cr>')
utils.vnoremap(leader .. '5', ':Startify<cr>')
-- utils.nnoremap(leader .. '6', ':GitMessenger<CR>') -- "SHOW GIT COMMIT / GIT BLAME POPUP
