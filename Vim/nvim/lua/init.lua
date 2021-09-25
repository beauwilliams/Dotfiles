local M = {}
local init = function()
	-- MY CONFS
	require('_plugins') -- Loads packer commands
	require('_theme')
	require('_options')
	require('_autocmds')
	require('_mappings')

	--LIBRARIES
	require('_utils')

	--PLUGINS
	require('_startify')
	require('_quickscope')
	require('_hexokinase')
	require('_telescope')
	require('_treesitter')
	require('_nvimtree')
	require('_discord')

	--LSP
	require('lsp._lsp_config')

	--Statusline (My plugin :D)
	local statusline = require('statusline')
	statusline.tabline = true
	statusline.lsp_diagnostics = true
	statusline.ale_diagnostics = false

	--Focus (My plugin :D)
	--[[ local focus = require("focus")
	focus.enable = true
	-- focus.width = 180
	focus.treewidth = 30
	-- focus.treewidth = 160
	-- focus.height = 30
	focus.cursorline = true
	focus.signcolumn = true
	focus.winhighlight = false
	-- focus.number = true
	-- focus.relativenumber = true
	focus.hybridnumber = true ]]
end

init() --> Load our confs

vim.cmd([[
function! SpectreFocus()
    lua vim.bo.buftype = 'help'
    lua require('spectre').open()
    :FocusEqualise
endfunction
nnoremap <leader>/ :call SpectreFocus()<cr>
]])

function wait(seconds)
	local start = os.time()
	repeat
	until os.time() > start + seconds
end

M.FocusEqualiseDiffview = function()
	vim.cmd([[
    wincmd w
    wincmd w
    ]])
	vim.bo.buftype = 'help'
	vim.cmd('FocusEqualise')
end

M.Diffv = function()
	local co = coroutine.create(function()
		require('diffview').open()
	end)
	coroutine.yield(co)
	wait(3)
	print('hello')
end

M.Diffv2 = function()
	co2 = coroutine.create(function()
		coroutine.yield()
		-- wait(5)
		print('this runs after 5 seconds, diffview is opened during this time')
	end)
	require('diffview').open()
	coroutine.resume(co2)
	wait(5)
	coroutine.resume(co2)
end

return M
