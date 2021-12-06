
local M = {}
local lsp = require('lspconfig')

M.setup = function(custom_init, custom_attach)
lsp.tsserver.setup({
	on_attach = custom_attach,
	on_init = custom_init,
    cmd = {"solang", "--language-server", "--target", "ewasm" , "--importmap=hardhat=node_modules/hardhat" }
})
end

return M
