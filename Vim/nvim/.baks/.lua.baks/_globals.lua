-- NOTE: DEPRECATED, USE _settings instead
local set_globals = function(globals)
    for key, value in pairs(globals) do
        vim.g[key] = value
    end
end

-- TODO: [beauwilliams] --> Implement
local global_settings = {
    -- mapleader = " ",
}

set_globals(global_settings)
