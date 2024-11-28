local cmd = vim.cmd
local nvim_lsp = vim.lsp.buf
local create_user_command = vim.api.nvim_create_user_command

local telescope = safe_require('telescope')
local telescope_builtin = safe_require('telescope.builtin')
local telescope_themes = safe_require('telescope.themes')

if not telescope or not telescope_builtin or not telescope_themes then
	return
end

------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTE: PICKERS / SEARCH COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------

function my_dropdown(opts)
	opts = opts or {}

	local theme_opts = {
		theme = 'dropdown',

		results_title = false,

		sorting_strategy = 'ascending',
		layout_strategy = 'center',
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
			prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
			results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
			preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		},
	}
	if opts.layout_config and opts.layout_config.prompt_position == 'bottom' then
		theme_opts.borderchars = {
			prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
			results = { '─', '│', '─', '│', '╭', '╮', '┤', '├' },
			preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		}
	end

	return vim.tbl_deep_extend('force', theme_opts, opts)
end

local telescope_file_search_opts = "hidden = true, find_command = {'rg', '--files', '--hidden', '--glob=!.git'}"
create_user_command('MySearchFiles', function()
	telescope_builtin.find_files(my_dropdown({ telescope_file_search_opts }))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for files',
})

create_user_command('MySearchFilesHistory', function()
	telescope_builtin.oldfiles(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for files in history',
})

create_user_command('MySearchGrep', function()
	telescope_builtin.live_grep(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for symbols using live grep',
})

create_user_command('MySearchBuffers', function()
	telescope_builtin.buffers(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for buffers',
})

create_user_command('MySearchCommands', function()
	telescope_builtin.commands(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for commands',
})

create_user_command('MySearchYankHistory', function()
	telescope.extensions.neoclip.default(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for yank history / clipboard',
})

create_user_command('MySearchGitFiles', function()
	telescope_builtin.oldfiles(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for git files',
})

create_user_command('MySearchGitBranches', function()
	telescope_builtin.git_branches(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for git branches',
})

create_user_command('MySearchProjects', function()
	telescope.extensions.projects.projects(my_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search for projects history',
})

create_user_command('MySearchDotfiles', function()
	require('telescope.builtin').find_files({
		prompt_title = '< VimRC >',
		-- find_command = { 'rg', '--files' },
		search_dirs = {
			vim.fn.stdpath('config'),
			'~/.config/zsh/scripts',
			'~/.config/zsh/commands/',
			'~/.config/zsh/configs/',
		},
	})
end, {
	bang = false,
	nargs = 0,
	desc = 'Search dotfiles nvim and zsh',
})

local root_path_plugins = vim.fn.stdpath('data') .. '/site/pack/packer/'
create_user_command('MySearchNvimPlugins', function()
	telescope_builtin.find_files(my_dropdown({
		cwd = vim.fn.stdpath('data') .. '/site/pack/packer/',
		search_dirs = { root_path_plugins .. 'start/', root_path_plugins .. 'opt/' },
	}))
end, {
	bang = false,
	nargs = 0,
	desc = 'Search nvim plugins directory',
})
