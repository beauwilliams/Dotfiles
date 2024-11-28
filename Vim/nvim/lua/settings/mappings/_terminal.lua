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

------------------------------------------------------------------------------------------------------------------------------------------------
--TERMINAL MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
utils.tnoremap('<esc>', '<C-\\><C-n>') --Allows escape key to work correctly
-- utils.nnoremap(leader .. 't', '<CMD>lua require"FTerm".toggle()<CR>')
-- utils.tnoremap(leader .. 't', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')
--TODO: command refactor
utils.nnoremap(leader .. 'T', '<CMD>1Ttoggle<CR>') --NOTE: this has bug uysing toggle
set_keymap('n', '<leader>t', ':MyTermRunTaskCommand<CR>', {})
vim.cmd([[let g:neoterm_default_mod='botright vnew']])
vim.cmd([[let g:neoterm_keep_term_open=0]])
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
