local utils = safe_require('libraries._set_mappings')
if not utils then
	return
end

local leader = '<space>'
local g = vim.g
--- @diagnostic disable-next-line: unused-local
local api = vim.api
local cmd = vim.cmd
local set_keymap = vim.keymap.set
------------------------------------------------------------------------------------------------------------------------------------------------
--TELESCOPE MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
set_keymap('n', '<leader>s', ':MySearchFiles<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>s', ':MySearchFiles<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>S', ':MySearchFilesHistory<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>S', ':MySearchFilesHistory<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>f', ':MySearchGrep<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>f', ':MySearchGrep<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>b', ':MySearchBuffers<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>b', ':MySearchBuffers<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>c', ':MySearchCommands<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>c', ':MySearchCommands<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>y', ':MySearchYankHistory<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>y', ':MySearchYankHistory<CR>', { noremap = true, silent = true })
--[[ set_keymap('n', '<leader>g', ':MySearchGitFiles<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>g', ':MySearchGitFiles<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>b', ':MySearchGitBranches<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>b', ':MySearchGitBranches<CR>', { noremap = true, silent = true }) ]]
set_keymap('n', '<leader>p', ':MySearchProjects<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>p', ':MySearchProjects<CR>', { noremap = true, silent = true })
--TODO: ABBREVIATIONS refactor
cmd('cnoreabbrev <silent>tel Telescope')
cmd("cnoreabbrev <silent>gwa lua require('telescope').extensions.git_worktree.create_git_worktree()")
cmd("cnoreabbrev <silent>gwl lua require('telescope').extensions.git_worktree.git_worktrees()")
