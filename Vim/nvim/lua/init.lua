require("impatient")
require("settings._mappings")
require("settings._commands")
require("plugins._plugins")
require("settings._theme")
require("settings._options")
require("settings._autocmds")
require("settings._optimisations")
require("plugins._startify")
require("plugins._hexokinase")
require("plugins._telescope")
require("plugins._treesitter")
require("plugins._nvimtree")
require("plugins._discord")
require("plugins._goto-preview")
require("plugins._nvim-notify")
require("plugins._hydra")
require("lsp._lsp_config")
local statusline = require("statusline")
statusline.enable = true
statusline.lsp_diagnostics = true
statusline.ale_diagnostics = false
return statusline
