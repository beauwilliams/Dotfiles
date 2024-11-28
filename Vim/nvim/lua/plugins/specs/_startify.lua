return {
	-- vim-startify plugin with dependency on vim-devicons
	{
		'mhinz/vim-startify',
		requires = { 'ryanoasis/vim-devicons' },
		event = 'VimEnter', -- Lazy load on VimEnter
		config = function()
			local g = vim.g
			local fn = vim.fn
			local datetime = os.date('%A %d %B %Y, %T')
			local version = vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
			local icons = safe_require('libraries._icons')
			if not icons then
				return
			end
			local ascii = {
				[[   ██╗     ███████╗████████╗███████╗     ██████╗ ███████╗████████╗    ██╗████████╗██╗]],
				[[   ██║     ██╔════╝╚══██╔══╝██╔════╝    ██╔════╝ ██╔════╝╚══██╔══╝    ██║╚══██╔══╝██║]],
				[[   ██║     █████╗     ██║   ███████╗    ██║  ███╗█████╗     ██║       ██║   ██║   ██║]],
				[[   ██║     ██╔══╝     ██║   ╚════██║    ██║   ██║██╔══╝     ██║       ██║   ██║   ╚═╝]],
				[[   ███████╗███████╗   ██║   ███████║    ╚██████╔╝███████╗   ██║       ██║   ██║   ██╗]],
				[[   ╚══════╝╚══════╝   ╚═╝   ╚══════╝     ╚═════╝ ╚══════╝   ╚═╝       ╚═╝   ╚═╝   ╚═╝]],
				'',
				'   ' .. icons.misc.RightUnfilledArrow .. '  Welcome, Beau',
				'',
				'   ' .. icons.misc.Branch .. '  Neovim Version: ' .. version,
				'',
				'   ' .. icons.misc.Calendar .. '  ' .. datetime,
				-- " " .. icons.misc.Plug .. " Plugins: " .. plugins,
			}

			local chad = {
				[[                                                                                    ⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠛⠋⠉⠈⠉⠉⠉⠉⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⡏⣀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⢏⣴⣿⣷⠀⠀⠀⠀⠀⢾⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿    ]],
				[[                                                                                    ⣿⣿⣟⣾⣿⡟⠁⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣷⢢⠀⠀⠀⠀⠀⠀⠀⢸⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣟⠀⡴⠄⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⣿    ]],
				[[                                                                                    ⣿⣿⣿⠟⠻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠶⢴⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⣿    ]],
				[[                                                                                    ⣿⣁⡀⠀⠀⢰⢠⣦⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⡄⠀⣴⣶⣿⡄⣿    ]],
				[[                                                                                    ⣿⡋⠀⠀⠀⠎⢸⣿⡆⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⠗⢘⣿⣟⠛⠿⣼    ]],
				[[                                                                                    ⣿⣿⠋⢀⡌⢰⣿⡿⢿⡀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣧⢀⣼    ]],
				[[      ██████╗██╗  ██╗ █████╗ ██████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗       ⣿⣿⣷⢻⠄⠘⠛⠋⠛⠃⠀⠀⠀⠀⠀⢿⣧⠈⠉⠙⠛⠋⠀⠀⠀⣿⣿⣿⣿⣿    ]],
				[[     ██╔════╝██║  ██║██╔══██╗██╔══██╗    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝       ⣿⣿⣧⠀⠈⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠟⠀⠀⠀⠀⢀⢃⠀⠀⢸⣿⣿⣿⣿    ]],
				[[     ██║     ███████║███████║██║  ██║    ██╔████╔██║██║   ██║██║  ██║█████╗         ⣿⣿⡿⠀⠴⢗⣠⣤⣴⡶⠶⠖⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡸⠀⣿⣿⣿⣿    ]],
				[[     ██║     ██╔══██║██╔══██║██║  ██║    ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝         ⣿⣿⣿⡀⢠⣾⣿⠏⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠉⠀⣿⣿⣿⣿    ]],
				[[     ╚██████╗██║  ██║██║  ██║██████╔╝    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗       ⣿⣿⣿⣧⠈⢹⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿    ]],
				[[      ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝     ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝       ⣿⣿⣿⣿⡄⠈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣿⣦⣄⣀⣀⣀⣀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠙⣿⣿⡟⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠁⠀⠀⠹⣿⠃⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⢐⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
				[[                                                                                    ⣿⣿⣿⣿⠿⠛⠉⠉⠁⠀⢻⣿⡇⠀⠀⠀⠀⠀⠀⢀⠈⣿⣿⡿⠉⠛⠛⠛⠉⠉    ]],
				[[                                                                                    ⣿⡿⠋⠁⠀⠀⢀⣀⣠⡴⣸⣿⣇⡄⠀⠀⠀⠀⢀⡿⠄⠙⠛⠀⣀⣠⣤⣤⠄⠀    ]],
			}

			local homer = {
				[[  ▒▒▒▒▒▒▒▓		    																						]],
				[[  ▒▒▒▒▒▒▒▓▓▓		    																						]],
				[[  ▒▓▓▓▓▓▓░░░▓		    																						]],
				[[  ▒▓░░░░▓░░░░▓	    																						]],
				[[  ▓░░░░░░▓░▓░▓	    																						]],
				[[  ▓░░░░░░▓░░░▓	    																						]],
				[[  ▓░░▓░░░▓▓▓▓             __    _                 __                      __         ______          __       ]],
				[[  ▒▓░░░░▓▒▒▒▒▓           / /   (_)   _____       / /   ____ ___  ______ _/ /_       / ____/___  ____/ /__     ]],
				[[  ▒▒▓▓▓▓▒▒▒▒▒▓          / /   / / | / / _ \     / /   / __ `/ / / / __ `/ __ \     / /   / __ \/ __  / _ \    ]],
				[[  ▒▒▒▒▒▒▒▒▓▓▓▓         / /___/ /| |/ /  __/    / /___/ /_/ / /_/ / /_/ / / / /    / /___/ /_/ / /_/ /  __/    ]],
				[[  ▒▒▒▒▒▓▓▓▒▒▒▒▓       /_____/_/ |___/\___(_)  /_____/\__,_/\__,_/\__, /_/ /_(_)   \____/\____/\__,_/\___(_)   ]],
				[[  ▒▒▒▒▓▒▒▒▒▒▒▒▒▓                                                /____/                                        ]],
				[[  ▒▒▒▓▒▒▒▒▒▒▒▒▒▓      ~~ Homer J. Simpson ~~																	]],
				[[  ▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓	    																						]],
				[[  ▒▓▒▓▒▒▒▒▒▒▒▒▒▓	    																						]],
				[[  ▒▓▒▓▓▓▓▓▓▓▓▓▓	    																						]],
				[[  ▒▓▒▒▒▒▒▒▒▓		    																						]],
				[[  ▒▒▓▒▒▒▒▒▓		    																						]],

				[[           		    																						]],
				-- Define custom startify header and other settings
				'   '
					.. icons.misc.RightUnfilledArrow
					.. '  Welcome, Beau',
				'',
				'   ' .. icons.misc.Branch .. '  Neovim Version: ' .. version,
				'',
				'   ' .. icons.misc.Calendar .. '  ' .. datetime,
				-- " " .. icons.misc.Plug .. " Plugins: " .. plugins,
			}

			-- Set startify settings
			g.startify_enable_special = 0
			g.startify_files_number = 10
			g.startify_change_to_dir = 1
			g.startify_session_dir = '~/.cache/nvim/.session'
			g.startify_session_persistence = 1
			g.startify_change_to_vcs_root = 1
			g.startify_padding_left = 2
			g.startify_session_number = 10
			g.startify_session_sort = 0
			g.startify_custom_header = homer
			g.startify_relative_path = 1
			-- g.startify_use_env = 1 -- Display $MYVIMRC instead of .vimrc etc...

			-- Define the startify lists
			g.startify_lists = {
				{ type = 'files', header = { 'Recent Files' } },
				{ type = 'dir', header = { 'Current Directory: ' .. fn.getcwd() } },
				{ type = 'sessions', header = { 'Sessions' } },
				{ type = 'bookmarks', header = { 'Bookmarks' } },
				{ type = 'commands', header = { 'Commands' } },
			}

			-- Define custom commands for startify
			g.startify_commands = {
				{ ps = { 'Packer Sync', ':PackerSync' } },
				{ pi = { 'Packer Install', ':PackerInstall' } },
				{ pc = { 'Packer Clean', ':PackerClean' } },
				{ ch = { 'Check Health', 'checkhealth' } },
				{ h = { 'Vim Help', ':Telescope help_tags' } },
				{ e = { 'New file', ':enew' } },
			}

			-- Define bookmarks for startify
			g.startify_bookmarks = {
				{ n = '~/Dropbox/Software Eng/Workspaces/Neorg/index.norg' },
				{ v = '~/.config/nvim/init.vim' },
				{ z = '~/.zshrc' },
				{ g = '~/.gitconfig' },
				{ s = '~/.ssh/config' },
				{ vn = '/Users/admin/Library/Caches/Homebrew/neovim--git' },
				{ ll = '~/.cache/nvim/lsp.log' },
				{ ls = '~/.config/nvim/logs/startuptime/startup.log' },
			}
		end,
	},
}
