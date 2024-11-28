return {
	'numToStr/FTerm.nvim',
	config = function()
		require('FTerm').setup({
			border = 'single', -- Set the terminal window border style
		})
	end,
}
