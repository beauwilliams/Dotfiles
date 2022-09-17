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
		layout_strategy = "vertical",
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
			}
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

local M = {}

M.git_branches = function()
	require('telescope.builtin').git_branches({
		attach_mappings = function(prompt_bufnr, map)
			map('i', '<c-d>', actions.git_delete_branch)
			map('n', 'dd', actions.git_delete_branch)
			return true
		end,
	})
end


M.installed_plugins = function()
	require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
		-- winblend = 5,
		border = true,
		cwd = vim.fn.stdpath('data') .. '/site/pack/packer/start/',
	}))
end


function M.my_dropdown(opts)
  opts = opts or {}

  local theme_opts = {
    theme = "dropdown",

    results_title = false,

    sorting_strategy = "ascending",
    layout_strategy = "center",
    layout_config = {
      preview_cutoff = 1, -- Preview should always show (unless previewer = false)

      width = function(_, max_columns, _)
        return math.min(max_columns, 100)
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines, 20)
      end,
    },

    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  }
  if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
    theme_opts.borderchars = {
      prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    }
  end

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

return M
