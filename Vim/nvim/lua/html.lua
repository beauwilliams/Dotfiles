
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    __                     __   _    __
   / /   ____  _________ _/ /  | |  / /___ ___________
  / /   / __ \/ ___/ __ `/ /   | | / / __ `/ ___/ ___/
 / /___/ /_/ / /__/ /_/ / /    | |/ / /_/ / /  (__  )
/_____/\____/\___/\__,_/_/     |___/\__,_/_/  /____/

--]]
local api = vim.api
local cwd = vim.loop.cwd
local has_lsp, lsp = pcall(require, 'lspconfig')
local has_lsp_util, lsputil = pcall(require, 'lspconfig/util')
require('_lsp_config')
---------------------------------------------------------------------------------------
--[[
    __  __  ______    __  ___    __
   / / / / /_  __/   /  |/  /   / /
  / /_/ /   / /     / /|_/ /   / /
 / __  /   / /     / /  / /   / /___
/_/ /_/   /_/     /_/  /_/   /_____/
--]]


-- NOTE: Install via npm `npm install -g vscode-html-languageserver-bin`
lsp.html.setup{
    on_attach = custom_attach,
    on_init = custom_init,
    capabilities = Custom_capabilities(), --enable snippet support
    cmd = { "html-languageserver", "--stdio" },
    root_dir = vim.loop.cwd,
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      }
    }

}


