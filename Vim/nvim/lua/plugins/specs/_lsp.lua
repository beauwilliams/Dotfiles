return {
	-- Plugins and their dependencies
	{
		'neovim/nvim-lspconfig', -- Predefined LSP Configs
	},

	{
		'ii14/lsp-command', -- LSP Command USAGE: :h :Lsp
	},

	{
		'lewis6991/hover.nvim',
		config = function()
			require('hover').setup({
				init = function()
					-- require providers
					require('hover.providers.lsp')
					-- require('hover.providers.gh')
					require('hover.providers.man')
					require('hover.providers.dictionary')
				end,
				preview_opts = {
					border = 'rounded',
				},
				title = true,
			})

			-- setup keymaps
			vim.keymap.set('n', 'gk', require('hover').hover_select, { desc = 'hover.nvim (select)' })
		end,
	},

	--  {
	--			-- LSP UI Enhancements
	--			'glepnir/lspsaga.nvim',
	--			branch = 'main',
	--			config = function()
	--				local saga = require('lspsaga')
	--
	--				saga.init_lsp_saga({
	--					border_style = 'rounded',
	--					code_action_keys = {
	--						quit = '<esc>',
	--						exec = '<CR>',
	--					},
	--					-- use emoji lightbulb in default
	--					code_action_icon = '',
	--					-- if true can press number to execute the codeaction in codeaction window
	--					code_action_num_shortcut = true,
	--					-- same as nvim-lightbulb but async
	--					code_action_lightbulb = {
	--						enable = false,
	--						enable_in_insert = true,
	--						cache_code_action = true,
	--						sign = true,
	--						update_time = 150,
	--						sign_priority = 20,
	--						virtual_text = true,
	--					},
	--					finder_action_keys = {
	--						open = 'o',
	--						vsplit = 's',
	--						split = 'i',
	--						tabe = 't',
	--						quit = '<esc>',
	--						scroll_down = '<C-f>',
	--						scroll_up = '<C-b>', -- quit can be a table
	--					},
	--					-- your configuration
	--				})
	--			end,
	--		},

	{
		'weilbith/nvim-code-action-menu', -- Code Action Menu
		cmd = 'CodeActionMenu',
	},

	{
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim', -- LSP Diagnostic virtual lines
		config = function()
			require('lsp_lines').setup()
		end,
	},
	{
		'kosayoda/nvim-lightbulb',
		config = function()
			require('nvim-lightbulb').setup({
				autocmd = { enabled = true },
			})
		end,
	},

	-- Any additional plugins can be added here
}
