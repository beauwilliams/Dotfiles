--[[
    ____     ___    ______    __ __    ______    ____            ____    _   __    ____  ______
   / __ \   /   |  / ____/   / //_/   / ____/   / __ \          /  _/   / | / /   /  _/ /_  __/
  / /_/ /  / /| | / /       / ,<     / __/     / /_/ /          / /    /  |/ /    / /    / /
 / ____/  / ___ |/ /___    / /| |   / /___    / _, _/         _/ /    / /|  /   _/ /    / /
/_/      /_/  |_|\____/   /_/ |_|  /_____/   /_/ |_|         /___/   /_/ |_/   /___/   /_/

--]]
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
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

local packer = require('packer')
packer.init({
	--FIXES ISSUE WHERE WON'T UPDATE OTHERWISE
	max_jobs = 4,
	git = {
		clone_timeout = 300, -- 5 mins
	},
	profile = {
		enable = true,
	},
})

-- FOR LUAROCKS TO INSTALL RIGHT
-- vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '12')

vim.cmd('autocmd BufWritePost _plugins.lua PackerCompile') -- Auto compile when there are changes to plugins

--[[
    ____     __    __  __   ______    ____    _   __           ____    _   __    ____  ______   _____
   / __ \   / /   / / / /  / ____/   /  _/   / | / /          /  _/   / | / /   /  _/ /_  __/  / ___/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /           / /    /  |/ /    / /    / /     \__ \
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /          _/ /    / /|  /   _/ /    / /     ___/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/          /___/   /_/ |_/   /___/   /_/     /____/

]]

--PACKER IS CAPABLE OF MANAGING ITSELF. IT INITS FIRST THEN CALLS REST OF OUR PLUGINS
packer.startup({
	function(use)
		use({ 'wbthomason/packer.nvim', opt = true })

		-- NOTE: SPEED UP NVIM REQUIRE AND STARTUP TIME
		use({ 'lewis6991/impatient.nvim', rocks = 'mpack' })

		-- NOTE:  DEBUG STUFF
		-- https://github.com/henriquehbr/nvim-startup.lua

		--[[
  ______    __  __    ______    __  ___    ______   _____          ___             __  __    ____
 /_  __/   / / / /   / ____/   /  |/  /   / ____/  / ___/         ( _ )           / / / /   /  _/
  / /     / /_/ /   / __/     / /|_/ /   / __/     \__ \         / __ \/|        / / / /    / /
 / /     / __  /   / /___    / /  / /   / /___    ___/ /        / /_/  <        / /_/ /   _/ /
/_/     /_/ /_/   /_____/   /_/  /_/   /_____/   /____/         \____/\/        \____/   /___/

--]]
		-- NOTE: THEMES
		use('f-person/auto-dark-mode.nvim') --> AUTO dark / light mode switch between themes
		use({ 'beauwilliams/flatbox' }) --> dark
		use('projekt0n/github-nvim-theme') --> light
		-- use('gruvbox-community/gruvbox') --> best gruvbox theme
		-- use "sainnhe/gruvbox-material"
		--use 'eddyekofo94/gruvbox-flat.nvim'
		-- use 'ghifarit53/tokyonight-vim'
		-- use 'mvpopuk/inspired-github.vim'
		-- https://github.com/sainnhe/everforest

		-- NOTE: THEME EDITOR
		-- :CustomTheme (Will open all highlights to split windown)
		-- :CustomThemeReset (Will revert your changes how it was)
		--[[ use({
			'Djancyp/custom-theme.nvim',
			config = function()
				require('custom-theme').setup()
			end,
		}) ]]

		-- NOTE: UI PLUGINS
		use('folke/lsp-colors.nvim') -- Plugin that creates missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin LSP client.
		use({ 'stevearc/dressing.nvim' }) -- Neovim plugin to improve the default vim.ui interfaces
		-- use 'meznaric/conmenu' --replacing for hydra aug 2022
		use('anuvyklack/hydra.nvim')
		use({
			'folke/noice.nvim',
			event = 'VimEnter',
			config = function() end,
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				'MunifTanjim/nui.nvim',
				'rcarriga/nvim-notify',
			},
		})

		-- NOTE: STATUSLINE
		use({ 'beauwilliams/statusline.lua', requires = 'nvim-lua/lsp-status.nvim' })

		-- NOTE: TABLINE
		-- https://github.com/rafcamlet/tabline-framework.nvim
		-- use 'romgrk/barbar.nvim' --> better tab bars using my own happy with it tho
		-- "jose-elias-alvarez/buftabline.nvim",

		-- NOTE: NOTIFICATIONS
		use('rcarriga/nvim-notify') --plugins.nvim-notify.lua

		-- NOTE: COLOURED BRACES
		use('p00f/nvim-ts-rainbow') --> Treesitter compatible rainbow parentheses

		-- NOTE: INDENT LINES
		use({ 'lukas-reineke/indent-blankline.nvim', config = "vim.g.indent_blankline_char = '│'" })

		-- NOTE: HORIZONTAL LINES --> Looks bad.. Not working right
		-- 'lukas-reineke/headlines.nvim' --> This plugin adds highlights for text filetypes, like markdown, orgmode, and neorg

		-- NOTE: SPLITS + WINDOW MANAGEMENT
		-- Similar to focus = {'lvim-tech/lvim-focus', 'anuvyklack/windows.nvim'}
		use({
			'beauwilliams/focus.nvim',
			--cmd = { "FocusSplitNicely", "FocusSplitCycle" },
			--module = "focus",
			config = function()
				require('focus').setup({
					tmux = false,
					hybridnumber = true,
					excluded_filetypes = { 'fterm', 'term', 'toggleterm', 'startify' },
					signcolumn = 'number',
					absolutenumber = false,
					bufnew = true,
				})
			end,
		})

		-- NOTE: MEME
		-- use 'beauwilliams/imnotaquitter.nvim'

		-- NOTE:  SCROLL BARS
		use('dstein64/nvim-scrollview')

		--NOTE: MINIMAP / CODE WINDOW
		--[[ use({
			'gorbit99/codewindow.nvim',
			config = function()
				local codewindow = require('codewindow')
				codewindow.setup()
				codewindow.apply_default_keybinds()
			end,
		}) ]]

		-- NOTE:  STARIFY / SESSIONS
		use({
			'mhinz/vim-startify',
			requires = 'ryanoasis/vim-devicons',
		})
		-- Alternative lua version (not yet tested) https://github.com/rmagatti/auto-session
		-- or https://github.com/folke/persistence.nvim

		-- NOTE:  SMOOTH SCROLLING
		use('beauwilliams/sexy_scroller.vim')
		--[[ use({
			-- OR psliwka/vim-smoothie
			'karb94/neoscroll.nvim',
			setup = require('neoscroll').setup(),
			}) ]]
		--[[ use({
			'declancm/cinnamon.nvim',
			config = function()
				require('cinnamon').setup({
					-- KEYMAPS:
					default_keymaps = true, -- Create default keymaps.
					extra_keymaps = true, -- Create extra keymaps.
					extended_keymaps = false, -- Create extended keymaps.
					override_keymaps = false, -- The plugin keymaps will override any existing keymaps.
					-- OPTIONS:
					always_scroll = false, -- Scroll the cursor even when the window hasn't scrolled.
					centered = true, -- Keep cursor centered in window when using window scrolling.
					default_delay = 7, -- The default delay (in ms) between each line when scrolling.
					hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
					horizontal_scroll = true, -- Enable smooth horizontal scrolling when view shifts left or right.
					max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
					-- re-calculated. Setting to -1 will disable this option.
					scroll_limit = 150, -- Max number of lines moved before scrolling is skipped. Setting
					-- to -1 will disable this option.
				})
			end,
		}) ]]

		-- NOTE:  HEX COLOUR PREVIEW
		-- use({ 'rrethy/vim-hexokinase' }) --, run = "make hexokinase" }) -- preview hex colors with little square

		-- NOTE:  CURSOR FLASH --> helps orientate quicker switching windows etc cursorline flash when switch
		use({
			-- NOTE: TODO: try edluffy/specs.nvim
			'danilamihailov/beacon.nvim',
			config = function()
				vim.g.beacon_size = 20
				vim.g.beacon_minimal_jump = 25
				vim.g.beacon_shrink = 1
				vim.g.beacon_fade = 1
			end,
		})

		-- NOTE:  TERMINAL CALLBACKS
		use('kassio/neoterm')

		-- NOTE: FLOATING TERMINAL
		-- OR "voldikss/vim-floaterm"
		-- OR 'itmecho/neoterm.nvim',
		use({
			'numToStr/FTerm.nvim',
			config = function()
				require('FTerm').setup({
					border = 'single',
				})
			end,
		})

		--[[
  ______   ____    ____     __  _       __    ____    _   __    ____    ____  _       __
 /_  __/  / __ \  / __ \   / / | |     / /   /  _/   / | / /   / __ \  / __ \| |     / /
  / /    / / / / / / / /  / /  | | /| / /    / /    /  |/ /   / / / / / / / /| | /| / /
 / /    / /_/ / / /_/ /  / /___| |/ |/ /   _/ /    / /|  /   / /_/ / / /_/ / | |/ |/ /
/_/     \____/  \____/  /_____/|__/|__/   /___/   /_/ |_/   /_____/  \____/  |__/|__/

]]
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

		--[[
    ____     ____    ____    ______    ____     ___     __  ___    __  ___    ____    _   __   ______
   / __ \   / __ \  / __ \  / ____/   / __ \   /   |   /  |/  /   /  |/  /   /  _/   / | / /  / ____/
  / /_/ /  / /_/ / / / / / / / __    / /_/ /  / /| |  / /|_/ /   / /|_/ /    / /    /  |/ /  / / __
 / ____/  / _, _/ / /_/ / / /_/ /   / _, _/  / ___ | / /  / /   / /  / /   _/ /    / /|  /  / /_/ /
/_/      /_/ |_|  \____/  \____/   /_/ |_|  /_/  |_|/_/  /_/   /_/  /_/   /___/   /_/ |_/   \____/

--]]
		-- NOTE: PACKAGE MANAGER: LSP / LINTERS / FORMATTERS
		--[[ https://github.com/jayp0521/mason-null-ls.nvim
		https://github.com/williamboman/mason-lspconfig.nvim#configuration ]]
		use({ --> LSP, DAP etc installer
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		})
		use('WhoIsSethDaniel/mason-tool-installer.nvim') --> Auto install based on defined list with mason

		-- NOTE: LSP CONFIG
		use('neovim/nvim-lspconfig') --> PREMADE LSPCONFIGS
		use('ii14/lsp-command') -- USAGE: :h :Lsp
		use({
			'lewis6991/hover.nvim',
			config = function()
				require('hover').setup({
					init = function()
						-- require providers
						require('hover.providers.lsp')
						-- require('hover.providers.gh')
						require('hover.providers.man')
						require('hover.providers.dictionary')
					end,
					preview_opts = {
						border = 'rounded',
					},
					title = true,
				})

				-- setup keymaps
				vim.keymap.set('n', 'gk', require('hover').hover_select, { desc = 'hover.nvim (select)' })
			end,
		})

		-- use {'j-hui/fidget.nvim', setup = require"fidget".setup{}} -- LSP server status widget bottom right corner
		use({
			-- LSP UI Enhancements
			'glepnir/lspsaga.nvim',
			branch = 'main',
			config = function()
				local saga = require('lspsaga')

				saga.init_lsp_saga({
					border_style = 'rounded',
					code_action_keys = {
						quit = '<esc>',
						exec = '<CR>',
					},
					-- use emoji lightbulb in default
					code_action_icon = '',
					-- if true can press number to execute the codeaction in codeaction window
					code_action_num_shortcut = true,
					-- same as nvim-lightbulb but async
					code_action_lightbulb = {
						enable = false,
						enable_in_insert = true,
						cache_code_action = true,
						sign = true,
						update_time = 150,
						sign_priority = 20,
						virtual_text = true,
					},
					finder_action_keys = {
						open = 'o',
						vsplit = 's',
						split = 'i',
						tabe = 't',
						quit = '<esc>',
						scroll_down = '<C-f>',
						scroll_up = '<C-b>', -- quit can be a table
					},
					-- your configuration
				})
			end,
		})
		use({
			'weilbith/nvim-code-action-menu',
			cmd = 'CodeActionMenu',
		})
		use({
			-- LSP Diagnostic virtual lines
			'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
			config = function()
				require('lsp_lines').setup()
			end,
		})

		-- NOTE: LSP COMPLETIONS
		use({
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-cmdline',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-path',
				'dmitmel/cmp-cmdline-history',
				'hrsh7th/cmp-nvim-lsp-signature-help',
			},
		})
		-- use({ 'github/copilot.vim' }) -- Copilot is love. Copilot is life.
		use({
			'zbirenbaum/copilot.lua',
			event = { 'VimEnter' },
			config = function()
				vim.defer_fn(function()
					require('copilot').setup()
				end, 100)
			end,
		}) --> Copilot but a lua rewrite
		use({
			'zbirenbaum/copilot-cmp',
			after = { 'copilot.lua' },
			config = function()
				require('copilot_cmp').setup()
			end,
		}) --> Copilot for cmp

		use({
			'petertriho/cmp-git',
			requires = 'nvim-lua/plenary.nvim',
			config = function()
				require('cmp_git').setup()
			end,
		}) --> Git for cmp

		-- NOTE: Snippets
		use({ 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' } }) --> incl. snippets engine for cmp + friendly snippets library of snippets
		-- use("hrsh7th/vim-vsnip") --> FAST SNIPPETS FOR NVIM COMPATIBLE WITH COMPE
		-- use("Raimondi/delimitMate") --> Compatible with compe auto braces etc

		-- NOTE: Auto pairs
		use({ --> compatible with COQ, CMP, auto pairs ()[]'' etc
			'windwp/nvim-autopairs',
			config = function()
				require('nvim-autopairs').setup({})
			end,
		})

		-- NOTE: Commenting
		use('b3nj5m1n/kommentary') -- HIGHLY DOCUMENTED AND HACKABLE LUA BASED COMMENTING PLUGIN

		-- NOTE: Indenting
		use('Darazaki/indent-o-matic') --Faster than vim-sleuth. Detects indent based on file. No performance impact

		-- NOTE: FILETYPE SYNTAX
		use('sheerun/vim-polyglot')

		-- NOTE: CODE FORMATTING
		use('sbdchd/neoformat') -- Code formatting plugin
		use({
			-- Use code formatters with nvim lsp formatting
			'jose-elias-alvarez/null-ls.nvim',
			config = function() end,
			requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		})

		-- NOTE: Editor config
		-- use 'editorconfig/editorconfig-vim'

		-- NOTE: DOCUMENTATION
		--[[ use({
			-- OR.. nvim-treesitter/nvim-tree-docs
			-- OR.. https://github.com/danymat/neogen
      -- DOcumentation GEnerator, Must run :call doge#install() first time for now TODO: fix
			'kkoomen/vim-doge',
			run = 'vim.cmd("call doge#install()")',
		}) ]]

		-- NOTE: Code navigation / Symbol Tree
		use({ 'stevearc/aerial.nvim' })
		use('simrat39/symbols-outline.nvim')

		-- NOTE: Cheat sheets
		use('RishabhRD/popfix') -- cheat.sh integration for neovim in elegant way
		use('RishabhRD/nvim-cheat.sh')
		-- use('dbeniamine/cheat.sh-vim') --> E.G :Howin javascript open file || :Cheat! factory [takes &ft e.g lua/factory]

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

		-- NOTE: Highlight word under cursor
		use({
			'RRethy/vim-illuminate', --> Highlight word under cursor
			config = function()
				vim.cmd([[ hi illuminatedWord guibg=#4c4c44 guifg=none "cterm=grey gui=grey]])
				vim.cmd([[ hi illuminatedCurWord cterm=none gui=none]])
			end,
		})

		-- NOTE: Dim unused variables
		use({
			'Kasama/nvim-custom-diagnostic-highlight',
			config = function()
				require('nvim-custom-diagnostic-highlight').setup({})
			end,
		})
		--[[ use({ --> better version of dim.lua --> https://github.com/zbirenbaum/neodim
			'narutoxy/dim.lua',
			requires = { 'nvim-treesitter/nvim-treesitter', 'neovim/nvim-lspconfig' },
			config = function()
				require('dim').setup()
			end,
		}) ]]

		-- NOTE: NVIM LSP PLUGINS
		use('nanotee/nvim-lsp-basics') -->  Adds :LspRename commands etc
		use('kosayoda/nvim-lightbulb') --> CODE ACTION LIGHTBULB
		use('rmagatti/goto-preview') --> Go to definition preview in popup

		-- NOTE: LANGUAGE SPECIFIC SPLUGINS
		--Java
		use('mfussenegger/nvim-jdtls') --> Better jdtls setup than lspconfig
		--Javascript
		use('jose-elias-alvarez/typescript.nvim')
		use({ --view, install, manage npm modules from package.json
			'vuki656/package-info.nvim',
			setup = require('package-info').setup(),
		})
		use({
			'axelvc/template-string.nvim', --> autocompletes 'foo ${|}  to  `foo ${}|` for JS/TS
			config = function()
				require('template-string').setup({
					filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
					jsx_brackets = true, -- must add brackets to jsx attributes
					remove_template_string = false, -- remove backticks when there are no template string
					restore_quotes = {
						-- quotes used when "remove_template_string" option is enabled
						normal = [[']],
						jsx = [["]],
					},
				})
			end,
		}) --> autocompletes 'foo ${|}  to  `foo ${}|` for JS/TS'})

		-- browse JSON gennaro-tedesco/nvim-jqx
		--Python
		-- use 'HallerPatrick/py_lsp.nvim' --> Better python setup than lspconfig
		-- better rust support (rust-analyzer) https://github.com/simrat39/rust-tools.nvim && https://github.com/shift-d/crates.nvim
		-- better YAML https://github.com/cuducos/yaml.nvim
		-- SQL https://github.com/tami5/sql.nvim
		-- REFACTORING https://github.com/ThePrimeagen/refactoring.nvim

		-- NOTE:  DEBUGGING PLUGINS
		-- use 'Pocco81/DAPInstall.nvim' --> Install debugger automatically -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		-- https://github.com/mfussenegger/nvim-dap
		-- https://github.com/rcarriga/nvim-dap-ui
		-- https://github.com/theHamsta/nvim-dap-virtual-text

		-- NOTE: Pair Programming
		-- use 'jbyuki/instant.nvim' --> Collaborative pair programming in NVIM

		-- NOTE: Documentation search
		--    use({
		--'mrjones2014/dash.nvim',
		--run = 'make install',
		--})
		-- NOTE: Search and replace (grep)
		use('windwp/nvim-spectre') --> favourite
		-- minimal s&r --> s1n7ax/nvim-search-and-replace

		-- NOTE: CODE TESTING PLUGINS
		-- use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }
		--neotest
		-- NOTE: CODE TEST COVERAGE DISPLAY
		-- use 'andythigpen/nvim-coverage'

		-- NOTE: BUILD SYSTEM PLUGINS
		-- use {
		--'pianocomposer321/yabs.nvim',
		--requires = { 'nvim-lua/plenary.nvim' }
		--}
		-- TODO: Review
		-- use 'skywind3000/vim-rt-format' --> Prettify current line on ENTER
		-- use 'michaelb/sniprun' --> RUN CODE SNIPPETS/BLOCKS
		-- https://github.com/jubnzv/mdeval.nvim - RUN CODE SNIPPETS IN MARKDOWN FILE
		-- use('ray-x/lsp_signature.nvim') --> LSP SignatureInformation
		-- use 'jubnzv/virtual-types.nvim'--> A Neovim plugin that shows type annotations as virtual text
		-- use 'ojroques/nvim-lspfuzzy'  --> USE FZF FOR LSP NAVIGATION [CODE ACTION NOT WORKING..]

		--[[
  ______    ____     ______    ______   _____    ____  ______  ______    ______    ____
 /_  __/   / __ \   / ____/   / ____/  / ___/   /  _/ /_  __/ /_  __/   / ____/   / __ \
  / /     / /_/ /  / __/     / __/     \__ \    / /    / /     / /     / __/     / /_/ /
 / /     / _, _/  / /___    / /___    ___/ /  _/ /    / /     / /     / /___    / _, _/
/_/     /_/ |_|  /_____/   /_____/   /____/  /___/   /_/     /_/     /_____/   /_/ |_|

 ]]
		use({
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
		})
		use('nvim-treesitter/playground')
		use('haringsrob/nvim_context_vt') --> Show treesitter context at end of functions etc
		use('nvim-treesitter/nvim-treesitter-refactor') --> smart renaming and highlight definitions and scope
		use('windwp/nvim-ts-autotag') --> Use treesitter to autoclose and autorename html tag
		use('nvim-treesitter/nvim-treesitter-textobjects') -- treesitter text objects
		use({
			'm-demare/hlargs.nvim',
			config = function()
				require('hlargs').setup()
			end,
		})
		-- use 'David-Kunz/markid' --A Neovim extension to highlight same-name identifiers with the same color NOTE: bit disorienting...
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
		-- use 'David-Kunz/treesitter-unit' -- use iu au to select units of code
		-- use('mizlan/iswap.nvim') --> Easily SWAP function variables using treesitter, USAGE: Run the command :ISwap when your cursor is in a location that is suitable for swapping around things. ]]

		--[[
    ______   __  __ _____ _______  __           ______    ____    _   __    ____     ____    _   __   ______
   / ____/  / / / //__  //__  /\ \/ /          / ____/   /  _/   / | / /   / __ \   /  _/   / | / /  / ____/
  / /_     / / / /   / /   / /  \  /          / /_       / /    /  |/ /   / / / /   / /    /  |/ /  / / __
 / __/    / /_/ /   / /__ / /__ / /          / __/     _/ /    / /|  /   / /_/ /  _/ /    / /|  /  / /_/ /
/_/       \____/   /____//____//_/          /_/       /___/   /_/ |_/   /_____/  /___/   /_/ |_/   \____/

]]
		--	-- https://github.com/ThePrimeagen/harpoon -- skip fuzzy finding, TODO: try out
		-- NOTE:  FUZZY WILD MENU ENHANCEMENT
		-- use('gelguy/wilder.nvim')

		-- NOTE:  FAST FUZZY SEARCH
		-- use({ 'camspiers/snap' })
		-- NOTE:  TELESCOPE
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
		-- NOTE:  TELESCOPE Z INTEGRATION
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
		-- NOTE:  CHEATSHEETS
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
		-- NOTE:  Telescope projects
		-- ROOT PATH .GIT ETC, ALSO A TELESCOPE EXTENSION TO DISPLAY PROJECTS PREVIOUSLY VISITED
		use({
			'ahmedkhalf/project.nvim',
			config = function()
				require('project_nvim').setup({})
				require('telescope').load_extension('projects')
			end,
		})

		-- NOTE:  Clipboard manager neovim plugin with telescope integration
		-- :Telescope neoclip
		use({
			'AckslD/nvim-neoclip.lua',
			config = function()
				require('neoclip').setup({
					default_register = '*',
				})
				require('telescope').load_extension('neoclip')
			end,
		})

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

]]
		-- Allows us to do cool UNIX CLI stuff like :Rename, Delete, Move, Mkdir, Chmod
		use({ 'tpope/vim-eunuch' })
		-- PREVIEW LINE IN BUFFER --> e.g :35 will show you line 35, without having to hit enter, close command palette and you are back
		use({ 'nacro90/numb.nvim', config = "require('numb').setup()" })
		-- ENHANCED SEARCH --> Adds count numbers etc
		-- use({ "kevinhwang91/nvim-hlslens" })
		-- FILE TREE
		use({
			'kyazdani42/nvim-tree.lua',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			cmd = 'NvimTreeToggle',
			config = function()
				require('nvim-tree').setup(require('plugins._nvimtree'))
			end,
		})

		--[[
   ______    ____  ______           ____     __    __  __   ______    ____    _   __   _____
  / ____/   /  _/ /_  __/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
 / / __     / /    / /            / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
/ /_/ /   _/ /    / /            / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
\____/   /___/   /_/            /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
]]
		use({ 'tpope/vim-fugitive' }) -- Adds 'native' git commands to vim. silent commands. e.g :Git add - won't prompt you to enter to confirm
		use('mhinz/vim-signify') -- ASYNC GIT DIFF GUTTER, Diff view
		use({ 'sindrets/diffview.nvim' }) -- Neovim enhanced diffview [:DiffviewOpen] (better than signify)
		-- GIT INTEGRATION / DASHBOARD
		use({
			-- or use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' } -- or tanvirtin/vgit.nvim
			'kdheepak/lazygit.nvim',
			config = function()
				require('telescope').load_extension('lazygit')
			end,
		})

		use({
			'braxtons12/blame_line.nvim',
			config = function()
				require('blame_line').setup({
					show_in_visual = false,
					show_in_insert = false,
					prefix = ' ⇢ ', -- ⟶  ⇢  ⤏  ⬸  ⤑  ➠ ⟹  ⟿
					-- String specifying the the blame line format.
					-- Any combination of the following specifiers, along with any additional text.
					--     - `"<author>"` - the author of the change.
					--     - `"<author-mail>"` - the email of the author.
					--     - `"<author-time>"` - the time the author made the change.
					--     - `"<committer>"` - the person who committed the change to the repository.
					--     - `"<committer-mail>"` - the email of the committer.
					--     - `"<committer-time>"` - the time the change was committed to the repository.
					--     - `"<summary>"` - the commit summary/message.
					--     - `"<commit-short>"` - short portion of the commit hash.
					--     - `"<commit-long>"` - the full commit hash.
					template = '<author> · <summary> · <author-time>',
					date = {
						-- whether the date should be relative instead of precise
						-- (I.E. "3 days ago" instead of "09-06-2022".
						relative = true,
						-- `strftime` compatible format string.
						-- Only used if `date.relative == false`
						format = '%d-%m-%y',
					},

					-- The highlight of this group defaults to `Comment`.
					-- hl_group = "BlameLineNvim",
					delay = 2000, --debounce
				})
			end,
		})
		--[[ use({
			'f-person/git-blame.nvim',
			config = function()
				vim.g.gitblame_enabled = 1
				vim.g.gitblame_date_format = '%r' --relative date i.e 3 days ago
				vim.g.blamer_template = '<committer> │ <summary> │ <committer-time>'
			end,
		}) ]]
		--[[ use(
                {
                    "beauwilliams/blamer.nvim",
                    branch = "patch-1",
                    config = function()
                        -- vim.g.blamer_prefix = ' > '
                        vim.g.blamer_enabled = 1
                        vim.g.blamer_template = "<committer> │ <summary> │ <committer-time>"
                        vim.g.blamer_date_format = "%d/%m/%y"
                    end
                }
            ) ]]
		use({
			'pwntester/octo.nvim',
			config = function()
				require('octo').setup() --Edit and review GitHub issues and pull requests from the comfort of your favorite editor
				-- :Octo issue, :Octo pr ...
			end,
		})
		use('ThePrimeagen/git-worktree.nvim') -- Adds neovim integration with worktrees and telescope
		--[[ use({
			'rhysd/git-messenger.vim', -- :GitMessenger
			setup = function()
				vim.g.git_messenger_no_default_mappings = true
			end,
		}) ]]
		--[[
    __  ___   ____   ______    ____   ____     _   __   _____
   /  |/  /  / __ \ /_  __/   /  _/  / __ \   / | / /  / ___/
  / /|_/ /  / / / /  / /      / /   / / / /  /  |/ /   \__ \
 / /  / /  / /_/ /  / /     _/ /   / /_/ /  / /|  /   ___/ /
/_/  /_/   \____/  /_/     /___/   \____/  /_/ |_/   /____/
]]
		use('tpope/vim-repeat') -- repeat surround + more motions with .
		use('tpope/vim-surround') -- all we need to remember is s, for surround. cs\" for ex OR ysiw' to surround current word with ''
		use('chaoren/vim-wordmotion') --> IMPROVED VIM WORD MOTIONS, now includes under_scores and camelCase etc.
		use('monaqa/dial.nvim') -- BETTER INCREMENTING IN VIM, bools, nums, dates, and/or etc
		-- use('rmagatti/alternate-toggler') --:ToggleAlternate -- TOGGLE BOOLS, NO LONGER NEEDED DIAL DOES IT ALL

		use({ --> altrenative --> https://github.com/linty-org/key-menu.nvim
			-- help suggestions for key mappings
			'folke/which-key.nvim',
			config = function()
				require('plugins._which-key')
			end,
		})
		--Motions f/F (auto-highlight
		-- use 'jinh0/eyeliner.nvim'
		-- VIM MOTION PLUGIN, s, S, f, F, t, T
		-- OR phaazon/hop.nvim OR quickscope.nvim
		use({
			'ggandor/leap.nvim',
			requires = {
				{ 'ggandor/flit.nvim' },
			},
			config = function()
				require('leap').add_default_mappings()
				require('flit').setup({})
			end,
		})
		--		use({
		--			'ggandor/lightspeed.nvim',
		--			config = function()
		--				require('lightspeed').setup({
		--					jump_to_unique_chars = true,
		--					repeat_ft_with_target_char = true,
		--					match_only_the_start_of_same_char_seqs = true,
		--					limit_ft_matches = 5,
		--					-- By default, the values of these will be decided at runtime,
		--					-- based on `jump_to_first_match`.
		--					-- labels = nil,
		--				})
		--				vim.api.nvim_exec(
		--					[[
		--                    highlight LightspeedCursor guibg=#ffffff guifg=#000000
		--                    highlight LightspeedOneCharMatch guibg=#fb4934 guifg=#fbf1c7
		--
		--                    ]],
		--					false
		--				)
		--			end,
		--		})

		--[[
    __  ___    ____   _____   ______           ____     __    __  __   ______    ____    _   __   _____
   /  |/  /   /  _/  / ___/  / ____/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
  / /|_/ /    / /    \__ \  / /              / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
 / /  / /   _/ /    ___/ / / /___           / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
/_/  /_/   /___/   /____/  \____/          /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]
		use('michaelb/vim-tips') -- Display vim tip at startup
		use('sedm0784/vim-you-autocorrect') -- Vim autocorrection
		use({ 'NTBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' } }) -- Open HTTP files - a curl wrapper
		use('andweeb/presence.nvim') -- discord presence

		--[[
    ______    ____   _  __    ______   _____          ___              ____     ______    ____     ______
   / ____/   /  _/  | |/ /   / ____/  / ___/         ( _ )            / __ \   / ____/   / __ \   / ____/
  / /_       / /    |   /   / __/     \__ \         / __ \/|         / /_/ /  / __/     / /_/ /  / /_
 / __/     _/ /    /   |   / /___    ___/ /        / /_/  <         / ____/  / /___    / _, _/  / __/
/_/       /___/   /_/|_|  /_____/   /____/         \____/\/        /_/      /_____/   /_/ |_|  /_/
 ]]

		--STARTUP ANALYSIS
		-- use('tweekmonster/startuptime.vim')

		use({
			'antoinemadec/FixCursorHold.nvim',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		})

		-- filetype.nvim fixes the issue by only creating a single autocommand that
		-- resolves the filetype when a buffer is opened. This method is ~175x faster*!
		use({
			'nathom/filetype.nvim',
			setup = function()
				vim.g.did_load_filetypes = 1 --disable loading normal filetypes
			end,
		})
		-- AUTO DETECT LANGUAGES IN NEW BUFFERS WITH NO FT SET
		use({
			'spywhere/detect-language.nvim',
			config = function()
				require('detect-language').setup({})
			end,
		})

		--[[
    ____     __    __  __   ______    ____    _   __   _____         ______    ______   _____  ______    ____    _   __   ______
   / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/        /_  __/   / ____/  / ___/ /_  __/   /  _/   / | / /  / ____/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \          / /     / __/     \__ \   / /      / /    /  |/ /  / / __
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /         / /     / /___    ___/ /  / /     _/ /    / /|  /  / /_/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/         /_/     /_____/   /____/  /_/     /___/   /_/ |_/   \____/
--]]
		-- display last undos
		use('simnalamburt/vim-mundo') --> Vim undo tree
		use({ 'mbbill/undotree', opt = true, cmd = { 'UndotreeToggle' } })

		--Enable autowrite mode for markdown live editor
		use('beauwilliams/AutoWrite.vim')

		--inc search box ui, making search more pretty
		use({
			'VonHeikemen/searchbox.nvim',
			requires = {
				{ 'MunifTanjim/nui.nvim' },
			},
		})

		--Make pretty code snippets jpg
		use({
			'narutoxy/silicon.lua',
			requires = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('silicon').setup({})
			end,
		})
		--cmd line in center of display
		--[[ use({
			'VonHeikemen/fine-cmdline.nvim',
			requires = {
				{ 'MunifTanjim/nui.nvim' },
			},
		}) ]]
		--color column virtual text
		--[[ use {"lukas-reineke/virt-column.nvim",
			setup = function()
				require("virt-column").setup()
			end
		} ]]
		use('npxbr/glow.nvim') --> might need to run :GlowInstall --> :mdreader to read md
		use('iamcco/markdown-preview.nvim') --> need to run :call mkdp#util#install()
		use('thugcee/nvim-map-to-lua')
		use('nanotee/zoxide.vim') -- :Z command in vim, quickly jump to recent dirs
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
		-- use('ojroques/nvim-bufdel') --> Unhanced :BufDel commands
		-- use 'abecodes/tabout.nvim' -- USAGE: <Tab> between objects such as {} [] etc
		-- use 'kevinhwang91/nvim-bqf' --> BETTER QF
		-- use 'danth/pathfinder.vim' --> SUGGEST BETTER normal mode commands to navigate vim! [not working]
		-- use 'oknozor/illumination' --> :Illuminate, :IlluminateClose [MARKDOWN RENDERERER]
		-- use 'drzel/vim-repo-edit' --> PREVIEW GIT REPO [:RepoEdit https://github.com/drzel/vim-repo-edit]
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
			'nvim-neorg/neorg',
			tag = '0.0.12', -- nvim 0.7.2 fix https://github.com/nvim-neorg/neorg/issues/559
			config = function()
				require('neorg').setup({
					ft = 'norg',
					after = { 'nvim-treesitter', 'telescope' }, -- You may want to specify Telescope here as well
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

		---------
	end, --> End of the packer(use) function
})
---------

--[[
    ___     ____    ______    __  __    ____ _    __    ______
   /   |   / __ \  / ____/   / / / /   /  _/| |  / /   / ____/
  / /| |  / /_/ / / /       / /_/ /    / /  | | / /   / __/
 / ___ | / _, _/ / /___    / __  /   _/ /   | |/ /   / /___
/_/  |_|/_/ |_|  \____/   /_/ /_/   /___/   |___/   /_____/
 ]]

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

-- use 'ygm2/rooter.nvim'
--[[ use {
            -- set cwd automatically
            "airblade/vim-rooter",
            config = function()
                vim.cmd("let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']")
                vim.cmd("let g:rooter_silent_chdir = 1")
            end
        } ]]

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

--[[
    ______    _   __    ____           ____     ______           ______    ____    __     ______
   / ____/   / | / /   / __ \         / __ \   / ____/          / ____/   /  _/   / /    / ____/
  / __/     /  |/ /   / / / /        / / / /  / /_             / /_       / /    / /    / __/
 / /___    / /|  /   / /_/ /        / /_/ /  / __/            / __/     _/ /    / /___ / /___
/_____/   /_/ |_/   /_____/         \____/  /_/              /_/       /___/   /_____//_____/
--]]
