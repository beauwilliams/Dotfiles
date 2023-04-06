local M = {}
local lsp = safe_require('lspconfig')
local lsputil = safe_require('lspconfig/util')


if not lsp or not lsputil then
	return
end

M.setup = function(custom_attach, custom_init, custom_capabilities)
lsp.solidity.setup({
    capabilities = custom_capabilities(), --enable snippet support
	on_init = custom_init,
	on_attach = custom_attach,
	cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
	filetypes = { "solidity" },
	root_dir = lsp.util.root_pattern(".prettierrc"),
	single_file_support = true,
})
end

return M
