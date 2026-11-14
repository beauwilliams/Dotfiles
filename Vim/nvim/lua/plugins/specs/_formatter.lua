--return { { 'sbdchd/neoformat' } } -- Code formatting plugin
return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local conform = require('conform')

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
				solidity = { 'forge_fmt' },
				svelte = { 'prettier' },
				css = { 'prettier' },
				html = { 'prettier' },
				json = { 'prettier' },
				yaml = { 'prettier' },
				markdown = { 'prettier' },
				graphql = { 'prettier' },
				liquid = { 'prettier' },
				lua = { 'stylua' },
				python = { 'isort', 'black' },
			},
			--format_on_save = {
			--	lsp_fallback = true,
			--	async = false,
			--	timeout_ms = 1000,
			--},
		})

		--enables lsp builtin formatters via vim.lsp.buf.format()
		Formatexpr = function()
			return conform.formatexpr({ timeout_ms = 10000 })
		end

		vim.o.formatexpr = 'v:lua.Formatexpr()'

		----Custom solidity formatter using
		--vim.api.nvim_create_autocmd('BufWritePre', {
		--	pattern = '*.sol',
		--	callback = function()
		--		-- Format the file using LSP
		--		vim.lsp.buf.format()
		--		-- Write the buffer
		--		vim.cmd('write')
		--	end,
		--})
	end,
}
