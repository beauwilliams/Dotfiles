return {
	{
		'lewis6991/gitsigns.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup({
				current_line_blame = true, -- Enable inline blame
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 100, -- Delay in ms before blame is displayed
				},
				current_line_blame_formatter = '<author> ∙ <summary> ∙ <author_time>',
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Add additional keybindings if needed
					map('n', '<leader>gb', function()
						gs.blame_line({ full = true })
					end)
					map('n', '<leader>tb', gs.toggle_current_line_blame)
				end,
			})
		end,
	},
	{ 'tpope/vim-fugitive' }, -- Adds 'native' git commands to vim. silent commands. e.g :Git add - won't prompt you to enter to confirm
	{ 'sindrets/diffview.nvim' }, -- Neovim enhanced diffview [:DiffviewOpen] (better than signify)
	{
		'kdheepak/lazygit.nvim',
		lazy = true,
		cmd = {
			'LazyGit',
			'LazyGitConfig',
			'LazyGitCurrentFile',
			'LazyGitFilter',
			'LazyGitFilterCurrentFile',
		},
		-- optional for floating window border decoration
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
		},
	},
}
