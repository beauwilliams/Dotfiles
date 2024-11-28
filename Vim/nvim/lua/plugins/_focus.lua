local ignore_treetypes = { 'neo-tree', 'Nvimtree', 'nerdtree', 'chadtree', 'fern' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }
local tree_width = 30

local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
			vim.b.focus_disable = true
		end
	end,
	desc = 'Disable focus autoresize for BufType',
})


vim.api.nvim_create_autocmd('WinEnter', {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_treetypes, vim.bo.filetype) then
			vim.b.focus_disable = true
		end
	end,
	desc = 'Disable focus autoresize for BufType',
})
