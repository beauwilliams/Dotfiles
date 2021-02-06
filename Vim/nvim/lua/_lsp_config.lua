

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    __                     __   _    __
   / /   ____  _________ _/ /  | |  / /___ ___________
  / /   / __ \/ ___/ __ `/ /   | | / / __ `/ ___/ ___/
 / /___/ /_/ / /__/ /_/ / /    | |/ / /_/ / /  (__  )
/_____/\____/\___/\__,_/_/     |___/\__,_/_/  /____/

--]]
local api = vim.api
local cwd = vim.loop.cwd
local has_lsp, lsp = pcall(require, 'lspconfig')
local has_lsp_util, lsputil = pcall(require, 'lspconfig/util')
-- local lsp_status = require('lsp-status') --> LSP progress, errors etc in your statusline..WROTE MY OWN
-- local saga = require 'lspsaga'

--ERROR HANDLING INSPO --> https://raw.githubusercontent.com/nymann/dotfiles/master/dots/nvim/lua/lsp.lua
--local has_completion, completion = pcall(require, 'completion')
--local has_diagnostic, diagnostic = pcall(require, 'diagnostic')
--if not has_lsp then
    --return
--end

--Configure the exclusion pattterns
--[[
local exclude_patterns = {
  '**/node_modules/**/*',
  '**/bin/**/*',
  '**/obj/**/*',
  '/tmp/**/*'
}]]


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
   ______                      __     __  _                ____        __  _
  / ____/___  ____ ___  ____  / /__  / /_(_)___  ____     / __ \____  / /_(_)___  ____  _____
 / /   / __ \/ __ `__ \/ __ \/ / _ \/ __/ / __ \/ __ \   / / / / __ \/ __/ / __ \/ __ \/ ___/
/ /___/ /_/ / / / / / / /_/ / /  __/ /_/ / /_/ / / / /  / /_/ / /_/ / /_/ / /_/ / / / (__  )
\____/\____/_/ /_/ /_/ .___/_/\___/\__/_/\____/_/ /_/   \____/ .___/\__/_/\____/_/ /_/____/
                    /_/                                     /_/
--]]
require('_compe')


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    __  __     __                   ______                 __  _
   / / / /__  / /___  ___  _____   / ____/_  ______  _____/ /_(_)___  ____  _____
  / /_/ / _ \/ / __ \/ _ \/ ___/  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
 / __  /  __/ / /_/ /  __/ /     / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  )
/_/ /_/\___/_/ .___/\___/_/     /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/
            /_/
--]]

--A custom mapper function to make mapping our lsp functions to vim key sequences less verbose
local mapper = function(mode, key, result)
  api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua "..result.."<cr>", {noremap = true, silent = true})
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

-- async formatting
-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        vim.api.nvim_command("noautocmd :update")
    end
end

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- virtual_text = false,
    virtual_text = {
      prefix = "»",
      spacing = 4,
    },
    signs = true,
    update_in_insert = false,
  }
)

--CAPABILITIES
local custom_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true;
  return capabilities
end



-- Statusline
--lsp_status.config({
  --kind_labels = vim.g.completion_customize_lsp_label
--})
--not sure what this is for i think for progresss bars on statusline
--lsp_status.register_progress()




---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--[[
    ___   __  __             __       ______                 __  _
   /   | / /_/ /_____ ______/ /_     / ____/_  ______  _____/ /_(_)___  ____
  / /| |/ __/ __/ __ `/ ___/ __ \   / /_  / / / / __ \/ ___/ __/ / __ \/ __ \
 / ___ / /_/ /_/ /_/ / /__/ / / /  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / /
/_/  |_\__/\__/\__,_/\___/_/ /_/  /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/

--]]
--When our LSP starts, this is what happens. Completion enabled, set some mappings, print lsp starting message
local custom_attach = function(client,bufnr) --> Added client,bufnr works also without, inspo from https://github.com/kuator/nvim/blob/master/lua/plugins/lsp.lua
  --ERROR HANDLING INSPO
  --if has_status then
        --lsp_status.on_attach(client)
    --end

    --if has_diagnostic then
        --diagnostic.on_attach()
    --end

    --if has_completion then
        --completion.on_attach({
            --sorter = 'alphabet',
            --matcher = {'exact', 'fuzzy'}
        --})
    --end


  -- INITS
  require 'illuminate'.on_attach(client) --> ENABLES LSP INTEGRATION WITH vim-illluminate
  require('lspfuzzy').setup {} --> FUZZY FINDER FOR LSP
  require('_lightbulb') --> CODE ACTION LIGHTBULB
  -- lsp_status.on_attach(client) --> REQUIRED for lsp statusbar.. WROTE MY OWN..
  -- saga.init_lsp_saga() --> SETS UP SAGA ENHANCED LSP UX, REVISIT LATER


  -- DEBUGGING
  --vim.lsp.set_log_level('debug') --> ENABLE LOGGING, located in ~/.cache



  --MAPPINGS
  -- Move cursor to the next and previous diagnostic
  mapper('n', '<leader>dn', 'vim.lsp.diagnostic.goto_next()')
  mapper('n', '<leader>dp', 'vim.lsp.diagnostic.goto_prev()')
  -- Keybindings for LSPs
  -- Close quickfix with :cclose
  mapper('n', 'gd', 'vim.lsp.buf.definition()')
  mapper('n', 'gh', 'vim.lsp.buf.hover()')
  mapper('n', 'gD', 'vim.lsp.buf.implementation()')
  mapper('n', '<c-k>', 'vim.lsp.buf.signature_help()')
  mapper('n', '1gD', 'vim.lsp.buf.type_definition()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', 'g0', 'vim.lsp.buf.document_symbol()')
  mapper('n', 'gW', 'vim.lsp.buf.workspace_symbol()')
  --vim.fn.nvim_set_keymap("n", "<leader>ge", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gt", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<a-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true, silent = true})
  --vim.api.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')



end


local custom_init = function()
  -- SWAG
  print("LSP Started.. Let's get this bread")
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
--NOTE: The rest of this file deals with language specific configurations
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

-- Slowly moving to a better, cleaner config. Will fill this loop as we go on..
local servers = {
  'bashls','cssls','vimls','rust_analyzer'
}

for _,server in ipairs(servers) do
  lsp[server].setup {
    on_attach = custom_attach,
    on_init = custom_init
  }
end



---------------------------------------------------------------------------------------
--[[
    ____                     __
   / __ )  ____ _   _____   / /_
  / __  | / __ `/  / ___/  / __ \
 / /_/ / / /_/ /  (__  )  / / / /
/_____/  \__,_/  /____/  /_/ /_/
--]]
--BASHLS REQUIRES BASHLS INSTALLED using `npm i -g bash-language-server` -- SEE: bash-lsp/bash-language-server
-- lsp.bashls.setup{on_attach=custom_attach}
--[[



---------------------------------------------------------------------------------------
 _    ___                          _       __
| |  / (_)___ ___  _______________(_)___  / /_
| | / / / __ `__ \/ ___/ ___/ ___/ / __ \/ __/
| |/ / / / / / / (__  ) /__/ /  / / /_/ / /_
|___/_/_/ /_/ /_/____/\___/_/  /_/ .___/\__/
                                /_/
--]]
lsp.vimls.setup {on_init = custom_init, on_attach = custom_attach, root_dir = cwd}




---------------------------------------------------------------------------------------
--[[
    ____        __  __
   / __ \__  __/ /_/ /_  ____  ____
  / /_/ / / / / __/ __ \/ __ \/ __ \
 / ____/ /_/ / /_/ / / / /_/ / / / /
/_/    \__, /\__/_/ /_/\____/_/ /_/
      /____/
--]]
--NOTE: Must install pyls using `pip3 install 'python-language-server[all]'`
lsp.pyls.setup{
  on_init = custom_init,
  on_attach = custom_attach
}


---------------------------------------------------------------------------------------
--[[
  ______                                _       __
 /_  __/_  ______  ___  _______________(_)___  / /_
  / / / / / / __ \/ _ \/ ___/ ___/ ___/ / __ \/ __/
 / / / /_/ / /_/ /  __(__  ) /__/ /  / / /_/ / /_
/_/  \__, / .___/\___/____/\___/_/  /_/ .___/\__/
    /____/_/                         /_/
--]]
lsp.tsserver.setup {
  on_attach = custom_attach,
  on_init = custom_init,
  root_dir = function(fname)
    return lsputil.find_git_ancestor(fname) or
      lsputil.path.dirname(fname)
  end,
}
			--root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git') or cwd
            --root_dir = vim.loop.cwd --Sets global cwd

  --root_dir = function() --NOT WORKING: RETURNS FUNCTION NAME NOT THE DATA
    --return cwd
  --end,
			--root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git') or cwd
--local util = require 'lspconfig/util'
--local cwd = vim.loop.cwd
--SetTsServerCWD = function()
    --return 	 util.root_pattern('package.json', 'tsconfig.json', '.git') or cwd
--end




---------------------------------------------------------------------------------------
--[[
    __  __  ______    __  ___    __
   / / / / /_  __/   /  |/  /   / /
  / /_/ /   / /     / /|_/ /   / /
 / __  /   / /     / /  / /   / /___
/_/ /_/   /_/     /_/  /_/   /_____/
--]]


-- NOTE: Install via npm `npm install -g vscode-html-languageserver-bin`
lsp.html.setup{
    on_attach = custom_attach,
    on_init = custom_init,
    capabilities = custom_capabilities(), --enable snippet support
    cmd = { "html-languageserver", "--stdio" },
    root_dir = vim.loop.cwd,
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      }
    }

}




---------------------------------------------------------------------------------------
--[[
   ______   _____   _____
  / ____/  / ___/  / ___/
 / /       \__ \   \__ \
/ /___    ___/ /  ___/ /
\____/   /____/  /____/
--]]
-- lsp.cssls.setup{on_attach = custom_attach}



---------------------------------------------------------------------------------------
--[[
       __   _____   ____     _   __
      / /  / ___/  / __ \   / | / /
 __  / /   \__ \  / / / /  /  |/ /
/ /_/ /   ___/ / / /_/ /  / /|  /
\____/   /____/  \____/  /_/ |_/
--]]
lsp.jsonls.setup{on_attach = custom_attach, on_init = custom_init, root_dir = cwd}




---------------------------------------------------------------------------------------
--[[
    ____    __  __   _____  ______
   / __ \  / / / /  / ___/ /_  __/
  / /_/ / / / / /   \__ \   / /
 / _, _/ / /_/ /   ___/ /  / /
/_/ |_|  \____/   /____/  /_/
--]]
--NOTE: Must install rust-analyzer first and add it to your path
--$ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-mac -o ~/.local/bin/rust-analyzer
--$ chmod +x ~/.local/bin/rust-analyzer

---------------------------------------------------------------------------------------
--[[
       __
      / /___ __   ______ _
 __  / / __ `/ | / / __ `/
/ /_/ / /_/ /| |/ / /_/ /
\____/\__,_/ |___/\__,_/
--]]


--NOTE: NOT WORKING
--lsp.jdtls.setup{}
--lsp.jdtls.setup {on_attach = custom_attach,
                    --root_dir = cwd
--}

	  --configs.jdtls.handlers == {
      --['client/registerCapability'] = function(_, _, _, _)
        --return {
          --result = nil;
          --error = nil;
        --}
      --end
  --},

		--root_dir = lsp.util.root_pattern('.git', 'pom.xml', 'build.xml')

--local root_pattern = lsp.util.root_pattern

--lsp.jdtls.setup{
	--root_dir = root_pattern(".git"),
	--on_attach = custom_attach,
	--capabilities = capabilities,
--}

--local function root_patterns(...)
	--local searchers = {}

	--for _, patterns in ipairs({...}) do
		--local searcher = root_pattern(unpack(patterns))
		--searchers[#searchers + 1] = searcher
	--end

	--return function(startpath)
		--for _, searcher in ipairs(searchers) do
			--local root = searcher(startpath)
			--if root then return root end
		--end
	--end
--end

-- LANG CONFS
require("lsp._lua")
-- require( 'lsp._lsp')




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
-- NOTE: Below is just some stuff I will keep for review later / found interesting
--local configs = require('lspconfig/configs')

		--root_dir = vim.loop.cwd


--lsp.sumneko_lua.setup {on_attach = custom_attach,
			--root_dir = vim.loop.cwd --Sets global cwd
--}


--handlers = {
      --['client/registerCapability'] = function(_, _, _, _)
        --return {
          --result = nil;
          --error = nil;
        --}
      --end
    --}


--another lua config that does not work either
--lsp.sumneko_lua.setup{
	--on_attach=custom_attach,
	--settings = {
		--Lua = {
			--runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
			--completion = { keywordSnippet = "Enable", },
			--diagnostics = { enable = true, globals = {
				--"vim", "describe", "it", "before_each", "after_each" },
			--},
			--workspace = {
				--library = {
					--[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					--[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				--}
			--}
		--}
	--}
--}

--inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
--inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

--set completeopt=menuone,noinsert,noselect

--" Avoid showing message extra message when using completion
--set shortmess+=c
--
--








--lsp.sumneko_lua.setup{}
--lsp.sumneko_lua.setup{on_attach=custom_attach}


--local function lsp_setup()
	--require('completion').on_attach()
	--require('diagnostic').on_attach()
--end

--for lsp_key, lsp_settings in pairs({
	--[[ NOTE: Normally, more LSPs would go here. ]]
	--['jdtls'] = { --------------------------- Java
		--['root_dir'] = lsp.util.root_pattern('.git', 'pom.xml', 'build.xml'),
		--['init_options'] = {
			--['jvm_args'] = {['java.format.settings.url'] = vim.fn.stdpath('config')..'/eclipse-formatter.xml'},
			--['workspace'] = vim.fn.stdpath('cache')..'/java-workspaces'
		--}
	--},
--}) do -- Setup all of the language servers.
	--[[ NOTE: Normally, there are more cases being handled. ]]
	--local on_attach_setting = lsp_settings.on_attach

	--lsp_settings.on_attach = function()
		--lsp_setup()
		--if on_attach_setting then on_attach_setting() end
	--end

	--lsp[lsp_key].setup(lsp_settings)
--end



--[[
	/*
	 * Imports
	 */
--]]

--local completion = require('completion')
--local lspconfig  = require('lspconfig')
--local vim = vim
--local fn  = vim.fn

--[[
	/*
	 * Pre-load data
	 */
--]]

--local OS_NAME = vim.loop.os_uname()['sysname']
--local ON_WINDOWS = fn.has('win32') == 1

--local paths = {
	--['HOME_DIR'] = ON_WINDOWS and fn.environ()['userprofile']
		--or fn.environ()['HOME'],
	--['lsp'] = {}
--}
--paths.REPO_DIR = paths.HOME_DIR..'Repos/'
--paths.lsp.LUA  = paths.REPO_DIR..'lua-language-server/'
--paths.lsp.LUA_BIN = ON_WINDOWS and 'lua-language-server.exe' or 'lua-language-server'
--paths.lsp.C_SHARP = paths.HOME_DIR..'.cache/omnisharp-vim/omnisharp-roslyn/'
--paths.lsp.VIM_SCRIPT = paths.REPO_DIR..'vim-language-server/'

--[[
	/*
	 * Config
	 */
--]]

 --Configure the diagnostics
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	--vim.lsp.diagnostic.on_publish_diagnostics,
	--{
		--signs = true,
		--virtual_text =
		--{
			--prefix = '‹!›',
			--spacing = 1
		--},
	--}
--)

 --Configure the exclusion pattterns
--local exclude_patterns = {
	--'**/node_modules/**/*',
	--'**/bin/**/*',
	--'**/obj/**/*',
	--'/tmp/**/*'
--}

--local function setup_lsp() -- † Add chain completion
	--local ft = vim.bo.ft

	--if not vim.g.completion_chain_complete_list[ft] then
		--vim.g.completion_chain_complete_list = vim.tbl_extend('keep',
			--vim.g.completion_chain_complete_list,
			--{[ft] = vim.g.lsp_chain_complete_list}
		--)
	--end

	--completion.on_attach()
--end -- ‡

--for index, lsp in pairs({
	--'bashls', ------------------------------- Bash
	--['omnisharp'] = ------------------------- C#
	--{ -- †
		--['cmd'] = {paths.lsp.C_SHARP..(ON_WINDOWS and 'omnisharp/OmniSharp.exe' or 'run'), '-lsp'},
		--['filetypes'] = {'cache', 'cs', 'csproj', 'dll', 'nuget', 'props', 'sln', 'targets'},
		--['log_level'] = 2,
		--['root_dir'] = lspconfig.util.root_pattern('*.sln'),
		--['settings'] =
		--{
			--['FileOptions'] =
			--{
				--['ExcludeSearchPatterns'] = exclude_patterns,
				--['SystemExcludeSearchPatterns'] = exclude_patterns
			--},
			--['FormattingOptions'] =
			--{
				--['EnableEditorConfigSupport'] = true
			--},
			--['ImplementTypeOptions'] =
			--{
				--['InsertionBehavior'] = 'WithOtherMembersOfTheSameKind',
				--['PropertyGenerationBehavior'] = 'PreferAutoProperties'
			--},
			--['RenameOptions'] =
			--{
				--['RenameInComments'] = true,
				--['RenameInStrings']  = true,
				--['RenameOverloads']  = true
			--},
			--['RoslynExtensionsOptions'] =
			--{
				--['EnableAnalyzersSupport'] = true,
				--['EnableDecompilationSupport'] = true
			--}
		--}
	--}, -- ‡
	--'ccls', --------------------------------- C/C++/Objective-C
	--'cssls', -------------------------------- CSS / SCSS / LESS
	--'dartls', ------------------------------- Dart
	--'gopls', -------------------------------- Go
	--'html', --------------------------------- HTML
	--['jdtls'] = ----------------------------- Java
	--{ -- †
		--['root_dir'] = lspconfig.util.root_pattern('.git', 'pom.xml', 'build.xml'),
		--['init_options'] =
		--{
			--['jvm_args'] = {['java.format.settings.url'] = fn.stdpath('config')..'/eclipse-formatter.xml'},
			--['workspace'] = fn.stdpath('cache')..'/java-workspaces'
		--}
	--}, -- ‡
	--'jsonls', ------------------------------- JSON
	--'julials', ---------------------------- Julia
	--['sumneko_lua'] =  ---------------------- Lua
	--{ -- †
		--['cmd'] = {paths.lsp.LUA..'bin/'..OS_NAME..'/'..paths.lsp.LUA_BIN, '-E', '-W', paths.lsp.LUA..'main.lua'},
		--['settings'] =
		--{ ['Lua'] =
		--{
			--['diagnostics'] = {['globals'] = 'vim'},
			--['runtime'] =
			--{
				--['path'] = vim.split(package.path, ';'),
				--['version'] = 'LuaJIT',
			--},
			--['workspace'] =
			--{ ['library'] =
			--{
				--[fn.expand '$VIMRUNTIME/lua'] = true,
				--[fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true
			--}},
		--}}
	--}, -- ‡
	--'pyls_ms', ------------------------------ Python
	--'rust_analyzer', ------------------------ Rust
	--'sqlls',
	--'tsserver', ----------------------------- TypeScript
	--'texlab', ------------------------------- TeX
	--'vimls',
	--['vimls'] =  ---------------------------- Vimscript
	--{ -- †
		--['cmd'] = {'node', paths.lsp.VIM_SCRIPT..'out/index.js', "--stdio"},
	--}, -- ‡
	--'yamlls' -------------------------------- YAML
--}) do -- Setup all of the language servers. †
	--local uses_default_config = (type(index) == 'number')

	--if uses_default_config then -- Enable the LSP with defaults.
		 --The `lsp` is an index in this case.
		--lspconfig[lsp].setup{['on_attach'] = setup_lsp}
	--else -- Use the LSP's configuration.
		--local on_attach_setting = lsp.on_attach

		--lsp.on_attach = function()
			--setup_lsp()
			--if on_attach_setting then on_attach_setting() end
		--end

		--lspconfig[index].setup(lsp)
	--end
--end -- ‡


----------LINTER/DIAG INSPO
-- maybe switch to efm-language-server in the future
--[[  nvim_lsp.diagnosticls.setup{
    filetypes={'javascript', 'python', 'markdown'},
    init_options = {
      linters = {
        flake8 = {
          command = get_python_tool('flake8');
          args = {'--stdin-display-name'; '%filepath'; '-'};
          sourceName = 'flake8';
          debounce = 250;
          formatLines = 1;
          formatPattern = {'^[^:]+:(\\d+):((\\d+):)?\\s+(.+)$';
          {line = 1; column = 3; message = 4}};
          rootPatterns = {''};
        },
        eslint = {
          command = './node_modules/.bin/eslint',
          rootPatterns = {'.git'},
          debounce = 100,
          args = {
            '--stdin',
            '--stdin-filename',
            '%filepath',
            '--format',
            'json'
          },
          sourceName = 'eslint',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '${message} [${ruleId}]',
            security = 'severity'
          },
          securities = {
            [2] = 'error',
            [1] = 'warning',
          },
        },
        markdownlint = {
          command = 'markdownlint',
          rootPatterns = { '.git' },
          isStderr = true,
          debounce = 100,
          args = { '--stdin' },
          offsetLine = 0,
          offsetColumn = 0,
          sourceName = 'markdownlint',
          securities = {
            undefined = 'hint'
          },
          formatLines = 1,
          formatPattern = {
            '^.*:(\\d+)\\s+(.*)$',
            {
              line = 1,
              column = -1,
              message = 2,
            }
          }
        },
      },
      filetypes = {
        javascript = 'eslint',
        python = 'flake8',
        markdown = 'markdownlint',
      },
      formatters = {
        prettier = {
          command = "./node_modules/.bin/prettier",
          args = {"--stdin-filepath" ,"%filepath", '--single-quote', '--print-width 120'}
        }
      },
      formatFiletypes = {
        javascript = "prettier"
      },
    }
  }

  -- doesn't work, somehow
  nvim_lsp.angularls.setup{
    on_attach = on_attach
  }
end--]]
