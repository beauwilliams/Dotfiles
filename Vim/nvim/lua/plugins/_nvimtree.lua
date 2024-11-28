-- local utils = require "libraries._utils"
local g = vim.g
local exec = vim.api.nvim_exec

local nvimtree = safe_require('nvim-tree')
if not nvimtree then
	return
end

-- g.nvim_tree_side = "left"
-- g.nvim_tree_width = 35

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
-- g.nvim_tree_auto_open = 1
g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.

-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
-- g.nvim_tree_git_hl = 1

-- Updates nvimtree to current cwd always, and the cwd of buffer
-- g.nvim_tree_update_cwd = 1
-- g.nvim_tree_respect_buf_cwd = 1

--TODO:
--exec([[highlight NvimTreeFolderName ctermfg=none guifg=none]], "")
--exec([[highlight NvimTreeRootFolder guifg = #fb4934]], "")
--exec([[highlight NvimTreeEmptyFolderName guifg = #7c6f64]], "")
--exec([[highlight NvimTreeOpenedFolderName guifg = #ebdbb2]], "")
--exec([[highlight NvimTreeExecFile guifg = #ebdbb2]], "")
--exec([[highlight NvimTreeIndentMarker guifg = #928374]], "")
--exec([[highlight NvimTreeFolderIcon guifg = #928374]], "")

-- "Setting nvim tree folders to not have any guibg
-- "hi Cursorline guibg=#424040 guifg=none
-- llowing options were moved to setup, see bit.ly/3vIpEOJ: nvim_tree_icons, nvim_tree_git_hl, nvim_tree_respect_buf_cwd
--[[ g.nvim_tree_icons = {
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
} ]]
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

-- exec("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif", "")
local M = {
	auto_reload_on_write = true,
	reload_on_bufenter = true,
	-- disables netrw completely
	disable_netrw = true,
	-- hijack netrw window on startup
	hijack_netrw = true,
	-- open the tree when running this setup function
	open_on_setup = false,
	-- will not open on setup if the filetype is in this list
    --0.1 DEP
	--ignore_ft_on_setup = { '.git', 'node_modules' },
	-- false by default, opens the tree when typing `vim $DIR` or `vim`
	-- auto_open = true, NOTE: removed
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab = false,
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = true,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd = true,
	-- show lsp diagnostics in the signcolumn
	-- lsp_diagnostics = false,
	-- false by default, this option allows the cursor to be updated when entering a buffer
	-- nvim_tree_follow = true, NOTE: removed
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
		adaptive_size = true,
		-- width of the window, can be either a number (columns) or a string in `%`
		width = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = 'left',
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = false,
			-- list of mappings to set on the tree manually
			list = {},
		},
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = false,
		full_name = false,
		highlight_opened_files = 'none',
		root_folder_modifier = ':~',
		indent_markers = {
			enable = true,
			icons = {
				corner = '└',
				edge = '│',
				item = '│',
				none = ' ',
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = 'before',
			padding = ' ',
			symlink_arrow = ' ➛ ',
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = '',
				symlink = '',
				bookmark = '',
				folder = {
					arrow_closed = '',
					arrow_open = '',
					default = '',
					open = '',
					empty = '',
					empty_open = '',
					symlink = '',
					symlink_open = '',
				},
				git = {
					unstaged = 'M',
					staged = 'A',
					unmerged = '═',
					renamed = 'R',
					untracked = 'U',
					deleted = '',
					ignored = '◌',
				},
			},
		},
		special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'justfile', 'package.json', '.env' },
		symlink_destination = true,
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	respect_buf_cwd = true,
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = '',
			info = '',
			warning = '',
			error = '',
		},
	},
	-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
	-- nvim_tree_git_hl = true
}

--AUTO CLOSE IF LAST BUFFER
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
	pattern = 'NvimTree_*',
	callback = function()
		local layout = vim.api.nvim_call_function('winlayout', {})
		if
			layout[1] == 'leaf'
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree'
			and layout[3] == nil
		then
			vim.cmd('confirm quit')
		end
	end,
})

--[[ --AUTO CLOSE IF LAST BUFFER IMPROVED? Not working
vim.api.nvim_create_autocmd('QuitPre', {
	callback = function()
		local invalid_win = {}
		local wins = vim.api.nvim_list_wins()
		for _, w in ipairs(wins) do
			local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
			if bufname:match('NvimTree_') ~= nil then
				table.insert(invalid_win, w)
			end
		end
		if #invalid_win == #wins - 1 then
			-- Should quit, so we close all invalid windows.
			for _, w in ipairs(invalid_win) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
}) ]]

return M
