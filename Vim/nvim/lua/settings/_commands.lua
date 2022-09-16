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



------------------------------------------------------------------------------------------------------------------------------------------------
-- PICKERS / SEARCH COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------
local function my_dropdown(opts)
    return require("plugins._telescope").my_dropdown({opts})
end

local telescope_file_search_opts = "hidden = true, find_command = {'rg', '--files', '--hidden', '--glob=!.git'}"
create_user_command(
    "MySearchFiles",
    function()
    require'telescope.builtin'.find_files(my_dropdown({telescope_file_search_opts}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for files"
    }
)

create_user_command(
    "MySearchFilesHistory",
    function()
    require'telescope.builtin'.oldfiles(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for files in history"
    }
)

create_user_command(
    "MySearchGrep",
    function()
    require'telescope.builtin'.live_grep(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for symbols using live grep"
    }
)

create_user_command(
    "MySearchBuffers",
    function()
    require'telescope.builtin'.buffers(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for buffers"
    }
)

create_user_command(
    "MySearchCommands",
    function()
    require'telescope.builtin'.commands(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for commands"
    }
)

create_user_command(
    "MySearchYankHistory",
    function()
      require('telescope').extensions.neoclip.default(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for yank history / clipboard"
    }
)

create_user_command(
    "MySearchGitFiles",
    function()
    require'telescope.builtin'.oldfiles(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for git files"
    }
)

create_user_command(
    "MySearchGitBranches",
    function()
    require'telescope.builtin'.git_branches(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for git branches"
    }
)

create_user_command(
    "MySearchProjects",
    function()
      require('telescope').extensions.projects.projects(my_dropdown({}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search for projects history"
    }
)

create_user_command(
    "MySearchDotfiles",
    function()
	require('telescope.builtin').find_files(my_dropdown({
		prompt_title = '< VimRC >',
		find_command={ 'rg', '--files'},
		search_dirs = { vim.fn.stdpath('config'), '~/.config/zsh/scripts', '~/.config/zsh/commands/', '~/.config/zsh/configs/' },
	}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search dotfiles nvim and zsh"
    }
)


local root_path_plugins = vim.fn.stdpath('data') .. '/site/pack/packer/'
create_user_command(
    "MySearchNvimPlugins",
    function()
require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({cwd = vim.fn.stdpath('data') .. '/site/pack/packer/', search_dirs = { root_path_plugins .. 'start/', root_path_plugins .. 'opt/' }}))
    end,
    {
        bang = false,
        nargs = 0,
        desc = "Search nvim plugins directory"
    }
)


------------------------------------------------------------------------------------------------------------------------------------------------
-- SPELL CHECK COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------

--SPELLING
-- NOTE: plgn is vim-you/autocorrect
-- Note we are using neovims built in spellcheck and dictionary
cmd('cnoreabbrev <silent>spell :set spell!<cr>')
cmd([[
    function SpellAuto()
    :EnableAutocorrect
    :set spell
    endfunction
    function SpellOff()
    :DisableAutocorrect
    :set nospell
    endfunction

]])
