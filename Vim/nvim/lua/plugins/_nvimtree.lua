-- local utils = require "libraries._utils"
local g = vim.g
local exec = vim.api.nvim_exec

g.nvim_tree_side = 'left'
g.nvim_tree_width = 35

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
-- g.nvim_tree_auto_open = 1
g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.

-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_git_hl = 1

-- Updates nvimtree to current cwd always, and the cwd of buffer
-- g.nvim_tree_update_cwd = 1
g.nvim_tree_respect_buf_cwd = 1

--TODO:
exec([[highlight NvimTreeFolderName ctermfg=none guifg=none]], '')
exec([[highlight NvimTreeRootFolder guifg = #fb4934]], '')
exec([[highlight NvimTreeEmptyFolderName guifg = #7c6f64]], '')
exec([[highlight NvimTreeOpenedFolderName guifg = #ebdbb2]], '')
exec([[highlight NvimTreeExecFile guifg = #ebdbb2]], '')
exec([[highlight NvimTreeIndentMarker guifg = #928374]], '')
exec([[highlight NvimTreeFolderIcon guifg = #928374]], '')

-- "Setting nvim tree folders to not have any guibg
-- "hi Cursorline guibg=#424040 guifg=none

g.nvim_tree_icons = {
	default = '',
	-- symlink = '',
	git = {
		unstaged = 'M',
		staged = 'A',
		unmerged = '═',
		renamed = 'R',
		untracked = 'U',
	},
	folder = {
		default = '',
		open = '',
	},
}

-- 0 by default, this option shows indent markers when folders are open
-- g.nvim_tree_indent_markers = 1

-- 0 by default, this option hides files and folders starting with a dot `.`
-- g.nvim_tree_hide_dotfiles = 1

-- This is the default. See :help filename-modifiers for more options
-- g.nvim_tree_root_folder_modifier = ':~'

-- 0 by default, will open the tree when entering a new tab and the tree was previously open
-- g.nvim_tree_tab_open = 1
--

exec(
	[[
        augroup NvimTreeOverride
          au!
          au FileType NvimTree setlocal nowrap
        augroup END
    ]],
	''
)

------ NEW SETUP ---------

local M = {
	-- disables netrw completely
	disable_netrw = true,
	-- hijack netrw window on startup
	hijack_netrw = true,
	-- open the tree when running this setup function
	open_on_setup = false,
	-- will not open on setup if the filetype is in this list
	ignore_ft_on_setup = { '.git', 'node_modules' },
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close = true,
	-- false by default, opens the tree when typing `vim $DIR` or `vim`
	auto_open = true,
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab = false,
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = true,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd = true,
	-- show lsp diagnostics in the signcolumn
	-- lsp_diagnostics = false,
	-- false by default, this option allows the cursor to be updated when entering a buffer
	nvim_tree_follow = true,
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable = false,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd = false,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {},
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = nil,
		-- the command arguments as a list
		args = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		-- width of the window, can be either a number (columns) or a string in `%`
		width = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = 'left',
		-- if true the tree will resize itself after opening a file
		auto_resize = false,
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = false,
			-- list of mappings to set on the tree manually
			list = {},
		},
	},
}

return M
