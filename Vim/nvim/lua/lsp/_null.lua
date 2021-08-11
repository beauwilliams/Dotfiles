local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
    b.formatting.scalafmt,
    b.formatting.prettier.with({
        filetypes = { "html", "json", "yaml", "markdown" },
    }),
    b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file("stylua.toml")
        end,
    }),
    require("null-ls.helpers").conditional(function(utils)
        return utils.root_has_file(".eslintrc.js") and b.formatting.eslint_d or b.formatting.prettier
    end),
    --[[ b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
    b.formatting.shfmt,
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
    require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
