return {
	-- NOTE: SPLITS + WINDOW MANAGEMENT
	{
		'nvim-focus/focus.nvim',
		config = function()
			-- Setup the focus.nvim plugin
			require('focus').setup({
				enable = true, -- Enable module
				commands = true, -- Create Focus commands
				autoresize = {
					enable = true, -- Enable or disable auto-resizing of splits
					width = 0, -- Force width for the focused window
					height = 0, -- Force height for the focused window
					minwidth = 0, -- Force minimum width for the unfocused window
					minheight = 0, -- Force minimum height for the unfocused window
					height_quickfix = 10, -- Set the height of quickfix panel
				},
				split = {
					bufnew = true, -- Create blank buffer for new split windows
					tmux = false, -- Create tmux splits instead of neovim splits
				},
				ui = {
					number = false, -- Display line numbers in the focused window only
					relativenumber = false, -- Display relative line numbers in the focused window only
					hybridnumber = true, -- Display hybrid line numbers in the focused window only
					absolutenumber_unfocused = false, -- Preserve absolute numbers in the unfocused windows
					cursorline = true, -- Display a cursorline in the focused window only
					cursorcolumn = false, -- Display cursorcolumn in the focused window only
					colorcolumn = {
						enable = false, -- Display colorcolumn in the focused window only
						list = '+1', -- Set the comma-separated list for the colorcolumn
					},
					signcolumn = true, -- Display signcolumn in the focused window only
					winhighlight = false, -- Auto highlighting for focused/unfocused windows
				},
			})

			-- Custom autocommands for managing focus behavior based on buffer and filetypes
			local ignore_treetypes = { 'neo-tree', 'Nvimtree', 'nerdtree', 'chadtree', 'fern' }
			local ignore_buftypes = { 'nofile', 'prompt', 'popup' }
			local tree_width = 30

			local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

			-- Autocommand to disable focus autoresize for certain buffer types
			vim.api.nvim_create_autocmd('BufEnter', {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
						vim.b.focus_disable = true
					end
				end,
				desc = 'Disable focus autoresize for BufType',
			})

			-- Autocommand to disable focus autoresize for certain file types
			vim.api.nvim_create_autocmd('WinEnter', {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_treetypes, vim.bo.filetype) then
						vim.b.focus_disable = true
					end
				end,
				desc = 'Disable focus autoresize for FileType',
			})
		end,
	},
}
