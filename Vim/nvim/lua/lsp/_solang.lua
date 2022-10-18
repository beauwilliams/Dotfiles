
local M = {}
local lsp = safe_require('lspconfig')
if not lsp then
	return
end

M.setup = function(custom_init, custom_attach)
lsp.solang.setup({
	on_attach = custom_attach,
	on_init = custom_init,
    cmd = {"solang", "--language-server", "--target", "ewasm" , "--importmap", "@openzeppelin=node_modules/@openzeppelin"}
    -- cmd = {"yarn", "run", "watch"},
	-- root_dir = vim.loop.cwd,
})
end

return M
