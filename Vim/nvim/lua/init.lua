local M = {}
local init = function()
	-- MY CONFS
	require('impatient') -- HALVES STARTUP TIME MUST BE RUN JUST AFTER PLUGINS
	require('plugins._plugins') -- Loads packer commands
	require('settings._theme')
	require('settings._options')
	require('settings._autocmds')
	require('settings._mappings')

	--LIBRARIES
	require('libraries._utils')

	--PLUGINS
	require('plugins._startify')
	require('plugins._hexokinase')
	require('plugins._telescope')
	require('plugins._treesitter')
	require('plugins._nvimtree')
	-- require('plugins._discord')

	--LSP
	require('lsp._lsp_config')

	--Statusline (My plugin :D)
	local statusline = require('statusline')
	statusline.tabline = true
	statusline.lsp_diagnostics = true
	statusline.ale_diagnostics = false
end

init() --> Load our confs

return M
