local M = {}
local vim_fn = vim.fn
local api = vim.api
local dap  = require('dap')
dap.adapters.python = {
      type = 'executable';
      command = 'python';
      args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
  },
}
dap.adapters.cpp = {
    type = 'executable',
    name = "cppdbg",
    command = "lldb-vscode",
    args = {},
    attach = {
        pidProperty = "processId",
        pidSelect = "ask"
    }
}

local function build_cpp()
    local file_name = vim_fn.expand('%:p')
    local file_name_no_extension = vim_fn.expand('%:p:r')
    vim_fn.system('g++ '..file_name..' -g -std=c++11 -D LOCAL_SYS -o '..file_name_no_extension)
end

dap.configurations.cpp  = {
    {
        type = "cpp",
        name = "run_file",
        request = "launch",
        program = function ()
            build_cpp()
            return vim_fn.expand('%:p:r')
        end,
        args = {},
        cwd = vim_fn.getcwd(),
        externalConsole = false,
        MIMode ="gdb",
        MIDebuggerPath = "gdb"
    }
}

local dap_keymap = {
    n = {
        ["dc"] = 'continue()',
        ["db"] = 'toggle_breakpoint()',
        ["dB"] = "toggle_breakpoint(vim.fn.input('Breakpoint condition: '))",
        ["dr"] = "repl.open()",
        ["dR"] = "restart()",
        ["dl"] = "repl.run_last()",
        ["di"] = "step_into()",
        ["do"] = "step_over()",
        ["dO"] = "step_out()",
    }
}

local function set_keymap()
    for mode,map in pairs(dap_keymap) do
        for k,v in pairs(map) do
            api.nvim_buf_set_keymap(0, mode , "<leader>"..k, '<cmd>lua require"dap".'..v..'<CR>', {
                    nowait = true, noremap = true, silent = true
                })
        end
    end
end

function M.on_attach()
    set_keymap()
end
return M
