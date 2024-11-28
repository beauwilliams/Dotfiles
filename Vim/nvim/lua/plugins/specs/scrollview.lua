return {
	{
		'dstein64/nvim-scrollview',
		config = function()
			require('scrollview').setup({
				excluded_filetypes = { 'File Tree', 'startify', 'nvimtree', 'neo-tree', 'dashboard' }, -- Example exclusions
				current_only = true, -- Show scrollbars only for the current window
				base = 'right', -- Position scrollbars on the right
				column = 1, -- Specify column for the scrollbar
			})
		end,
	},
}
