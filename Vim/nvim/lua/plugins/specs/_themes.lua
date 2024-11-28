return {
	-- Automatically switch between light and dark themes
	{
		'f-person/auto-dark-mode.nvim',
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value('background', 'dark', {})
				vim.cmd('colorscheme flatbox')
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value('background', 'light', {})
				vim.cmd('colorscheme github_light')
			end,
		},
	},
	{
		'beauwilliams/flatbox',
		lazy = true, -- Only load when explicitly set
		config = function()
			vim.cmd('colorscheme flatbox')
		end,
	},

	-- GitHub theme (light)
	{
		'projekt0n/github-nvim-theme',
		lazy = true, -- Only load when explicitly set
		config = function()
			require('github-theme').setup({
				theme_style = 'light',
			})
		end,
	},

	-- Optional: Gruvbox themes
	--    {
	--        "gruvbox-community/gruvbox",
	--        lazy = true, -- Load on demand
	--        config = function()
	--            vim.cmd("colorscheme gruvbox")
	--        end,
	--    },
	--    {
	--        "sainnhe/gruvbox-material",
	--        lazy = true,
	--    },
	--    {
	--        "eddyekofo94/gruvbox-flat.nvim",
	--        lazy = true,
	--    },
	--
	--    -- Tokyonight theme
	--    {
	--        "ghifarit53/tokyonight-vim",
	--        lazy = true,
	--    },
	--
	--    -- Inspired GitHub theme
	--    {
	--        "mvpopuk/inspired-github.vim",
	--        lazy = true,
	--    },
	--
	--    -- Everforest theme
	--    {
	--        "sainnhe/everforest",
	--        lazy = true,
	--    },
	--
	--    -- Theme editor
	--    {
	--        "Djancyp/custom-theme.nvim",
	--        cmd = { "CustomTheme", "CustomThemeReset" }, -- Load only when these commands are used
	--        config = function()
	--            require("custom-theme").setup()
	--        end,
	--    },
}
