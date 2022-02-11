------------------------------
----- INSTALL FORMATTERS -----
------------------------------
-- prettierd
-- npm i -g @fsouza/prettierd
------------------------------
--stylua (better than luafmt&luaformatter)
-- installed binary to my ~/.formatters path
-- from here: https://github.com/JohnnyMorganz/StyLua/releases
-- option to add stylua.toml
------------------------------

local null_ls = require('null-ls')
local b = null_ls.builtins

null_ls.setup({
	sources = {
		--FORMATTERS
		-- b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
		b.formatting.scalafmt, -- scala
		b.formatting.autopep8, -- python
		b.formatting.rustfmt, -- rust
		b.formatting.uncrustify, -- c, cpp, cs, java
		b.formatting.shfmt, -- bash
		b.formatting.prettierd, -- javascript, javascriptreact, typescript, typescriptreact, vue, svelte, css, scss, html, json, yaml, markdown
		b.formatting.clang_format, --filetypes = { "c", "cpp", "cs", "java" }
		b.formatting.stylua, --lua
		-- if we want to only use stylua etc when stylua.toml file is in project etc.
		--[[ b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file("stylua.toml")
        end,
    }), ]]

		--SPELL CHECK
		--[[ b.diagnostics.misspell,
	b.diagnostics.codespell,
	b.diagnostics.cspell, ]]
		b.diagnostics.shellcheck,

		--LINTERS
		require('null-ls.helpers').conditional(function(utils) --uses eslint fallback to prettier otherwise
			return utils.root_has_file('.eslintrc.js') and b.formatting.eslint_d or b.formatting.prettier
		end),
		-- b.diagnostics.write_good,
		-- b.diagnostics.markdownlint,

		-- b.diagnostics.teal,
		-- b.code_actions.gitsigns,
	},
})

-- Must be setup after config
-- require("lspconfig")["null-ls"].setup({})
