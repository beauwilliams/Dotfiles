return {
	{
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lint = require('lint')

			lint.linters_by_ft = {
				-- javascript = { 'eslint_d' },
				-- typescript = { 'eslint_d' },
				-- javascriptreact = { 'eslint_d' },
				-- typescriptreact = { 'eslint_d' },
				svelte = { 'eslint_d' },
				python = { 'pylint' },
				solidity = { 'solhint' },
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
	{ --view, install, manage npm modules from package.json
		'vuki656/package-info.nvim',
		config = function()
			require('package-info').setup()
		end,
	},
	{
		'bennypowers/nvim-regexplainer',
		config = function()
			require('regexplainer').setup()
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'MunifTanjim/nui.nvim',
		},
	},
}
