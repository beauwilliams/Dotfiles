local M = {}
local lsp = require('lspconfig')

M.setup = function(custom_init, custom_attach)
lsp.solang.setup({
	on_attach = custom_attach,
	on_init = custom_init,
	cmd = { 'solc', '--lsp' }
})
end

return M
