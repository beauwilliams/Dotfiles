local vim_version = vim.version().minor
local g = vim.g

-- use filetype.lua instead of filetype.vim. it's enabled by default in neovim 0.8 (nightly)
if vim_version < 8 then
	g.did_load_filetypes = 0
	g.do_filetype_lua = 1
end

-- set shada path
vim.schedule(function()
	vim.opt.shadafile = vim.fn.stdpath(vim_version > 7 and 'state' or 'data') .. '/shada/main.shada'
	vim.cmd([[ silent! rsh ]])
end)

-- disable some builtin vim plugins
local disabled_built_ins = {
	'2html_plugin',
	'getscript',
	'getscriptPlugin',
	'gzip',
	'logipat',
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'matchit',
	'tar',
	'tarPlugin',
	'rrhelper',
	'spellfile_plugin',
	'vimball',
	'vimballPlugin',
	'zip',
	'zipPlugin',
	'tutor',
	'rplugin',
	'syntax',
	'synmenu',
	'optwin',
	'compiler',
	'bugreport',
	'ftplugin',
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g['loaded_' .. plugin] = 1
end

-- Disable some in built plugins completely
--[[ local disabled_built_ins = {
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'gzip',
	'zip',
	'zipPlugin',
	'tar',
	'tarPlugin',
	'getscript',
	'getscriptPlugin',
	'vimball',
	'vimballPlugin',
	'2html_plugin',
	'logipat',
	'rrhelper',
	'spellfile_plugin',
	'matchit',
	--'matchparen',
} ]]

-- Disable providers we do not care a about
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
local default_providers = {
	'node',
	'perl',
	-- "python3",
	'ruby',
}

for _, provider in ipairs(default_providers) do
	vim.g['loaded_' .. provider .. '_provider'] = 0
end
