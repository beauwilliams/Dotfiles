return {
	-- NOTE:  TERMINAL CALLBACKS
	{
		'kassio/neoterm',
		dependencies = 'MunifTanjim/nui.nvim',
		config = function()
			require('plugins.mine._terminal')
		end,
	},

	-- NOTE: FLOATING TERMINAL
	-- OR "voldikss/vim-floaterm"
	-- OR 'itmecho/neoterm.nvim',
	{
		'numToStr/FTerm.nvim',
		config = function()
			require('FTerm').setup({
				border = 'single',
			})
		end,
	},
}
