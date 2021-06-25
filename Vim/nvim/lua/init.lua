local init = function()
-- MY CONFS
require('_plugins')
require('_theme')
require('_mappings')
require('_settings')
require('_autocmds')

--LIBRARIES
require('_utils')

--PLUGINS
require('_quickscope')
require('_hexokinase')
require('_telescope')
require('_treesitter')
require('_nvimtree')
-- require('_discord')
require('_snap')

--LSP
require('lsp._lsp_config')

--Statusline (My plugin :D)
local statusline = require('statusline')
statusline.tabline = false
statusline.lsp_diagnostics = false
statusline.ale_diagnostics = true

--Focus (My plugin :D)
local focus = require('focus')
focus.enable = true
focus.width = 120
-- focus.treewidth = 120
focus.height = 40
focus.cursorline = true
focus.signcolumn = true
focus.winhighlight = false

end

init() --> Load our confs

