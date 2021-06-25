local lsp = require 'lspconfig'
local lsputil = require 'lspconfig/util'
---------------------------------------------------------------------------------------
--[[
  ______                                _       __
 /_  __/_  ______  ___  _______________(_)___  / /_
  / / / / / / __ \/ _ \/ ___/ ___/ ___/ / __ \/ __/
 / / / /_/ / /_/ /  __(__  ) /__/ /  / / /_/ / /_
/_/  \__, / .___/\___/____/\___/_/  /_/ .___/\__/
    /____/_/                         /_/
--]]
--INSTALL: -- npm i -g typescript typescript-language-server
lsp.tsserver.setup {
    on_attach = custom_attach,
    on_init = custom_init,
    settings = {documentFormatting = true},
  root_dir = function(fname)
    return lsputil.find_git_ancestor(fname) or
      lsputil.path.dirname(fname)
  end,
}
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


