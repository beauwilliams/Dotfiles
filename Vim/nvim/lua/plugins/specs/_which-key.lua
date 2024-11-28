return {
	{ --> altrenative --> https://github.com/linty-org/key-menu.nvim
		-- help suggestions for key mappings
		'folke/which-key.nvim',
		dependencies = { { 'echasnovski/mini.icons', version = '*' }, { 'nvim-tree/nvim-web-devicons', lazy = true } },
		opts = {
			win = {
				-- don't allow the popup to overlap with the cursor
				no_overlap = true,
				-- width = 1,
				-- height = { min = 4, max = 25 },
				-- col = 0,
				-- row = math.huge,
				border = 'rounded',

				padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
				title = true,
				title_pos = 'center',
				zindex = 1000,
				-- Additional vim.wo and vim.bo options
				bo = {},
				wo = {
					position = 'bottom',
					winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				},
			},
			layout = {
				height = { min = 4, max = 30 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 4, -- spacing between columns
				align = 'left', -- align columns left, center or right
			},
			keys = {
				scroll_down = '<c-d>', -- binding to scroll down inside the popup
				scroll_up = '<c-u>', -- binding to scroll up inside the popup
			},
			icons = {
				breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
				separator = '➜', -- symbol used between a key and it's label
				group = '+', -- symbol prepended to a group
			},
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
		},
	},
}
