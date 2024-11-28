local mason_tools_installer = safe_require('mason-tool-installer')
if not mason_tools_installer then
	return
end

mason_tools_installer.setup({

	-- a list of all tools you want to ensure are installed upon
	-- start; they should be the names Mason uses for each tool
	ensure_installed = {
		'stylua',
		'shellcheck',
		'luacheck',
		'codespell',
		-- 'gofumpt',
		-- 'golines',
		-- 'goimports',
		-- 'goimports-reviser',
		-- 'gotests',
		-- 'golangci-lint',
		-- 'staticcheck',

		-- you can pin a tool to a particular version
		-- { 'golangci-lint', version = 'v1.47.0' },
		-- you can turn off/on auto_update per tool
		-- { 'bash-language-server', auto_update = true },

		-- 'lua-language-server',
		--'vim-language-server',
		--'editorconfig-checker',
		--'gopls',
		--'golangci-lint',
		--'gofumpt',
		--'gomodifytags',
		--'impl',
		--'json-to-struct',
		--'luacheck',
		--'misspell',
		--'revive',
		--'shellcheck',
		--'shfmt',
		--'staticcheck',
		--'vint',
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = true,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'MasonToolsUpdateCompleted',
	callback = function()
		vim.schedule(function()
			vim.notify(
				' Mason-tool-installer has finished updating packages',
				'info',
				{ title = 'Mason Tool Installer' }
			)
		end)
	end,
})
