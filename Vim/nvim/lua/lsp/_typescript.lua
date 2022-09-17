local M = {}

local lsp = safe_require('lspconfig')
local lsputil = safe_require('lspconfig/util')
local typescript = safe_require('typescript')


if not lsp or not lsputil or not typescript then
    return
end
---------------------------------------------------------------------------------------
--[[
  ______                                _       __
 /_  __/_  ______  ___  _______________(_)___  / /_
  / / / / / / __ \/ _ \/ ___/ ___/ ___/ / __ \/ __/
 / / / /_/ / /_/ /  __(__  ) /__/ /  / / /_/ / /_
/_/  \__, / .___/\___/____/\___/_/  /_/ .___/\__/
    /____/_/                         /_/
--]]
--NOTE: Default typescript setup just using lspconfig
--INSTALL: -- npm i -g typescript typescript-language-server
--[[ M.setup = function(custom_init, custom_attach)
lsp.tsserver.setup({
	on_attach = custom_attach,
	on_init = custom_init,
	settings = { documentFormatting = true },
	root_dir = function(fname)
		return lsputil.find_git_ancestor(fname) or lsputil.path.dirname(fname)
	end,
})
end

return M ]]


-- NOTE: Using https://github.com/jose-elias-alvarez/typescript.nvim to polyfill features
M.setup = function(custom_init, custom_attach)
    typescript.setup(
        {
            disable_commands = false, -- prevent the plugin from creating Vim commands
            disable_formatting = false, -- disable tsserver's formatting capabilities
            debug = false, -- enable debug logging for commands
            server = {
                -- pass options to lspconfig's setup method
                on_attach = custom_attach,
                on_init = custom_init,
                settings = {documentFormatting = true},
                root_dir = function(fname)
                    return lsputil.find_git_ancestor(fname) or lsputil.path.dirname(fname)
                end
            }
        }
    )
end
return M

--ARCHIVE
--root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git') or cwd
--root_dir = vim.loop.cwd --Sets global cwd

--root_dir = function() --NOT WORKING: RETURNS FUNCTION NAME NOT THE DATA
--return cwd
--end,
--root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git') or cwd
--local util = require 'lspconfig/util'
--local cwd = vim.loop.cwd
--SetTsServerCWD = function()
--return 	 util.root_pattern('package.json', 'tsconfig.json', '.git') or cwd
--end
