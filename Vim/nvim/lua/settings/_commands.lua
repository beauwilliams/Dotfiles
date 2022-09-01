--INFO: https://github.com/nanotee/nvim-lua-guide/blob/a118d6f585683a94364167d46274595b1959f089/README.md#defining-user-commands
local create_user_command = vim.api.nvim_create_user_command
local cmd = vim.cmd
local telescope_custom = require("plugins._telescope")
local telescope_builtin = require("telescope.builtin")
local nvim_lsp = vim.lsp.buf

create_user_command(
    "Hello",
    function(input)
        local args = input.args
        print("Hello " .. args)
    end,
    {bang = true, nargs = "*"}
)

create_user_command(
    "Upper",
    function()
    end,
    {
        nargs = 1,
        complete = function(ArgLead, CmdLine, CursorPos)
            -- return completion candidates as a list-like table
            return {"foo", "bar", "baz"}
        end
    }
)

create_user_command(
    "HighlightsUnderCursor",
    function(input)
        local args = input.args
        cmd("TSHighlightCapturesUnderCursor")
    end,
    {bang = false, nargs = 0, desc = "Highlights all captures under cursor"}
)

-- NOTE: LSP Commands
create_user_command(
    "LSPDiagnosticsList",
    function()
        telescope_builtin.diagnostics(require("telescope.themes").get_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "List diagnostics for the current workspace"
    }
)

local diagnostics_active = true --Enabled by default
create_user_command(
    "LSPDiagnosticsToggle",
    function()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
            vim.diagnostic.show()
            vim.notify("Showing Diagnostics", 2, {title = "Language Server"})
        else
            vim.diagnostic.hide()
            vim.notify("Hiding Diagnostics", 2, {title = "Language Server"})
        end
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Toggle neovim lsp in window diagnostics"
    }
)

create_user_command(
    "LSPSymbolsTree",
    function()
        vim.cmd [[SymbolsOutline]]
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Toggle symbols tree"
    }
)

create_user_command(
    "LSPCodeActionMenu",
    function()
        nvim_lsp.code_action()
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Toggle symbols tree"
    }
)
