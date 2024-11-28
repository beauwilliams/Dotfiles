return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope = safe_require('telescope')
			local actions = safe_require('telescope.actions')

			if not telescope or not actions then
				return
			end

			vim.cmd('autocmd FileType TelescopePrompt setl nocursorline')
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							['<esc>'] = actions.close,
							['<C-c>'] = function()
								vim.cmd([[stopinsert]]) --start normal mode if we need it
							end,
						},
					},
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
					},
					-- find_command = { 'rg', '--files', '--hidden'},
					-- layout_config.prompt_position = "top",
					-- prompt_prefix = ">",
					-- path_display = { 'absolute', 'shorten'}, -- only display the first character of each directory e.g --> s/n/main.c
					layout_strategy = 'vertical',
					layout_config = {
						horizontal = {
							mirror = false,
							prompt_position = 'top',
							width = 0.75,
							height = 0.75,
							preview_cutoff = 120,
						},
						vertical = {
							prompt_position = 'top',
							width = 0.5,
							mirror = true, -- makes prompt on top
						},
					},
					initial_mode = 'insert',
					selection_strategy = 'reset',
					sorting_strategy = 'ascending',
					file_sorter = require('telescope.sorters').get_fuzzy_file,
					file_ignore_patterns = {
						'luadisabled',
						'vimdisabled',
						'forks',
						'.backup',
						'.swap',
						'.langservers',
						'.session',
						'.undo',
						'.git/',
						'node_modules',
						'vendor',
						'.cache',
						'.vscode-server',
						'.Desktop',
						'.Documents',
						'classes',
						'quantumimage',
					},
					generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
					winblend = 0,
					border = {},
					borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
					color_devicons = true, -- Whether to color devicons or not
					use_less = true,
					set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
					file_previewer = require('telescope.previewers').cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
					grep_previewer = require('telescope.previewers').vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
					qflist_previewer = require('telescope.previewers').qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

					-- Developer configurations: Not meant for general override
					-- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
				},
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
					frecency = {
						show_unindexed = true,
						ignore_patterns = { '*.git/*', '*/tmp/*' },
						workspaces = {
							['nvim'] = '/Users/admin/.config/nvim',
							['packer'] = '/Users/admin/.local/share/nvim/site/pack/packer',
							['uni'] = '/Users/admin/Dropbox/Software Eng/University Work',
							['code'] = '/Users/admin/Dropbox/Software Eng/Projects/My Codes',
						},
					},
				},
			})

			vim.cmd([[highlight TelescopeBorder guifg=#4c4c4c]])
			vim.cmd([[highlight TelescopeSelection guifg=#ffffff guibg=#393939 gui=bold]])
			vim.cmd([[highlight TelescopeSelectionCaret guifg=#749484 gui=bold]])
		end,
	},

	{
		'nvim-telescope/telescope-frecency.nvim',
		config = function()
			require('telescope').load_extension('frecency')
		end,
		dependencies = { 'tami5/sql.nvim' },
	},
	-- NOTE:  TELESCOPE Z INTEGRATION
	{
		'nvim-telescope/telescope-z.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-telescope/telescope.nvim' },
		},
		config = function()
			require('telescope').load_extension('z')
			-- ... other telescope settings
		end,
	},
	--use {
	--   "cljoly/telescope-repo.nvim",
	--    config = require "telescope".load_extension "repo"
	--}
	-- NOTE:  CHEATSHEETS
	{
		'sudormrfbin/cheatsheet.nvim', --> Telescope Based Cheatsheet
		dependencies = {
			-- optional
			{ 'nvim-telescope/telescope.nvim' },
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-lua/plenary.nvim' },
		},
	},
	{ 'nvim-telescope/telescope-fzy-native.nvim' },
	{ 'nvim-telescope/telescope-symbols.nvim' },
	-- NOTE:  Telescope projects
	-- ROOT PATH .GIT ETC, ALSO A TELESCOPE EXTENSION TO DISPLAY PROJECTS PREVIOUSLY VISITED
	{
		'ahmedkhalf/project.nvim',
		config = function()
			require('project_nvim').setup({})
			require('telescope').load_extension('projects')
		end,
	},
	-- NOTE:  Clipboard manager neovim plugin with telescope integration
	-- :Telescope neoclip
	{
		'AckslD/nvim-neoclip.lua',
		config = function()
			require('neoclip').setup({
				default_register = '*',
			})
			require('telescope').load_extension('neoclip')
		end,
	},
}
