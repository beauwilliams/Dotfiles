return {

	{ 'sheerun/vim-polyglot' }, -- NOTE: FILETYPE SYNTAX
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		lazy = false, -- main branch does not support lazy-loading
		build = ':TSUpdate',
		config = function()
			local ts = require('nvim-treesitter')
			ts.setup({})

			ts.install({
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
				'tsx',
				'typescript',
				'regex',
				'markdown',
				'markdown_inline',
				'vim',
				'vimdoc',
				'query',
			})

			vim.api.nvim_create_autocmd('FileType', {
				pattern = '*',
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang then
						return
					end
					if pcall(vim.treesitter.start, args.buf, lang) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			vim.api.nvim_create_autocmd('BufEnter', {
				pattern = '*',
				callback = function()
					require('hlargs').setup({ color = '#83a598' })
				end,
			})
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

	-- Autoclose and autorename HTML tags using Treesitter
	{
		'windwp/nvim-ts-autotag',
		event = 'InsertEnter',
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},

	-- Treesitter text objects for better text navigation and manipulation
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = 'main',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = 'BufReadPost',
		config = function()
			require('nvim-treesitter-textobjects').setup({
				select = { lookahead = true },
			})

			local select = require('nvim-treesitter-textobjects.select')
			local keymaps = {
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
			}
			for lhs, query in pairs(keymaps) do
				vim.keymap.set({ 'x', 'o' }, lhs, function()
					select.select_textobject(query, 'textobjects')
				end, { desc = 'Select ' .. query })
			end
		end,
	},

	-- Highlight arguments in function calls
	{
		'm-demare/hlargs.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = 'BufReadPost',
		config = function()
			require('hlargs').setup({
				color = '#83a598', -- Customize highlight color
			})
		end,
	},

}
