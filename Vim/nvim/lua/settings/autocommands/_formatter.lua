--local lsp_formatting = function(bufnr)
--	require('conform').format({ bufnr = bufnr })
--end
--
----NOTE: auto formatting, with builtin lsp formatter disabled
--local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
---- if client.supports_method('textDocument/formatting') then
--vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--vim.api.nvim_create_autocmd('BufWritePre', {
--	group = augroup,
--	buffer = bufnr,
--	callback = function()
--		vim.notify('Automatically formatting...')
--		lsp_formatting(bufnr)
--	end,
--})
--
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
vim.api.nvim_create_autocmd('BufWritePre', {
	group = augroup,
	pattern = '*',
	callback = function(args)
		-- vim.notify('Automatically formatting...')
		require('conform').format({ bufnr = args.buf })
	end,
})
