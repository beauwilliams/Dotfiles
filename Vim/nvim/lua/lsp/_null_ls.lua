local null_ls = safe_require('null-ls')
if not null_ls then
	return
end

local utils = safe_require('null-ls.utils').make_conditional_utils()
if not utils then
	return
end

local function setup_if_config_exist_in_root(ls, files, null_ls_utils)
	if null_ls_utils.root_has_file(files) then
		vim.defer_fn(function()
			vim.schedule(function()
				vim.notify(' Detected ' .. vim.inspect(files) .. ' in project root', 'info', { title = 'Null LS' })
			end)
		end, 1000)
		return ls.with({
			condition = function()
				return utils.root_has_file(files)
			end,
		})
	end
end

local builtins = null_ls.builtins

null_ls.setup({
	sources = {
		--------------------------------------------------------------------------------
		--FORMATTERS
		--------------------------------------------------------------------------------
		-- builtins.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
		builtins.formatting.scalafmt, -- scala
		builtins.formatting.autopep8, -- python
		builtins.formatting.rustfmt, -- rust
		builtins.formatting.uncrustify, -- c, cpp, cs, java
		builtins.formatting.shfmt, -- bash
		builtins.formatting.prettierd, -- javascript, javascriptreact, typescript, typescriptreact, vue, svelte, css, scss, html, json, yaml, markdown
		builtins.formatting.clang_format, --filetypes = { "c", "cpp", "cs", "java" }
		builtins.formatting.goimports, builtins.formatting.gofumpt, builtins.formatting.goimports_reviser, -- golang
		builtins.formatting.prettierd.with({
			extra_filetypes = { 'graphql', 'solidity' },
			condition = function()
				return utils.root_has_file({'.prettierrc', '.prettierrc.json'})
			end,
		}),
		builtins.formatting.stylelint.with({
			filetypes = { 'css', 'scss' },
			condition = function()
				return utils.root_has_file('.stylelintrc.json')
			end,
			command = './node_modules/.bin/stylelint',
		}),

		builtins.formatting.stylua.with({
			condition = function()
				return utils.root_has_file('stylua.toml')
			end,
		}),
		--[[ builtins.formatting.stylua.with({
			condition = function()
				return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
			end,
		}),
		function()
			return utils.root_has_file('.eslintrc.js') and builtins.formatting.eslint_d or builtins.formatting.prettierd
		end, ]]

		-- setup_if_config_exist_in_root(builtins.formatting.eslint_d, '.eslintrc.js', utils),
		-- setup_if_config_exist_in_root(builtins.formatting.prettierd, '.prettierrc.js', utils),
		-- setup_if_config_exist_in_root(builtins.formatting.stylua, { 'stylua.toml', '.stylua.toml' }, utils),




		--------------------------------------------------------------------------------
		-- DIAGNOSTICS
		--------------------------------------------------------------------------------
		-- builtins.diagnostics.golangci_lint,
		builtins.diagnostics.staticcheck,
		builtins.diagnostics.stylelint.with({
			filetypes = { 'css', 'scss', 'vue' },
			condition = function()
				return utils.root_has_file('.stylelintrc.json')
			end,
			command = './node_modules/.bin/stylelint',
		}),
		builtins.diagnostics.solhint.with({
			condition = function()
				return utils.root_has_file('solhint.json')
			end,
		}),
		-- builtins.diagnostics.write_good,
		-- builtins.diagnostics.markdownlint,
		-- builtins.diagnostics.teal,
		-- builtins.code_actions.gitsigns,




		--------------------------------------------------------------------------------
		--SPELL CHECK
		--------------------------------------------------------------------------------
		-- builtins.diagnostics.misspell, --not work well
		builtins.diagnostics.codespell, -- smart, but misses some
		-- builtins.diagnostics.cspell, -- good, errors everywhere
		builtins.diagnostics.shellcheck,



		--------------------------------------------------------------------------------
		--CODE ACTIONS
		--------------------------------------------------------------------------------
		builtins.code_actions.eslint_d, -- javascript, javascriptreact, typescript, typescriptreact, vue

	},
})
