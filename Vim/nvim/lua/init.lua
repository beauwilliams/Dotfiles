
local init = function()
	-- MY CONFS
	require("_plugins")
	require("_theme")
	require("_options")
	require("_autocmds")
	require("_mappings")

	--LIBRARIES
	require("_utils")

	--PLUGINS
	require("_quickscope")
	require("_hexokinase")
	require("_telescope")
	require("_treesitter")
	require("_nvimtree")
	-- require('_discord')

	--LSP
	require("lsp._lsp_config")

	--Statusline (My plugin :D)
	local statusline = require("statusline")
	statusline.tabline = true
	statusline.lsp_diagnostics = true
	statusline.ale_diagnostics = false

	--Focus (My plugin :D)
	local focus = require("focus")
	focus.enable = true
	-- focus.width = 180
	focus.treewidth = 30
	-- focus.treewidth = 160
	-- focus.height = 30
	focus.cursorline = true
	focus.signcolumn = true
	focus.winhighlight = false
	-- focus.number = true
	focus.relativenumber = false
	focus.hybridnumber = true
end

init() --> Load our confs
