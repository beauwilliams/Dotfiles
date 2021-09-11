local lsp = require 'lspconfig'
-- local lsputil = require 'lspconfig/util'

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "/Users/admin/.langservers/omnisharp-osx/run"
lsp.omnisharp.setup({
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
	on_attach = custom_attach,
	on_init = custom_init,
})
