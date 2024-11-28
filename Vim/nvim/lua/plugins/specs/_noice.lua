return {
	'folke/noice.nvim',
	event = 'VimEnter', -- Lazy load on VimEnter
	requires = {
		'MunifTanjim/nui.nvim', -- Required by noice.nvim
		'rcarriga/nvim-notify', -- Required by noice.nvim
	},
	config = function()
		local noice = safe_require('noice')
		if not noice then
			return
		end

		-- Setup noice.nvim
		noice.setup({
			views = {
				cmdline_popup = {
					border = {
						style = 'rounded',
						padding = { 0, 1 },
					},
					position = {
						row = '25%',
						col = '50%',
					},
					size = {
						width = '50%',
						height = 'auto',
					},
				},
				popupmenu = {
					enabled = false,
				},
			},
			cmdline = {
				enabled = true,
				view = 'cmdline_popup',
				opts = {},
				format = {
					cmdline = { pattern = '^:', icon = '', lang = 'vim' },
					search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
					search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
					filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
					lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
					help = { pattern = '^:%s*h%s+', icon = '' },
				},
			},
			messages = {
				enabled = true,
				view = 'notify',
				view_error = 'notify',
				view_warn = 'notify',
				view_history = 'split',
				view_search = 'virtualtext',
			},
			lsp_progress = {
				enabled = false,
			},
		})
	end,
}
