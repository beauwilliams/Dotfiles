return {

	{ 'sheerun/vim-polyglot' }, -- NOTE: FILETYPE SYNTAX
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate', -- Equivalent to `run = ':TSUpdate'` in Packer
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects', -- Add other related plugins here
		},
		config = function()
			local api = vim.api
			local tsconf = require('nvim-treesitter.configs')
			local parser_configs = require('nvim-treesitter.parsers')
			local treesitter_install = require('nvim-treesitter.install')

			-- Custom parser configuration for Neorg
			parser_configs.norg = {
				install_info = {
					url = 'https://github.com/nvim-neorg/tree-sitter-norg',
					files = { 'src/parser.c', 'src/scanner.cc' },
					branch = 'main',
				},
			}

			-- Use a specific compiler
			treesitter_install.compilers = { 'gcc-12' }

			-- Treesitter setup
			tsconf.setup({
				ensure_installed = {
					'bash',
					'c',
					'cpp',
					'go',
					'java',
					'javascript',
					'json',
					'lua',
					'python',
					'ruby',
					'toml',
					--'solidity',
					'norg',
					'tsx',
					'typescript',
					'regex',
				},
        highlight = {
          enable = true,
					use_languagetree = true,
				},
				indent = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				rainbow = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<Enter>',
						scope_incremental = 'gnc',
						node_incremental = '<Enter>',
						node_decremental = '<BS>',
					},
				},
				refactor = {
					highlight_definitions = { enable = false },
					navigation = {
						enable = true,
						keymaps = {
							goto_next_usage = '<A-*>',
							goto_previous_usage = '<A-#>',
						},
					},
					smart_rename = {
						enable = true,
					},
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['aC'] = '@class.outer',
							['iC'] = '@class.inner',
							['ac'] = '@conditional.outer',
							['ic'] = '@conditional.inner',
							['ae'] = '@block.outer',
							['ie'] = '@block.inner',
							['al'] = '@loop.outer',
							['il'] = '@loop.inner',
							['is'] = '@statement.inner',
							['as'] = '@statement.outer',
							['ad'] = '@comment.outer',
							['am'] = '@call.outer',
							['im'] = '@call.inner',
						},
					},
					swap = {
						enable = true,
						swap_next = {},
						swap_previous = {},
					},
				},
				playground = {
					enable = true,
					updatetime = 25,
					keybindings = {
						toggle_query_editor = 'o',
						toggle_hl_groups = 'i',
						toggle_injected_languages = 't',
						toggle_anonymous_nodes = 'a',
						toggle_language_display = 'I',
						focus_language = 'f',
						unfocus_language = 'F',
						update = 'R',
						goto_node = '<cr>',
						show_help = '?',
					},
				},
			})

			-- Auto-install missing parsers
			local ask_install = {}
			function EnsureTSParserInstalled()
				local parsers = require('nvim-treesitter.parsers')
				local lang = parsers.get_buf_lang()
				if
					parsers.get_parser_configs()[lang]
					and not parsers.has_parser(lang)
					and ask_install[lang] ~= false
				then
					vim.schedule(function()
						print('Install treesitter parser for ' .. lang .. ' ? Y/n')
						local ok, response =
							pcall(vim.fn.confirm, 'Install treesitter parser for this filetype?', '&Yes\n&No', 2)
						if ok and response == 1 then
							vim.cmd('TSInstall ' .. lang)
						else
							ask_install[lang] = false
						end
					end)
				end
			end

			-- Autocmd for auto-installation of parsers
			api.nvim_create_autocmd('FileType', {
				pattern = '*',
				callback = EnsureTSParserInstalled,
			})

			-- Highlight arguments setup
			api.nvim_create_autocmd('BufEnter', {
				pattern = '*',
				callback = function()
					require('hlargs').setup({ color = '#83a598' })
				end,
			})
		end,
	},
	-- Treesitter Playground
	{
		'nvim-treesitter/playground',
		cmd = 'TSPlaygroundToggle', -- Lazy-load when this command is run
		config = function()
			-- Optional setup for Playground can go here
		end,
	},

	-- Show Treesitter context at the end of functions, classes, etc.
	{
		'haringsrob/nvim_context_vt',
		event = 'BufReadPost', -- Load when a file is read
		config = function()
			require('nvim_context_vt').setup()
		end,
	},

	-- Treesitter Refactor for smart renaming and highlighting
	{
		'nvim-treesitter/nvim-treesitter-refactor',
		dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Ensure Treesitter is loaded
		config = function()
			require('nvim-treesitter.configs').setup({
				refactor = {
					highlight_definitions = { enable = true },
					highlight_current_scope = { enable = false },
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = 'grr', -- Keymap for smart rename
						},
					},
				},
			})
		end,
	},

	-- Autoclose and autorename HTML tags using Treesitter
	{
		'windwp/nvim-ts-autotag',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = 'InsertEnter', -- Lazy-load in insert mode
		config = function()
			require('nvim-treesitter.configs').setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},

	-- Treesitter text objects for better text navigation and manipulation
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = 'BufReadPost', -- Load when a file is opened
		config = function()
			require('nvim-treesitter.configs').setup({
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@conditional.outer',
							['ic'] = '@conditional.inner',
							['al'] = '@loop.outer',
							['il'] = '@loop.inner',
						},
					},
				},
			})
		end,
	},

	-- Highlight arguments in function calls
	{
		'm-demare/hlargs.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = 'BufReadPost', -- Load when a file is opened
		config = function()
			require('hlargs').setup({
				color = '#83a598', -- Customize highlight color
			})
		end,
	},

}
