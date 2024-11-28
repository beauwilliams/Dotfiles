local utils = safe_require('libraries._set_mappings')
if not utils then
	return
end

local leader = '<space>'

--TODO: command refactor
-- SEARCH AND REPLACE
-- replace word under cursor
utils.nnoremap(leader .. 'r', ':lua require("spectre").open()<cr>')
utils.vnoremap(leader .. 'r', ':lua require("spectre").open()<cr>')
utils.nnoremap('R', ':%s/\\<<C-r><C-w>\\>//g<Left><Left><C-r><C-w>')
-- Replace/Delete words quick! ONE BY ONE.
-- c. c, d. d,
utils.nnoremap('c.', "/\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgn")
utils.nnoremap('c,', "?\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgN")
utils.nnoremap('d.', "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgn")
utils.nnoremap('d,', "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgN")
