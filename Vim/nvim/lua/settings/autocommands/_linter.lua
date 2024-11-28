local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
	group = lint_augroup,
	callback = function()
		-- vim.notify('Automatically linting...')
		require('lint').try_lint()
	end,
})
