local set_globals = function(globals)
    for key, value in pairs(globals) do
        vim.g[key] = value
    end
end

-- TODO(Implement)
local global_settings = {
    --map leader
    mapleader = " ",
}

set_globals(global_settings)
