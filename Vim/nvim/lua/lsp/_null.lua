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

local sources = {
	b.formatting.scalafmt, -- scala
	b.formatting.autopep8, -- python
	b.formatting.rustfmt, -- rust
	b.uncrustify, -- c, cpp, cs, java
	b.formatting.shfmt, -- bash
	b.formatting.prettierd, -- javascript, javascriptreact, typescript, typescriptreact, vue, svelte, css, scss, html, json, yaml, markdown
	b.formatting.stylua,
	-- if we want to only use stylua etc when stylua.toml file is in project etc.
	--[[ b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file("stylua.toml")
        end,
    }), ]]
	require('null-ls.helpers').conditional(function(utils)
		return utils.root_has_file('.eslintrc.js') and b.formatting.eslint_d or b.formatting.prettier
	end),
	--[[ b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
    b.diagnostics.write_good,
    b.diagnostics.markdownlint,
    b.diagnostics.teal,
    b.diagnostics.shellcheck,
    b.code_actions.gitsigns, ]]
}

local M = {}
M.setup = function(on_attach)
	null_ls.config({
		sources = sources,
	})
	require('lspconfig')['null-ls'].setup({ on_attach = on_attach })
end

return M
