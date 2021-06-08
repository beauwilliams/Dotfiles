-- local utils = require "_utils"
local g = vim.g
local exec = vim.api.nvim_exec

g.nvim_tree_side = "left"
g.nvim_tree_width = 35
g.nvim_tree_ignore = { ".git", "node_modules" }

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'} -- empty by default, don't auto open tree on specific filetypes.

-- 0 by default, closes the tree when it's the last window
g.nvim_tree_auto_close = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_follow = 1

-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_git_hl = 1


--TODO:
exec([[highlight NvimTreeFolderName ctermfg=none guifg=none]],"")
exec([[highlight NvimTreeRootFolder guifg = #fb4934]],"")
exec([[highlight NvimTreeEmptyFolderName guifg = #7c6f64]],"")
exec([[highlight NvimTreeOpenedFolderName guifg = #ebdbb2]],"")
exec([[highlight NvimTreeExecFile guifg = #ebdbb2]],"")
exec([[highlight NvimTreeIndentMarker guifg = #8ec07c]],"")
exec([[highlight NvimTreeFolderIcon guifg = #8ec07c]],"")





-- "Setting nvim tree folders to not have any guibg
-- "hi Cursorline guibg=#424040 guifg=none

g.nvim_tree_icons = {
    default = '',
    -- symlink = '',
    git = {
        unstaged = "M",
        staged = "A",
        unmerged = "═",
        renamed = "R",
        untracked = "U"
    },
    folder = {
        default = "",
        open = ""
    }
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
    ""
)
