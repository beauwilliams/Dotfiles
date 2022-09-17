local M = {}
local lsp = safe_require('lspconfig')
if not lsp then
	return
end

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = '/Users/admin/.langservers/omnisharp-osx/run'

M.setup = function(custom_init, custom_attach)
lsp.omnisharp.setup({
	cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
	on_attach = custom_attach,
	on_init = custom_init,
})
end

return M
