return {
	-- NOTE: INDENT LINES
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		---@module "ibl"
		---@type ibl.config
		opts = {
			--use_treesitter = true,       -- Enable Treesitter integration
			--show_first_indent_level = false,  -- Hide the first indent level
			--show_trailing_blankline_indent = false -- Hide trailing blankline indent
		},
		config = function()
			local opts = {
				indent = { char = '│', smart_indent_cap = true },
				scope = { enabled = true }, -- Enable scope, which requires Treesitter
			}

			require('ibl').setup(opts)

			-- Hooks for additional customization
			local hooks = require('ibl.hooks')

			-- Hide the first indent level for both space and tab indentation
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

			-- NOTE: Hiding trailing blankline indent would require custom hook logic
			--       that is not directly provided in the sources.
			--       You might need to explore and experiment with hooks further
			--       to achieve this specific behavior.
		end,
	},
}
