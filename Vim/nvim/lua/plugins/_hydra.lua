local Hydra = safe_require('hydra')
local cmd = safe_require('hydra.keymap-util').cmd
local diag = safe_require('lspsaga.diagnostic')
local code_outline = safe_require('aerial')

if not Hydra or not cmd or not diag or not code_outline then
    return
end

-- NOTE: inspo
-- https://github.com/zakharykaplan/dotfiles/blob/7153f0196529f55985238f986f9ec2700b526e06/apps/nvim/lua/plugins/hydra.lua
-- https://github.com/mintelm/dotfiles/blob/b7044cd1b6d4e0956c67242027492a0d2133e65b/nvim/lua/mm/plugins/config/hydra.lua


-- NOTE: For key mappings we use this
Hydra.spawn = function(head)
    if head == "Hydra_Telescope" then
        Hydra_Telescope:activate()
    end
    if head == "Hydra_Options" then
        Hydra_Options:activate()
    end
    if head == "Hydra_Window" then
        Hydra_Window:activate()
    end
end

local hint_telescope =
    [[

		  _f_: files       _m_: marks
	  ▄▀  _o_: old files   _g_: live grep
 █▀▀▀█▀█  _p_: projects    _/_: search in file
  ▀▄░▄▀   _r_: resume      _u_: undotree
	█     _h_: vim help    _c_: execute command
  ▄▄█▄▄   _k_: keymaps     _;_: commands history
		  _O_: options     _?_: search history
		  _q_: quit        _x_: git status

		  _<Enter>_: Telescope			_<Esc>_:Quit^   ^
]]

Hydra_Telescope =
    Hydra(
    {
        name = "Telescope",
        hint = hint_telescope,
        config = {
            color = "teal",
            invoke_on_body = true,
            hint = {
                position = "middle",
                border = "rounded"
            }
        },
        mode = "n",
        -- body = '<Leader>f',
        heads = {
            {"f", cmd "Telescope find_files"},
            {"g", cmd "Telescope live_grep"},
            {"o", cmd "Telescope oldfiles", {desc = "recently opened files"}},
            {"h", cmd "Telescope help_tags", {desc = "vim help"}},
            {"m", cmd "MarksListBuf", {desc = "marks"}},
            {"k", cmd "Telescope keymaps"},
            {"O", cmd "Telescope vim_options"},
            {"r", cmd "Telescope resume"},
            {"p", cmd "Telescope projects", {desc = "projects"}},
            {"/", cmd "Telescope current_buffer_fuzzy_find", {desc = "search in file"}},
            {"?", cmd "Telescope search_history", {desc = "search history"}},
            {";", cmd "Telescope command_history", {desc = "command-line history"}},
            {"c", cmd "Telescope commands", {desc = "execute command"}},
            {"x", cmd "Telescope git_status", {desc = "git status"}},
            {"u", cmd "silent! %foldopen! | UndotreeToggle", {desc = "undotree"}},
            {"<Enter>", cmd "Telescope", {exit = true, desc = "list all pickers"}},
            {"<Esc>", nil, {exit = true, nowait = true}},
            {"q", nil, {exit = true, nowait = true}}
        }
    }
)

local hint_options =
    [[

^                  ^  ^ ^ ^^^^Options                    ^
^⠀⠀⠀⢀⣴⣷⡀⠀⠀⠀⠀⠀⢸⣦⡀⠀⠀⠀^  ^ ^ ^^^^^                          ^
^⠀⠀⡐⣿⣿⣿⣿⣄⠀⠀⠀⠀⢸⣿⣿⣦⡀⠀^  _v_ %{ve}^^^ virtual edit          ^
^⠀⢸⠈⢎⢿⣿⣿⣿⣦⠀⠀⠀⢸⣿⣿⣿⡇⠀^  _i_ %{list}^ invisible characters  ^
^⠀⢸⠀⠀⠢⡻⣿⣿⣿⣷⡀⠀⢸⣿⣿⣿⡇⠀^  _s_ %{spell} spell                 ^
^⠀⢸⠀⠀⠀⡇⠙⣿⣿⣿⣿⣄⢸⣿⣿⣿⡇⠀^  _w_ %{wrap}^ wrap                  ^
^⠀⢸⠀⠀⠀⡇⠀⠈⢿⣿⣿⣿⣮⢻⣿⣿⡇⠀^  _c_ %{cul}^^ cursor line           ^
^⠀⢸⠀⠀⠀⡇⠀⠀⠀⠻⣿⣿⣿⣷⡹⣿⡇⠀^  _n_ %{nu}^^^ number                ^
^⠀⠈⠢⡀⠀⡇⠀⠀⠀⠀⠙⣿⣿⣿⣿⠜⠁⠀^  _r_ %{rnu}^^ relative number       ^
^⠀⠀⠀⠈⠢⡇⠀⠀⠀⠀⠀⠈⢿⠟⠁⠀⠀⠀^  ^ ^ ^^^^^                          ^
^                  ^      ^^^^^               _q_: exit  ^
]]

Hydra_Options =
    Hydra(
    {
        name = "Options",
        hint = hint_options,
        config = {
            color = "amaranth",
            invoke_on_body = true,
            hint = {
                border = "rounded",
                position = "middle"
            }
        },
        mode = {"n", "x"},
        body = "<leader>o",
        heads = {
            {
                "n",
                function()
                    if vim.o.number == true then
                        vim.o.number = false
                    else
                        vim.o.number = true
                    end
                end,
                {desc = "number"}
            },
            {
                "r",
                function()
                    if vim.o.relativenumber == true then
                        vim.o.relativenumber = false
                    else
                        vim.o.number = true
                        vim.o.relativenumber = true
                    end
                end,
                {desc = "relativenumber"}
            },
            {
                "v",
                function()
                    if vim.o.virtualedit == "all" then
                        vim.o.virtualedit = "block"
                    else
                        vim.o.virtualedit = "all"
                    end
                end,
                {desc = "virtualedit"}
            },
            {
                "i",
                function()
                    if vim.o.list == true then
                        vim.o.list = false
                    else
                        vim.o.list = true
                    end
                end,
                {desc = "show invisible"}
            },
            {
                "s",
                function()
                    if vim.o.spell == true then
                        vim.o.spell = false
                    else
                        vim.o.spell = true
                    end
                    -- NOTE: exit on submit
                    -- end, { exit = true, desc = 'spell' } },
                end,
                {desc = "spell"}
            },
            {
                "w",
                function()
                    if vim.o.wrap ~= true then
                        vim.o.wrap = true
                        -- Dealing with word wrap:
                        -- If cursor is inside very long line in the file than wraps
                        -- around several rows on the screen, then 'j' key moves you to
                        -- the next line in the file, but not to the next row on the
                        -- screen under your previous position as in other editors. These
                        -- bindings fixes this.
                        vim.keymap.set(
                            "n",
                            "k",
                            function()
                                return vim.v.count > 0 and "k" or "gk"
                            end,
                            {expr = true, desc = "k or gk"}
                        )
                        vim.keymap.set(
                            "n",
                            "j",
                            function()
                                return vim.v.count > 0 and "j" or "gj"
                            end,
                            {expr = true, desc = "j or gj"}
                        )
                    else
                        vim.o.wrap = false
                        vim.keymap.del("n", "k")
                        vim.keymap.del("n", "j")
                    end
                end,
                {desc = "wrap"}
            },
            {
                "c",
                function()
                    if vim.o.cursorline == true then
                        vim.o.cursorline = false
                    else
                        vim.o.cursorline = true
                    end
                end,
                {desc = "cursor line"}
            },
            {"<Esc>", nil, {exit = true, desc = false}},
            {"<CR>", nil, {exit = true, desc = false}},
            {"q", nil, {exit = true, desc = false}}
        }
    }
)

Hydra_Window =
    Hydra(
    {
        name = "Change / Resize Window",
        mode = {"n"},
        body = "<leader>8",
        config = {},
        heads = {
            -- move between windows
            {"<C-h>", "<C-w>h"},
            {"<C-j>", "<C-w>j"},
            {"<C-k>", "<C-w>k"},
            {"<C-l>", "<C-w>l"},
            -- resizing window
            {"H", "<C-w>3<"},
            {"L", "<C-w>3>"},
            {"K", "<C-w>2+"},
            {"J", "<C-w>2-"},
            -- equalize window sizes
            {"e", "<C-w>="},
            -- close active window
            {"Q", ":q<cr>"},
            {"<C-q>", ":q<cr>"},
            -- exit this Hydra
            {"q", nil, {exit = true, nowait = true}},
            {";", nil, {exit = true, nowait = true}},
            {"<Esc>", nil, {exit = true, nowait = true}}
        }
    }
)

local hint_actions =
    [[

					     Actions
 ⠀⠀⠀⢀⣴⣷⡀⠀⠀⠀⠀⠀⢸⣦⡀⠀⠀⠀
 ⠀⠀⡐⣿⣿⣿⣿⣄⠀⠀⠀⠀⢸⣿⣿⣦⡀⠀   _t_: Telescope   _m_: marks
 ⠀⢸⠈⢎⢿⣿⣿⣿⣦⠀⠀⠀⢸⣿⣿⣿⡇⠀   _o_: Options     _g_: live grep
 ⠀⢸⠀⠀⠢⡻⣿⣿⣿⣷⡀⠀⢸⣿⣿⣿⡇⠀   _p_: projects    _/_: search in file
 ⠀⢸⠀⠀⠀⡇⠙⣿⣿⣿⣿⣄⢸⣿⣿⣿⡇⠀   _r_: resume      _u_: undotree
 ⠀⢸⠀⠀⠀⡇⠀⠈⢿⣿⣿⣿⣮⢻⣿⣿⡇⠀   _h_: vim help    _c_: execute command
 ⠀⢸⠀⠀⠀⡇⠀⠀⠀⠻⣿⣿⣿⣷⡹⣿⡇⠀   _k_: keymaps     _;_: commands history
 ⠀⠈⠢⡀⠀⡇⠀⠀⠀⠀⠙⣿⣿⣿⣿⠜⠁⠀   _O_: options     _?_: search history
 ⠀⠀⠀⠈⠢⡇⠀⠀⠀⠀⠀⠈⢿⠟⠁⠀⠀	  _q_: quit⠀

                      _<Enter>_: Telescope      _<Esc>_: Quit^  ^
]]

Hydra_Actions =
    Hydra(
    {
        name = "Action",
        hint = hint_actions,
        config = {
            color = "teal",
            invoke_on_body = true,
            hint = {
                position = "middle",
                border = "rounded"
            }
        },
        mode = "n",
        body = "<Leader>a",
        heads = {
            {"t", cmd 'lua require"hydra".spawn("Hydra_Telescope")', {desc = "Fuzzy search and pickers"}},
            {"o", cmd 'lua require"hydra".spawn("Hydra_Options")', {desc = "Neovim options"}},
            {"g", cmd "Telescope live_grep"},
            {"h", cmd "Telescope help_tags", {desc = "vim help"}},
            {"m", cmd "MarksListBuf", {desc = "marks"}},
            {"k", cmd "Telescope keymaps"},
            {"O", cmd "Telescope vim_options"},
            {"r", cmd "Telescope resume"},
            {"p", cmd "Telescope projects", {desc = "projects"}},
            {"/", cmd "Telescope current_buffer_fuzzy_find", {desc = "search in file"}},
            {"?", cmd "Telescope search_history", {desc = "search history"}},
            {";", cmd "Telescope command_history", {desc = "command-line history"}},
            {"c", cmd "Telescope commands", {desc = "execute command"}},
            {"u", cmd "silent! %foldopen! | UndotreeToggle", {desc = "undotree"}},
            {"<Enter>", cmd "Telescope", {exit = true, desc = "list all pickers"}},
            {"<Esc>", nil, {exit = true, nowait = true}},
            {"q", nil, {exit = true, nowait = true}}
        }
    }
)

local hint_lsp =
    [[
^                                  ^[LSP]

 ⠀⠀⠀⢀⣴⣷⡀⠀⠀⠀⠀⠀⢸⣦⡀⠀⠀⠀    _d_: Next Diagnostic        _D_: Prev Diagnostic
 ⠀⠀⡐⣿⣿⣿⣿⣄⠀⠀⠀⠀⢸⣿⣿⣦⡀⠀    _e_: Toggle Diagnostics     _E_: List Diagnostics
 ⠀⢸⠈⢎⢿⣿⣿⣿⣦⠀⠀⠀⢸⣿⣿⣿⡇⠀    _s_: Next Symbol            _S_: Prev Symbol
 ⠀⢸⠀⠀⠢⡻⣿⣿⣿⣷⡀⠀⢸⣿⣿⣿⡇⠀    _t_: Toggle Symbol Outline  _T_: Toggle Symbol Tree
 ⠀⢸⠀⠀⠀⡇⠙⣿⣿⣿⣿⣄⢸⣿⣿⣿⡇⠀    _r_: Rename                 _f_: Format
  ⢸⠀⠀⠀⡇⠀⠈⢿⣿⣿⣿⣮⢻⣿⣿⡇     _a_: Code Action            _h_: Hover Doc
  ⢸⠀⠀⠀⡇⠀⠀⠀⠻⣿⣿⣿⣷⡹⣿⡇     _g_: Preview Definitions    _G_: Go To Definition    ⠀⠀
  ⠈⠢⡀⠀⡇⠀⠀⠀⠀⠙⣿⣿⣿⣿⠜⠁                                     ⠀⠀
⠀⠀  ⠈⠢⡇⠀⠀⠀⠀⠀⠈⢿⠟⠁⠀⠀
                 ⠀⠀    _q_: Quit                   _<Esc>_: Quit^           ^

]]

for _, value in pairs({",", ",d", ",D", ",s"}) do
    Hydra(
        {
            hint = hint_lsp,
            name = "LSP Hydra",
            config = {
                invoke_on_body = true,
                color = "pink",
                hint = {
                    position = "bottom",
                    border = "rounded"
                },
                on_enter = function()
                    if value == ",d" then
                        -- diag.goto_next()
                        vim.cmd [[lua vim.diagnostic.goto_next({float = false})]]
                    elseif value == ",D" then
                        -- diag.goto_prev()
                        vim.cmd [[lua vim.diagnostic.goto_prev({float = false})]]
                    elseif value == ",s" then
                        code_outline.open()
                    end
                end,
                on_exit = function()
                    -- NOTE: Schedule to prevent conflicts set/unset keymaps with plugins
                    vim.schedule(function()

                    code_outline.close()
                    vim.cmd[[SymbolsOutlineClose]]
                    end)
                end
            },
            mode = {"n"},
            body = value,
            heads = {
                {"r", cmd "Lsp rename", {desc = "Rename Symbols", exit = true}},
                {"T", cmd "MyLSPSymbolsTree", {desc = "Toggle Symbols Tree"}},
                {"g", cmd "Lspsaga lsp_finder", {desc = "Preview References"}},
                {"G", cmd "Lsp definition", {desc = "Go To Definition"}},
                {"e", cmd "MyLSPDiagnosticsToggle", {desc = "Toggle Diagnostics"}},
                {"E", cmd "MyLSPDiagnosticsList", {desc = "List Diagnostics"}},
                {"h", cmd "Lspsaga hover_doc", {desc = "Hover Doc"}},
                {"f", cmd "Lsp format", {desc = "Format Code", exit = true}},
                --[[ {"j", action.smart_scroll_with_saga(-1), {desc = "Scroll Up"}},
                {"k", action.smart_scroll_with_saga(1), {desc = "Scroll Down"}}, ]]
                -- {"<Enter>", cmd "Lspsaga lsp_finder", {desc = "Preview References"}},
                {"<Esc>", nil, {exit = true, nowait = true}},
                {"q", nil, {exit = true, nowait = true}},
                {
                    "d",
                    function()
                        vim.diagnostic.goto_next({float = false})
                    end
                },
                {
                    "D",
                    function()
                        vim.diagnostic.goto_prev({float = false})
                    end
                },
                {
                    "s",
                            code_outline.next()
                },
                {
                    "S",
                            code_outline.next(-1)
                },
                {
                    "t",
                    function()
                            if code_outline.is_open() then
                                code_outline.close()
                            else
                                code_outline.open()
                            end
                    end
                },
                {
                    "a",
                    function()
                            vim.cmd [[LSPCodeActionMenu]]
                        return "<Ignore>"
                    end,
                    {exit = false, nowait = true}
                },
                {
                    "q",
                    nil,
                    {exit = true, nowait = true}
                }
            }
        }
    )
end

local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

local hint_dap =
    [[
 _b_: toggle breakpoint _c_: run/continue  _r_: open repl
 _o_: step over         _i_: step into     _B_: breakpoint condition
 _L_: log point         _R_: run last      _e_: eval
 ^                      _q_: exit
]]

if dap_ok and dapui_ok then
    Hydra(
        {
            hint = hint_dap,
            name = "DAP Hydra",
            config = {
                invoke_on_body = true,
                color = "pink",
                hint = {
                    position = "top-right",
                    border = "rounded"
                },
                on_enter = function()
                    dapui.open()
                end,
                on_exit = function()
                    dap.terminate()
                    dapui.close()
                end
            },
            mode = {"n"},
            body = "<C-D>",
            heads = {
                {
                    "b",
                    dap.toggle_breakpoint
                },
                {
                    "B",
                    function()
                        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                    end
                },
                {
                    "L",
                    function()
                        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                    end
                },
                {
                    "c",
                    dap.continue
                },
                {
                    "o",
                    dap.step_over
                },
                {
                    "i",
                    dap.step_into
                },
                {
                    "r",
                    dap.repl.open
                },
                {
                    "R",
                    dap.run_last
                },
                {
                    "e",
                    dapui.eval
                },
                {
                    "q",
                    nil,
                    {exit = true, nowait = true}
                }
            }
        }
    )
end

--[[ Hydra({
   config = {
	  invoke_on_body = true,
	  hint = {
		 position = 'middle',
		 border = 'rounded',
	  },
},
name = 'Side scroll',
   mode = 'n',
   body = '<Leader>7',
   heads = {
	  { 'h', '5zh' },
	  { 'l', '5zl', { desc = '←/→' } },
	  { 'H', 'zH' },
	  { 'L', 'zL', { desc = 'half screen ←/→' } },
   }
}) ]]


--NOTE: Quick case changing
--[[ local head = function(key, operator_name, desc)
    return {
        key,
        function()
            require("textcase").operator(operator_name)
        end,
        { desc = desc },
    }
end

hydra({
    config = {
        exit = true,
    },
    name = "Change case",
    mode = "n",
    body = "gyc",
    heads = {
        head("_", "to_snake_case", "snake_case"),
        head("-", "to_dash_case", "dash-case"),
        head("C", "to_constant_case", "CONSTANT_CASE"),
        head(".", "to_dot_case", "dot.case"),
        head("c", "to_camel_case", "camelCase"),
        head("t", "to_title_case", "Title Case"),
        head("/", "to_path_case", "path/case"),
        head("s", "to_phrase_case", "Sentence case"),
        head("m", "to_pascal_case", "MixedCase"),

        { "<Esc>", nil, { exit = true } },
    },
}) ]]
