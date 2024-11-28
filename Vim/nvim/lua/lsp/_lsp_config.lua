local vim = vim
local cwd = vim.loop.cwd

local lsp = safe_require('lspconfig')
local mason_lsp = safe_require('mason-lspconfig')
local lsp_utils = safe_require('libraries._lsp')
local cmp_nvim_lsp = safe_require('cmp_nvim_lsp')

if not lsp or not lsp_utils or not cmp_nvim_lsp or not mason_lsp then
	return
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    __    _____    ____           ______                   ____    _
   / /   / ___/   / __ \         / ____/  ____    ____    / __/   (_)   ____ _   _____
  / /    \__ \   / /_/ /        / /      / __ \  / __ \  / /_    / /   / __ `/  / ___/
 / /___ ___/ /  / ____/        / /___   / /_/ / / / / / / __/   / /   / /_/ /  (__  )
/_____//____/  /_/             \____/   \____/ /_/ /_/ /_/     /_/    \__, /  /____/
                                                                     /____/
--]]
--CAPABILITIES
local custom_capabilities = function()
	local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
	return capabilities
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    ___   __  __             __       ______                 __  _
   /   | / /_/ /_____ ______/ /_     / ____/_  ______  _____/ /_(_)___  ____
  / /| |/ __/ __/ __ `/ ___/ __ \   / /_  / / / / __ \/ ___/ __/ / __ \/ __ \
 / ___ / /_/ /_/ /_/ / /__/ / / /  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / /
/_/  |_\__/\__/\__,_/\___/_/ /_/  /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/

--]]

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == 'null-ls'
		end,
		bufnr = bufnr,
	}, 1000)
end

--When our LSP starts, this is what happens. Completion enabled, set some mappings, print lsp starting message
local custom_attach = function(client, bufnr)
	-- INITS
	safe_require('plugins._lightbulb') --> CODE ACTION LIGHTBULB
	safe_require('lsp-status').on_attach(client) --> REQUIRED for lsp statusbar current function.. WROTE MY OWN..
	safe_require('lsp_basics').make_lsp_commands(client, bufnr) --> adds commands such as :LspFormat
	-- require('lsp_signature').on_attach(client) --> Signature popups and info
	-- require('virtualtypes').on_attach() -- A Neovim plugin that shows type annotations as virtual text

	--NOTE: auto formatting, with builtin lsp formatter disabled
	local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
	-- if client.supports_method('textDocument/formatting') then
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = augroup,
		buffer = bufnr,
		callback = function()
			vim.notify('Automatically formatting...')
			lsp_formatting(bufnr)
		end,
	})
	-- end
end

local custom_init = function(server)
	-- DEBUGGING
	-- vim.lsp.set_log_level('debug') --> ENABLE LOGGING, located in ~/.cache
	-- SWAG
	vim.notify(' Started ' .. vim.bo.ft .. " language server. Let's get this bread!", 2, { title = 'Language Server' })
	vim.diagnostic.config({
		virtual_lines = { only_current_line = true },
		virtual_text = false,
		-- Could be '●', '▎', 'x', '■'
		-- virtual_text = {
		-- prefix = "»",
		-- spacing = 4
		-- },
		underline = true,
		float = {
			focusable = false,
			style = 'minimal',
			source = 'always',
			border = 'rounded',
			header = '',
			prefix = '',
		},
		severity_sort = true,
		signs = true,
		update_in_insert = false,
	})
	--Rounded borders for floating windows
	--[[ vim.lsp.handlers['textDocument/hover'] =
		vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', focusable = false })
	vim.lsp.handlers['textDocument/signatureHelp'] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded', focusable = false }) ]]

	-- SET DIAG GUTTER SIGNS
	local signs = { Error = '✘', Warning = '', Hint = '', Information = '' }
	for type, icon in pairs(signs) do
		local hl = 'LspDiagnosticsSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
	end

	-- DISPLAY LSP DIAGS IN COMMAND LINE
	-- vim.cmd [[ autocmd! CursorHold * lua require("libraries._lsp").echo_diagnostics() ]]

	-- DISPLAY LSP DIAGS AS POPUP OVERLAY
	-- vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil,{focusable=false,scope="cursor"})]]

	-- DISPLAY LSP DIAGS AS VIRTUAL LINES
	--current line only, fed into lsplines.nvim
	--all lines
	-- vim.cmd(
	-- [[autocmd CursorHold * lua if diagnostics_active then vim.diagnostic.config({ virtual_lines = { only_current_line = true } }) end]]
	-- )

	--DISPLAY LSP FN SIGNATURE POPUP OVERLAY
	-- vim.cmd [[autocmd! CursorHold * silent! execute "Lsp signature"]]
	-- vim.cmd [[autocmd! CursorHold * silent! execute "lua if #vim.lsp.buf_get_clients() > 0 then vim.lsp.buf.signature_help() end]]

	--local hover_supported_lsp = '*.ts,*.tsx,*.js,*.jsx,*.lua'
	--vim.cmd(
	--[[autocmd CursorHold ]]
	--	.. hover_supported_lsp
	--	.. [[ lua if #vim.lsp.buf_get_clients() > 0 then vim.lsp.buf.hover() end]]
	--)
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    __                                                                   ______                   ____    _
   / /   ____ _   ____    ____ _  __  __  ____ _   ____ _  ___          / ____/  ____    ____    / __/   (_)   ____ _   _____
  / /   / __ `/  / __ \  / __ `/ / / / / / __ `/  / __ `/ / _ \        / /      / __ \  / __ \  / /_    / /   / __ `/  / ___/
 / /___/ /_/ /  / / / / / /_/ / / /_/ / / /_/ /  / /_/ / /  __/       / /___   / /_/ / / / / / / __/   / /   / /_/ /  (__  )
/_____/\__,_/  /_/ /_/  \__, /  \__,_/  \__,_/   \__, /  \___/        \____/   \____/ /_/ /_/ /_/     /_/    \__, /  /____/
                       /____/                   /____/                                                      /____/
--]]
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

mason_lsp.setup({
	automatic_installation = false,
	ensure_installed = {
		'bashls',
		-- 'cssls',
		'vimls',
		'rust_analyzer',
		'pylsp',
		'dockerls',
		'yamlls',
		'gopls',
		'marksman',
		-- 'yaml-language-server',
		-- 'yamllint',
		'jsonls', --> might need root_cwd
		-- 'metals', --> might need root_cwd
		-- 'solc',
		-- 'solidity',
		--'eslint-lsp',
		--'rome',
		--'terraform-ls',
		--'tflint',
		'tsserver',
	},
})
mason_lsp.setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup({
			on_attach = custom_attach,
			on_init = custom_init,
			capabilities = custom_capabilities(),
		})
	end,
})

-- CUSTOM LANG CONFS
safe_require('lsp._null_ls') --Null ls, additional formatters, diags and more..
safe_require('lsp._lua').setup(custom_init, custom_attach)
safe_require('lsp._html').setup(custom_attach, custom_init, custom_capabilities)
safe_require('lsp._solidity_hardhat').setup(custom_attach, custom_init, custom_capabilities)
safe_require('lsp._typescript').setup(custom_init, custom_attach)
-- require('lsp._omnisharp').setup(custom_attach, custom_init)
-- require('lsp._solang').setup(custom_attach, custom_init)
vim.cmd( -- NOTE: sets workspace per project..
	[[au FileType java lua require('jdtls').start_or_attach({filetypes = {'java'},cmd = {'/Users/admin/.config/nvim/lua/lsp/launch_jdtls.sh', '/Users/admin/workspaces/nvim/eclipse-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')},on_init = custom_init, on_attach = custom_attach})]]
)

--[[
    __  __     __                   ______                 __  _
   / / / /__  / /___  ___  _____   / ____/_  ______  _____/ /_(_)___  ____  _____
  / /_/ / _ \/ / __ \/ _ \/ ___/  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
 / __  /  __/ / /_/ /  __/ /     / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  )
/_/ /_/\___/_/ .___/\___/_/     /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/
            /_/
--]]
--A custom mapper function to make mapping our lsp functions to vim key sequences less verbose
--[[ local mapper = function(mode, key, result)
	api.nvim_buf_set_keymap(0, mode, key, '<cmd>lua ' .. result .. '<cr>', { noremap = true, silent = true })
end ]]
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    ______               __          ____     ____           ______    _     __
   / ____/   ____   ____/ /         / __ \   / __/          / ____/   (_)   / /  ___
  / __/     / __ \ / __  /         / / / /  / /_           / /_      / /   / /  / _ \
 / /___    / / / // /_/ /         / /_/ /  / __/          / __/     / /   / /  /  __/
/_____/   /_/ /_/ \__,_/          \____/  /_/            /_/       /_/   /_/   \___/
--]]
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

-- NOTE: Archiving lsp config setup without mason
--SERVER INSTALLATION NOTES
--VIMLS Installed by lspconfig, copy in .langservers, get it here https://github.com/iamcco/vim-language-server
--Must install rust-analyzer first and add it to your path --> kept in .langservers
--curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-mac -o ~/.local/bin/rust-analyzer
--chmod +x ~/.local/bin/rust-analyzer
-- INSTALL COMMANDS
-- npm i -g vscode-langservers-extracted [installs html,css,json with most up to date from vscode]
-- pip3 install 'python-language-server[all]' - DEPRECATED
-- pipx install 'python-lsp-server[all]'
-- npm i -g typescript typescript-language-server
-- npm i -g bash-language-server
-- npm install -g vim-language-server
-- npm i -g vscode-langservers-extracted
-- npm install -g dockerfile-language-server-nodejs
-- npm install -g vim-language-server
-- cs install metals
-- npm install -g yaml-language-server

--[[ local servers = {
	'bashls',
	'cssls',
	'vimls',
	'rust_analyzer',
	'pylsp',
	'dockerls',
	'yamlls',
	'gopls',
	'marksman',
	-- 'solidity',
	'solidity_ls',
	-- 'solc',
}

for _, server in ipairs(servers) do
	lsp[server].setup({
		on_attach = custom_attach,
		on_init = custom_init,
		capabilities = custom_capabilities(),
	})
end ]]

-- these servers activate even when not in .git repo etc
--[[ local servers_rootcwd = {
	'metals',
	'vimls',
	'jsonls',
}

for _, server in ipairs(servers_rootcwd) do
	lsp[server].setup({
		on_attach = custom_attach,
		on_init = custom_init,
		capabilities = custom_capabilities(),
		root_dir = cwd,
	})
end ]]

--NOTE: Archiving COQ custom_capabilities
--CAPABILITIES
--[[ local custom_capabilities = function()
	--NOTE: COQ
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local coq = require('coq')
	coq.lsp_ensure_capabilities()
	return capabilities
end ]]

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
