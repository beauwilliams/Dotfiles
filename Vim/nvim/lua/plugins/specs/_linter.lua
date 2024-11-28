return {
	{
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lint = require('lint')

			lint.linters_by_ft = {
				javascript = { 'eslint_d' },
				typescript = { 'eslint_d' },
				javascriptreact = { 'eslint_d' },
				typescriptreact = { 'eslint_d' },
				svelte = { 'eslint_d' },
				python = { 'pylint' },
				solidity = { 'solhint' },
				lua = { 'luacheck' },
			}
		end,
	},
	{
		'Kasama/nvim-custom-diagnostic-highlight',
		config = function()
			require('nvim-custom-diagnostic-highlight').setup({})
		end,
	},
	{
		'folke/todo-comments.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('todo-comments').setup()
		end,
	},
}
