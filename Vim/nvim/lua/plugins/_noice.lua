safe_require('noice').setup({
	views = {
		cmdline_popup = {
			border = {
				style = 'rounded',
				padding = { 0, 1 },
			},
			position = {
				row = 5,
				col = '50%',
			},
			size = {
				width = 120,
				height = 'auto',
			},
			-- filter_options = {},
			-- win_options = {
			-- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			-- },
		},
		popupmenu = {
			enabled = false,
		},
	},
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		opts = {}, -- extra opts for the cmdline view. See section on views
		---@type table<string, CmdlineFormat>
		format = {
			-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
			-- view: (default is cmdline view)
			-- opts: any options passed to the view
			-- icon_hl_group: optional hl_group for the icon
			cmdline = { pattern = '^:', icon = '', lang = 'vim' },
			search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
			search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
			filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
			lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
			help = { pattern = '^:%s*h%s+', icon = '' },
			-- lua = false, -- to disable a format, set to `false`
		},
	},
	messages = {
		-- NOTE: If you enable messages, then the cmdline is enabled automatically.
		-- This is a current Neovim limitation.
		enabled = true, -- enables the Noice messages UI
		view = 'notify', -- default view for messages
		view_error = 'notify', -- view for errors
		view_warn = 'notify', -- view for warnings
		view_history = 'split', -- view for :messages
		view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
	},
	lsp_progress = {
		enabled = false,
	},
})
