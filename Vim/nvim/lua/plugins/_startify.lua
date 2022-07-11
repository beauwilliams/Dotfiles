-- lua alternative goolord/alpha-nvim
local g = vim.g
local fn = vim.fn

local ascii = {
	[[   ██╗     ███████╗████████╗███████╗     ██████╗ ███████╗████████╗    ██╗████████╗██╗]],
	[[   ██║     ██╔════╝╚══██╔══╝██╔════╝    ██╔════╝ ██╔════╝╚══██╔══╝    ██║╚══██╔══╝██║]],
	[[   ██║     █████╗     ██║   ███████╗    ██║  ███╗█████╗     ██║       ██║   ██║   ██║]],
	[[   ██║     ██╔══╝     ██║   ╚════██║    ██║   ██║██╔══╝     ██║       ██║   ██║   ╚═╝]],
	[[   ███████╗███████╗   ██║   ███████║    ╚██████╔╝███████╗   ██║       ██║   ██║   ██╗]],
	[[   ╚══════╝╚══════╝   ╚═╝   ╚══════╝     ╚═════╝ ╚══════╝   ╚═╝       ╚═╝   ╚═╝   ╚═╝]],
}

g.startify_files_number = 10
g.startify_change_to_dir = 1
g.startify_session_dir = '~/.cache/nvim/.session'
g.startify_session_persistence = 1
g.startify_change_to_dir = 1
g.startify_change_to_vcs_root = 1
g.startify_files_number = 10
g.startify_padding_left = 3
g.startify_session_number = 10
g.startify_session_sort = 0 -- Sort sessions by modification time (when the session files were written)
-- g.session_autosave = 'yes'
g.startify_custom_header = 'startify#center(g:ascii)'
g.startify_custom_header = ascii
g.startify_relative_path = 1 -- shortens recent file paths
-- g.startify_use_env = 1 -- displays $MYVIMRC instead of .vimrc etc...

g.startify_lists = {
	{ type = 'files', header = { 'Recent Files' } },
	{ type = 'dir', header = { 'Current Directory: ' .. fn.getcwd() } },
	{ type = 'sessions', header = { 'Sessions' } },
	{ type = 'bookmarks', header = { 'Bookmarks' } },
	{ type = 'commands', header = { 'Commands' } },
}

g.startify_commands = {
	{ ps = { 'Packer Sync', ':PackerSync' } },
	{ pi = { 'Packer Install', ':PackerInstall' } },
	{ pc = { 'Packer Clean', ':PackerClean' } },
	{ ch = { 'Check Health', 'checkhealth' } },
}

g.startify_bookmarks = {
	{ n = '~/Dropbox/Software Eng/Workspaces/Neorg/index.norg' },
	{ v = '~/.config/nvim/init.vim' },
	{ z = '~/.zshrc' },
	{ g = '~/.gitconfig' },
	{ s = '~/.ssh/config' },
	{ vn = '/Users/admin/Library/Caches/Homebrew/neovim--git' },
	{ ll = '~/.cache/nvim/lsp.log'}
}
