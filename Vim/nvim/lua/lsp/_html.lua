---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    __                     __   _    __
   / /   ____  _________ _/ /  | |  / /___ ___________
  / /   / __ \/ ___/ __ `/ /   | | / / __ `/ ___/ ___/
 / /___/ /_/ / /__/ /_/ / /    | |/ / /_/ / /  (__  )
/_____/\____/\___/\__,_/_/     |___/\__,_/_/  /____/

--]]
local M = {}
local lsp = safe_require('lspconfig')
if not lsp then
	return
end

---------------------------------------------------------------------------------------
--[[
    __  __  ______    __  ___    __
   / / / / /_  __/   /  |/  /   / /
  / /_/ /   / /     / /|_/ /   / /
 / __  /   / /     / /  / /   / /___
/_/ /_/   /_/     /_/  /_/   /_____/
--]]

-- NOTE: Install via npm `npm i -g vscode-langservers-extracted`
M.setup = function(custom_init, custom_attach, custom_capabilities)
lsp.html.setup({
	on_attach = custom_attach,
	on_init = custom_init,
	capabilities = custom_capabilities(), --enable snippet support
	cmd = { 'vscode-html-language-server', '--stdio' },
	root_dir = vim.loop.cwd,
	filetypes = { 'html' },
	init_options = {
		configurationSection = { 'html', 'css', 'javascript' },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
})
end

return M
