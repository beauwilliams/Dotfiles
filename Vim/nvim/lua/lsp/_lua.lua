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
local lsputil = safe_require('lspconfig/util')

if not lsp or not lsputil then
	return
end
---------------------------------------------------------------------------------------
--[[
    __
   / /   __  __  ____ _
  / /   / / / / / __ `/
 / /___/ /_/ / / /_/ /
/_____/\__,_/  \__,_/
--]]
--
local system_name
if vim.fn.has('mac') == 1 then
	system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
	system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
	system_name = 'Windows'
else
	print('Unsupported system for sumneko')
end

-- STORED IN MY .config/nvim/.langservers/
-- local sumneko_root_path = vim.fn.stdpath('config')..'/.langservers/sumneko_lua/lua-language-server'
local sumneko_root_path = '/Users/admin/.langservers/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.setup = function(custom_init, custom_attach)
	lsp.sumneko_lua.setup({
		cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
		on_init = custom_init,
		on_attach = custom_attach,
		root_dir = function(fname)
			return lsputil.find_git_ancestor(fname) or lsputil.path.dirname(fname)
		end,
		--root_dir = vim.loop.cwd,
		--root_dir = util.root_pattern('.git') or cwd, --Not working
		capabilities = {
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = false,
					},
				},
			},
		},
		-- lsp_status.capabilities, --> REQUIRED FOR LSP STATUS..WROTE MY OWN
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					-- enable = true,
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					-- vim.api.nvim_get_runtime_file("", true),
					library = {
						[vim.fn.expand('$VIMRUNTIME/lua')] = true,
						[vim.fn.expand('$VIMRUNTIME/lua/lang')] = true,
						[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
						[vim.fn.stdpath('config') .. '/lua'] = true,
						-- For when we want to write hammerspoon stuff
						-- ['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

return M
