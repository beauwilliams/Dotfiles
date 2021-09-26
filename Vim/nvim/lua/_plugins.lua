--[[
     ____     __    __  __   ______    ____    _   __   _____
   / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
   ______   ____     _   __    ______    ____   ______
  / ____/  / __ \   / | / /   / ____/   /  _/  / ____/
 / /      / / / /  /  |/ /   / /_       / /   / / __
/ /___   / /_/ /  / /|  /   / __/     _/ /   / /_/ /
\____/   \____/  /_/ |_/   /_/       /___/   \____/

--]]
--[[
    ____     ___    ______    __ __    ______    ____            ____    _   __    ____  ______
   / __ \   /   |  / ____/   / //_/   / ____/   / __ \          /  _/   / | / /   /  _/ /_  __/
  / /_/ /  / /| | / /       / ,<     / __/     / /_/ /          / /    /  |/ /    / /    / /
 / ____/  / ___ |/ /___    / /| |   / /___    / _, _/         _/ /    / /|  /   _/ /    / /
/_/      /_/  |_|\____/   /_/ |_|  /_____/   /_/ |_|         /___/   /_/ |_/   /___/   /_/

--/*
--* INSTALL PACKER, LUA BASED PACKAGE MANAGER. USE/DEPENDENCY BASED PACKAGE MGMT
--*/
--]]
--local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

--if fn.empty(fn.glob(install_path)) > 0 then
--execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--end

local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	-- TODO: Maybe handle windows better?
	if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
		return
	end

	local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))

	vim.fn.mkdir(directory, 'p')

	local out = vim.fn.system(
		string.format('git clone %s %s', 'https://github.com/wbthomason/packer.nvim', directory .. '/packer.nvim')
	)

	print(out)
	print('Downloading packer.nvim...')

	return
end

-- FOR LUAROCKS TO INSTALL RIGHT
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')
vim.cmd('autocmd BufWritePost _plugins.lua PackerCompile') -- Auto compile when there are changes to plugins

--[[
    ____     __    __  __   ______    ____    _   __           ____    _   __    ____  ______   _____
   / __ \   / /   / / / /  / ____/   /  _/   / | / /          /  _/   / | / /   /  _/ /_  __/  / ___/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /           / /    /  |/ /    / /    / /     \__ \
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /          _/ /    / /|  /   _/ /    / /     ___/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/          /___/   /_/ |_/   /___/   /_/     /____/

--]]
--
--
-------------------------------------------------------------------------
--
--PACKER IS CAPABLE OF MANAGING ITSELF. IT INITS FIRST THEN CALLS REST OF OUR PLUGINS
require('packer').startup({
	function(use)
		use({ 'wbthomason/packer.nvim', opt = true })

		--SPEED UP NVIM REQUIRE AND STARTUP TIME
		use({ 'lewis6991/impatient.nvim', rocks = 'mpack' })

		-- DEBUG STUFF
		-- https://github.com/henriquehbr/nvim-startup.lua

		--[[
  ______    __  __    ______    __  ___    ______   _____          ___             __  __    ____
 /_  __/   / / / /   / ____/   /  |/  /   / ____/  / ___/         ( _ )           / / / /   /  _/
  / /     / /_/ /   / __/     / /|_/ /   / __/     \__ \         / __ \/|        / / / /    / /
 / /     / __  /   / /___    / /  / /   / /___    ___/ /        / /_/  <        / /_/ /   _/ /
/_/     /_/ /_/   /_____/   /_/  /_/   /_____/   /____/         \____/\/        \____/   /___/

--]]
		--THEMES/UX/UI PLUGINS
		use('gruvbox-community/gruvbox')
		use('folke/lsp-colors.nvim') -- Plugin that creates missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin LSP client.
		-- use 'ghifarit53/tokyonight-vim'
		-- use "sainnhe/gruvbox-material"
		-- another I would like to try https://github.com/sainnhe/everforest
		--use 'eddyekofo94/gruvbox-flat.nvim'

		--COLOURED BRACES
		use('p00f/nvim-ts-rainbow') --> Treesitter compatible rainbow parentheses

		--INDENT LINES
		use({ 'lukas-reineke/indent-blankline.nvim', config = "vim.g.indent_blankline_char = '│'" })
		--HORIZONTAL LINES --> Looks bad.. Not working right
		--[[ use({
			"lukas-reineke/headlines.nvim",
			config = function()
				require("headlines").setup()
			end,
		}) ]]

		--STATUSLINE
		use('beauwilliams/statusline.lua')
		--TABLINE
		--[[ use {
      "jose-elias-alvarez/buftabline.nvim",
      requires = {"kyazdani42/nvim-web-devicons"}, -- optional!
      config = function() require("buftabline").setup {} end
    } ]]
		use({
			'beauwilliams/focus.nvim',
			--[[ cmd = { "FocusSplitNicely", "FocusSplitCycle" },
			module = "focus", ]]
			config = function()
				require('focus').setup({
					tmux = false,
					hybridnumber = true,
					excluded_filetypes = { 'toggleterm', 'fterm', 'term' },
					signcolumn = 'number',
					bufnew = true,
				})
			end,
		})
		-- use 'beauwilliams/imnotaquitter.nvim'

		-- SCROLL BARS
		use('dstein64/nvim-scrollview')

		-- STARIFY / SESSIONS
		use({
			'mhinz/vim-startify',
			requires = 'ryanoasis/vim-devicons',
		})
		-- Alternative lua version (not yet tested) https://github.com/rmagatti/auto-session
		-- or https://github.com/folke/persistence.nvim

		-- SMOOTH SCROLLING
		-- use {"psliwka/vim-smoothie"} --  some very smooth ass scrolling
		use({
			'karb94/neoscroll.nvim',
			setup = require('neoscroll').setup(),
		})

		-- HEX COLOUR PREVIEW
		use({ 'rrethy/vim-hexokinase' }) --, run = "make hexokinase" }) -- preview hex colors with litle square
		-- CURSOR FLASH --> helps orientate quicker switching windows etc cursorline flash when switch
		-- https://github.com/edluffy/specs.nvim
		-- https://github.com/edluffy/specs.nvim
		use({
			'danilamihailov/beacon.nvim',
			config = function()
				vim.g.beacon_size = 90
				vim.g.beacon_minimal_jump = 25
				vim.g.beacon_shrink = 0
			end,
		})

		-- use 'romgrk/barbar.nvim' --> better tab bars using my own happy with it tho

		-- START: TOOLWINDOW configs, includes diag list, todo list, terminal, quickfix list
		use('EthanJWright/toolwindow.nvim') -- A toolwindow for trouble, nvim-toggleterm, quickfix, todos
		use({
			-- toolwindow compatible terminal
			'akinsho/nvim-toggleterm.lua',
			config = 'require("toggleterm").setup{}',
		})
		use({
			--> toolwindow compatible list for navigating errors etc
			'folke/trouble.nvim',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require('trouble').setup({})
			end,
		})
		use({
			'folke/todo-comments.nvim', --> TOOLWWINDOW COMPATIBLE, Highlight and navigate comments in code
			requires = 'nvim-lua/plenary.nvim',
			config = function()
				require('todo-comments').setup({})
			end,
		})
		-- END: QUICKFIX configs

		use({
			-- OR "voldikss/vim-floaterm"
			'beauwilliams/FTerm.nvim', --> Floating terminal window
			config = function()
				require('FTerm').setup({
					border = 'single',
				})
			end,
		})

		use({
			'itmecho/neoterm.nvim',
			config = function()
				require('neoterm').setup({
					clear_on_run = true, -- run clear command before user specified commands
					mode = 'fullscreen', -- vertical/horizontal/fullscreen
					noinsert = false, -- disable entering insert mode when opening the neoterm window
				})
			end,
		})
		--[[
    ____     ____    ____    ______    ____     ___     __  ___    __  ___    ____    _   __   ______
   / __ \   / __ \  / __ \  / ____/   / __ \   /   |   /  |/  /   /  |/  /   /  _/   / | / /  / ____/
  / /_/ /  / /_/ / / / / / / / __    / /_/ /  / /| |  / /|_/ /   / /|_/ /    / /    /  |/ /  / / __
 / ____/  / _, _/ / /_/ / / /_/ /   / _, _/  / ___ | / /  / /   / /  / /   _/ /    / /|  /  / /_/ /
/_/      /_/ |_|  \____/  \____/   /_/ |_|  /_/  |_|/_/  /_/   /_/  /_/   /___/   /_/ |_/   \____/

--]]
		-- NOTE: DOCUMENTATION
		use({
			-- OR.. nvim-treesitter/nvim-tree-docs
			'kkoomen/vim-doge', -- DOcumentation GEnerator, Must run :call doge#install() first time for now TODO: fix
			run = 'vim.cmd[[call doge#install()]]',
		})

		-- NOTE: Indenting
		use('Darazaki/indent-o-matic') --Faster than vim-sleuth. Detects indent based on file. No performance impact

		-- NOTE: Cheat sheets
		use('RishabhRD/popfix') -- cheat.sh integration for neovim in elegant way
		use('RishabhRD/nvim-cheat.sh')
		-- use('dbeniamine/cheat.sh-vim') --> E.G :Howin javascript open file || :Cheat! factory [takes &ft e.g lua/factory]

		-- NOTE: LSP SERVERS
		-- COQ
		use({ 'ms-jpq/coq_nvim', branch = 'coq' }) -- main one
		use({ 'ms-jpq/coq.artifacts', branch = 'artifacts' }) -- 9000+ Snippets
		--COMPE
		--[[ use("hrsh7th/nvim-compe") --> COMPLETION MENU
		use({ "tzachar/compe-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-compe" })
		use("hrsh7th/vim-vsnip") --> FAST SNIPPETS FOR NVIM COMPATIBLE WITH COMPE
		use("rafamadriz/friendly-snippets") --> Snippets library compatible with vim-vsnip ]]

		--		use({
		--			-- ALE CONFIG --> LANGUAGE ERROR DETECTION AND LINTING SERVICE
		--			--  Shorten error/warning flags
		--			'w0rp/ale',
		--			config = function()
		--				vim.api.nvim_exec(
		--					[[
		--                "let g:ale_echo_msg_error_str = 'A'
		--                "let g:ale_echo_msg_warning_str = 'B'
		--                "let g:ale_echo_msg_hint_str = 'C'
		--                " I have some custom icons for errors and warnings but feel free to change them.
		--                "⚠
		--                let g:ale_sign_error = '✘'
		--                let g:ale_sign_warning = ''
		--                "let g:ale_sign_information = ''
		--                "let g:ale_sign_error = '●'
		--                "let g:ale_sign_warning = '.'
		--                "let g:ale_lint_on_enter = 0 "Don't lint on enter hope this speeds things up/prevents lag
		--                ]],
		--					false
		--				)
		--			end,
		--		})
		--		use("nathunsmitty/nvim-ale-diagnostic") --> PIPE LSP DIAGS TO ALE

		--NOTE: Treesitter
		use({
			'nvim-treesitter/nvim-treesitter',
			branch = '0.5-compat',
			--run = ":TSInstall all"
		})
		use('haringsrob/nvim_context_vt') --> Show treesitter context at end of functions etc
		use('nvim-treesitter/nvim-treesitter-refactor') --> smart renaming and highlight definitions and scope
		use('windwp/nvim-ts-autotag')
		--		config = function()
		--				vim.api.nvim_exec(
		-- [[au FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"]], -- auto close html tags etc
		--					false
		--				)
		--end,
		--	})
		use('nvim-treesitter/nvim-treesitter-textobjects') -- treesitter text objects
		-- mfussenegger/nvim-ts-hint-textobject
		-- romgrk/nvim-treesitter-context
		--[[ use {  -- This is rad, but stupid slow right now.
          "romgrk/nvim-treesitter-context",
          requires = "nvim-treesitter/nvim-treesitter",
          config = "enable = true"
        } ]]
		-- use "nvim-treesitter/nvim-treesitter-refactor"
		-- use {"nvim-treesitter/completion-treesitter", opt = true}
		-- use {
		--   "nvim-treesitter/playground",
		--   requires = "nvim-treesitter/nvim-treesitter"
		-- }

		-- NOTE: REPL
		use({
			-- OR https://github.com/hkupty/iron.nvim
			--> A REPL Plugin to start / manage REPL
			'axvr/zepl.vim',
			config = function()
				vim.api.nvim_exec(
					[[
            cnoreabbrev repl Repl
            ]],
					false
				)
			end,
		})

		-- NOTE: LANGUAGE SPECIFIC SPLUGINS
		use('mfussenegger/nvim-jdtls') --> Better jdtls setup than lspconfig
		-- use 'HallerPatrick/py_lsp.nvim' --> Better python setup than lspconfig
		-- browse JSON gennaro-tedesco/nvim-jqx
		-- better rust support (rust-analyzer) https://github.com/simrat39/rust-tools.nvim && https://github.com/shift-d/crates.nvim
		-- better YAML https://github.com/cuducos/yaml.nvim
		-- SQL https://github.com/tami5/sql.nvim
		-- REFACTORING https://github.com/ThePrimeagen/refactoring.nvim

		use('b3nj5m1n/kommentary') -- HIGHLY DOCUMENTED AND HACKABLE LUA BASED COMMENTING PLUGIN
		use('windwp/nvim-autopairs') -- compatible with COQ
		--LSP
		use('neovim/nvim-lspconfig') --> PREMADE LSPCONFIGS
		use('nanotee/nvim-lsp-basics') -->  Basic wrappers for LSP features
		use({ 'ray-x/navigator.lua', requires = { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' } })

		use('nvim-lua/lsp-status.nvim') --> Lsp statusline
		use('ray-x/lsp_signature.nvim') --> LSP SignatureInformation
		-- use 'jubnzv/virtual-types.nvim'--> A Neovim plugin that shows type annotations as virtual text
		-- use("Raimondi/delimitMate") --> Compatible with compe auto braces etc
		use('kosayoda/nvim-lightbulb') --> CODE ACTION LIGHTBULB
		use('sbdchd/neoformat') -- Code formatting plugin
		-- use 'ojroques/nvim-lspfuzzy'  --> USE FZF FOR LSP NAVIGATION [CODE ACTION NOT WORKING..]
		use({
			'RRethy/vim-illuminate', --> Highlight word under cursor
			config = function()
				vim.cmd([[ hi illuminatedWord guibg=#504648 guifg=none "cterm=grey gui=grey]])
				vim.cmd([[ hi illuminatedCurWord cterm=none gui=none]])
			end,
		})

		use('mizlan/iswap.nvim') --> Easily SWAP function variables using treesitter, USAGE: Run the command :ISwap when your cursor is in a location that is suitable for swapping around things.

		-- AUTO DETECT LANGUAGES IN NEW BUFFERS WITH NO FT SET
		use({
			'spywhere/detect-language.nvim',
			config = function()
				require('detect-language').setup({})
			end,
		})

		-- LSP INSTALLERS
		-- alexaandru/nvim-lspupdate OR kabouzeid/nvim-lspinstall

		-- DEBUGGING PLUGINS
		-- use 'Pocco81/DAPInstall.nvim' --> Install debugger automatically -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		-- https://github.com/mfussenegger/nvim-dap
		-- https://github.com/rcarriga/nvim-dap-ui
		-- https://github.com/theHamsta/nvim-dap-virtual-text

		-- use 'ygm2/rooter.nvim'
		--[[ use {
            -- set cwd automatically
            "airblade/vim-rooter",
            config = function()
                vim.cmd("let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']")
                vim.cmd("let g:rooter_silent_chdir = 1")
            end
        } ]]
		-- use 'skywind3000/vim-rt-format' --> Prettify current line on ENTER
		-- use 'michaelb/sniprun' --> RUN CODE SNIPPETS/BLOCKS
		-- https://github.com/jubnzv/mdeval.nvim - RUN CODE SNIPPETS IN MARKDOWN FILE

		use('sheerun/vim-polyglot')
		use({
			'jose-elias-alvarez/null-ls.nvim',
			config = function()
				require('null-ls').config({})
				require('lspconfig')['null-ls'].setup({})
			end,
			requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		})
		-- use { --> LANGUAGE FILES AND SYNTAX. SUPPOSED TO NOT SLOW VIM DOWN BASICALLY AT ALL SO WHY NOT RUN FOR NOW
		--[[ "sheerun/vim-polyglot", --> REMOVED FOR NOW BECAUSE THEY KEEP MESSING WITH SWAP FILES & DOING TOO MUCH
        opt = true,
        event = "VimEnter *",
        setup = function()
            vim.g.polyglot_disabled = {"helm"}
        end, ]]
		--[[ config = function()
            vim.g.javascript_plugin_jsdoc = 1
            vim.g.vim_markdown_new_list_item_indent = 2
        end
                } ]]
		-- alexaandru/nvim-lspupdate USE THIS TO AUTO INSTALL LSP SERVERS
		-- use  'glepnir/lspsaga.nvim'
		-- use { 'uiiaoo/java-syntax.vim' "5/12/20 Retiring For Treesitter
		-- use { 'rust-lang/rust.vim' "5/12/20 Retiring for treesitter
		-- use 'jbyuki/instant.nvim' --> Collaborative pair programming in NVIM

		--[[
    ______   __  __ _____ _______  __           ______    ____    _   __    ____     ____    _   __   ______
   / ____/  / / / //__  //__  /\ \/ /          / ____/   /  _/   / | / /   / __ \   /  _/   / | / /  / ____/
  / /_     / / / /   / /   / /  \  /          / /_       / /    /  |/ /   / / / /   / /    /  |/ /  / / __
 / __/    / /_/ /   / /__ / /__ / /          / __/     _/ /    / /|  /   / /_/ /  _/ /    / /|  /  / /_/ /
/_/       \____/   /____//____//_/          /_/       /___/   /_/ |_/   /_____/  /___/   /_/ |_/   \____/

--]]
--	-- https://github.com/ThePrimeagen/harpoon -- skip fuzzy finding, TODO: try out
		-- FUZZY WILD MENU ENHANCEMENT
		use('gelguy/wilder.nvim')
		-- FAST FUZZY SEARCH
		use({ 'camspiers/snap' })
		-- TELESCOPE
		use({
			'nvim-telescope/telescope.nvim',
			requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
		})
		use({
			'nvim-telescope/telescope-frecency.nvim',
			config = function()
				require('telescope').load_extension('frecency')
			end,
			requires = { 'tami5/sql.nvim' },
		})
		-- TELESCOPE Z INTEGRATION
		use({
			'nvim-telescope/telescope-z.nvim',
			requires = {
				{ 'nvim-lua/plenary.nvim' },
				{ 'nvim-lua/popup.nvim' },
				{ 'nvim-telescope/telescope.nvim' },
			},
			config = function()
				require('telescope').load_extension('z')
				-- ... other telescope settings
			end,
		})
		--use {
		--   "cljoly/telescope-repo.nvim",
		--    config = require "telescope".load_extension "repo"
		--}
		-- CHEATSHEETS
		use({
			'sudormrfbin/cheatsheet.nvim', --> Telescope Based Cheatsheet
			requires = {
				-- optional
				{ 'nvim-telescope/telescope.nvim' },
				{ 'nvim-lua/popup.nvim' },
				{ 'nvim-lua/plenary.nvim' },
			},
		})
		use('nvim-telescope/telescope-fzy-native.nvim')
		use('nvim-telescope/telescope-symbols.nvim')
		-- ROOT PATH .GIT ETC, ALSO A TELESCOPE EXTENSION TO DISPLAY PROJECTS PREVIOUSLY VISITED
		-- Telescope projects
		use({
			'ahmedkhalf/project.nvim',
			config = function()
				require('project_nvim').setup({})
				require('telescope').load_extension('projects')
			end,
		})

		-- Clipboard manager neovim plugin with telescope integration
		-- :Telescope neoclip
		use({
			'AckslD/nvim-neoclip.lua',
			config = function()
				require('neoclip').setup()
				require('telescope').load_extension('neoclip')
			end,
		})

--		-- FZF
--		use({
--			'junegunn/fzf',
--			-- run = function()
--			-- vim.fn["fzf#install"]()
--			-- end
--		})
--		use({ 'junegunn/fzf.vim' })
--		--FUZZY HELP MENU FOR FZF & VIM like ctrl+p
--		use({
--			'laher/fuzzymenu.vim',
--			config = function()
--				vim.api.nvim_exec(
--					[[
--                let g:fuzzymenu_position =  'window'
--                let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}
--                ]],
--					false
--				)
--			end,
--		})
		--[[
    ______    ____    __     ______           _   __    ___  _    __
   / ____/   /  _/   / /    / ____/          / | / /   /   || |  / /
  / /_       / /    / /    / __/            /  |/ /   / /| || | / /
 / __/     _/ /    / /___ / /___           / /|  /   / ___ || |/ /
/_/       /___/   /_____//_____/          /_/ |_/   /_/  |_||___/
   ___             _____    ______    ___     ____    ______    __  __
  ( _ )           / ___/   / ____/   /   |   / __ \  / ____/   / / / /
 / __ \/|         \__ \   / __/     / /| |  / /_/ / / /       / /_/ /
/ /_/  <         ___/ /  / /___    / ___ | / _, _/ / /___    / __  /
\____/\/        /____/  /_____/   /_/  |_|/_/ |_|  \____/   /_/ /_/

--]]
		use({ 'tpope/vim-eunuch' }) -- Allows us to do cool UNIX CLI stuff like :Rename, Delete, Move, Mkdir, Chmod
		use('lambdalisue/suda.vim') -- Neovim compatible :SudoWrite
		-- PREVIEW LINE IN BUFFER --> e.g :35 will show you line 35, without having to hit enter, close command pallette and you are back
		use({ 'nacro90/numb.nvim', config = "require('numb').setup()" })
		-- ENHANCED SEARCH --> Adds count numbers etc
		-- use({ "kevinhwang91/nvim-hlslens" })
		-- FILE TREE
		use({
			'kyazdani42/nvim-tree.lua',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		})
		use({
			'ggandor/lightspeed.nvim',
			config = function()
				require('lightspeed').setup({
					jump_to_first_match = true,
					jump_on_partial_input_safety_timeout = 400,
					-- This can get _really_ slow if the window has a lot of content,
					-- turn it on only if your machine can always cope with it.
					highlight_unique_chars = false,
					grey_out_search_area = false,
					match_only_the_start_of_same_char_seqs = true,
					limit_ft_matches = 5,
					full_inclusive_prefix_key = '<c-x>',
					-- By default, the values of these will be decided at runtime,
					-- based on `jump_to_first_match`.
					labels = nil,
					cycle_group_fwd_key = nil,
					cycle_group_bwd_key = nil,
				})
				vim.api.nvim_exec(
					[[
                    highlight LightspeedCursor guibg=#ffffff guifg=#000000
                    highlight LightspeedOneCharMatch guibg=#fb4934 guifg=#fbf1c7

                    ]],
					false
				)
			end,
		})
		-- VIM QUICKSCOPE --> after press t and f this highlights chars to help you nav faster
		--[[ use {
            "unblevable/quick-scope",
            setup = function()
                vim.api.nvim_exec( ]]
		-- [[
		--[[ highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
                    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
                    augroup qs_colors
                    autocmd!
                    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
                    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
                    augroup END ]]
		-- ]],
		--[[ false
                )
            end
        } ]]
		--[[
   ______    ____  ______           ____     __    __  __   ______    ____    _   __   _____
  / ____/   /  _/ /_  __/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
 / / __     / /    / /            / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
/ /_/ /   _/ /    / /            / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
\____/   /___/   /_/            /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]
		-- use 'beauwilliams/nvim-blamer.lua' --> MY CUSTOM GIT BLAME PLUGIN
		use({
			'APZelos/blamer.nvim',
			config = function()
				-- vim.g.blamer_prefix = ' > '
				vim.g.blamer_enabled = 1
				vim.g.blamer_template = '<committer> │ <summary> │ <committer-time>'
				vim.g.blamer_date_format = '%d/%m/%y'
			end,
		})
		use({
			'pwntester/octo.nvim',
			config = function()
				require('octo').setup() --Edit and review GitHub issues and pull requests from the comfort of your favorite editor
				-- :Octo issue, :Octo pr ...
			end,
		})
		use('mhinz/vim-signify') -- ASYNC GIT DIFF GUTTER, Diff view
		use({ 'rhysd/git-messenger.vim' }) -- leader-gb to GIT BLAME i.e who wrote that code commit info and navigate history at a glance
		use({ 'tpope/vim-fugitive' }) -- Adds 'native' git commands to vim. silent commands. e.g :Git add - won't prompt you to enter to confirm
		use({ 'sindrets/diffview.nvim' }) -- Neovim enhanced diffview [:DiffviewOpen]
		use('ThePrimeagen/git-worktree.nvim') -- Adds neovim integration with worktrees and telescope
		-- https://github.com/tanvirtin/vgit.nvim - visual git for neovim

		--[[
    __  ___    ____   _____   ______           ____     __    __  __   ______    ____    _   __   _____
   /  |/  /   /  _/  / ___/  / ____/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
  / /|_/ /    / /    \__ \  / /              / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
 / /  / /   _/ /    ___/ / / /___           / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
/_/  /_/   /___/   /____/  \____/          /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]
		use('michaelb/vim-tips') -- Display vim tip at startup
		use('sedm0784/vim-you-autocorrect') -- Vim autocorrection
		use('ojroques/nvim-bufdel') --> Better buffer deletion defaults
		use('tpope/vim-surround') -- all we need to remember is s, for surround. cs\" for ex OR ysiw' to surround current word with ''
		use('tpope/vim-repeat') -- repeat surround motions with .
		use('rmagatti/alternate-toggler') --:ToggleAlternate -- TOGGLE BOOLS
		use('monaqa/dial.nvim') -- BETTER INCREMENTING IN VIM (TO BE TESTED)
		use('chaoren/vim-wordmotion') --> IMPROVED VIM WORD MOTIONS, now includes under_scores and camelCase etc.
		use({ 'NTBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' } }) -- Open HTTP files - a curl wrapper
		use({ -- help suggestions for key mappings
			'folke/which-key.nvim',
			config = function()
				require('which-key').setup({})
			end,
		})
		use({
			'antoinemadec/FixCursorHold.nvim',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		})

		--[[
    ____     __    __  __   ______    ____    _   __   _____         ______    ______   _____  ______    ____    _   __   ______
   / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/        /_  __/   / ____/  / ___/ /_  __/   /  _/   / | / /  / ____/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \          / /     / __/     \__ \   / /      / /    /  |/ /  / / __
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /         / /     / /___    ___/ /  / /     _/ /    / /|  /  / /_/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/         /_/     /_____/   /____/  /_/     /___/   /_/ |_/   \____/
--]]
		--[[ use {
            's1n7ax/nvim-search-and-replace',
            setup = function() require'nvim-search-and-replace'.setup() end,
        } ]]
		use('nvim-lua/plenary.nvim')
		use('windwp/nvim-spectre')
		use('MunifTanjim/nui.nvim') -- NOTE: We need this as its a dependency of something..
		use('npxbr/glow.nvim') --> might ned to run :GlowInstall --> :mdreader to read md
		use('iamcco/markdown-preview.nvim') --> need to run :call mkdp#util#install()
		use('thugcee/nvim-map-to-lua')
		use('nanotee/zoxide.vim') -- :Z command in vim, quickly jump to recent dirs
		use({
			'vuki656/package-info.nvim',
			setup = require('package-info').setup(),
		})
		-- display last undos
		use({ 'mbbill/undotree', opt = true, cmd = { 'UndotreeToggle' } })
		-- display helpfiles
		--[[ use {
            "lvim-tech/lvim-helper",
            setup = function()
                local home = os.getenv('HOME')
                require('lvim-helper').setup({
                    files = {
                        "/"..home .. '/.config/nvim/helpfiles/treesitter.md',
                    }
                })
            end
        } ]]
		-- use 'abecodes/tabout.nvim' -- USAGE: <Tab> between objects such as {} [] etc
		-- use 'kevinhwang91/nvim-bqf' --> BETTER QF
		-- use 'danth/pathfinder.vim' --> SUGGEST BETTER normal mode commands to navigate vim! [not working]
		-- use 'oknozor/illumination' --> :Illuminate, :IlluminateClose [MARKDOWN RENDERERER]
		-- use 'drzel/vim-repo-edit' --> PREVIEW GIT REPO [:RepoEdit https://github.com/drzel/vim-repo-edit]
		-- use('andweeb/presence.nvim') -- discall mkdp#util#install()call mkdp#util#install()cord presence
		-- use {"lifepillar/vim-cheat40"} -- Adds configurable cheat sheet with <leader>? great for remembering my mappings and custom commands
		-- use { 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "A vim game
		-- use 'jiangmiao/auto-pairs' --> replaced with delimited mate, bettr with compe
		-- use "gennaro-tedesco/nvim-peekup" -- USAGE: "" to get list of registers

		-- LUA/VIM DEVELOPMENT
		-- bfredl/nvim-luadev Lua like REPL for nvim dev from the cheifman himself bfredl
		-- use 'notomo/lreload.nvim' --> Hot reloading for lua development
		-- use 'wadackel/nvim-syntax-info' Display highlight links etc using :SyntaxInfo

		--

		use({
			'vhyrro/neorg',
			config = function()
				require('neorg').setup({
					-- Tell Neorg what modules to load
					load = {
						['core.defaults'] = {}, -- Load all the default modules
						['core.keybinds'] = {
							-- Default keybinds <leader>o, g t(ask) d(one), un(done) p(ending) [gtd,gtu,gtp]
							config = {
								default_keybinds = true, -- Generate the default keybinds
								neorg_leader = '<Leader>o', -- This is the default if unspecified
							},
						},
						['core.norg.concealer'] = {}, -- Allows for use of icons
						['core.norg.dirman'] = {
							-- Manage your directories with Neorg
							config = {
								workspaces = {
									my_workspace = '~/Dropbox/Software Eng/Workspaces/Neorg',
								},
							},
						},
					},
				})
			end,
			requires = 'nvim-lua/plenary.nvim',
		})
	end, --> End of the packer(use) function
})
--[[
    ______    _   __    ____           ____     ______           ______    ____    __     ______
   / ____/   / | / /   / __ \         / __ \   / ____/          / ____/   /  _/   / /    / ____/
  / __/     /  |/ /   / / / /        / / / /  / /_             / /_       / /    / /    / __/
 / /___    / /|  /   / /_/ /        / /_/ /  / __/            / __/     _/ /    / /___ / /___
/_____/   /_/ |_/   /_____/         \____/  /_/              /_/       /___/   /_____//_____/
--]]
