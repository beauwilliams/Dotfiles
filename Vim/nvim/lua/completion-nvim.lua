return function ()
vim.g.completion_chain_complete_list = {
    {
        complete_items = {"lsp", "snippet", "buffers"}
    },
    {
        mode = "<c-p>"
    },
    {
       mode = "<c-n>"
    }
}

vim.g.completion_enable_snippet = "vim-vsnip"
vim.g.completion_matching_ignore_case = true
--vim.cmd([[let g:completion_confirm_key = "\<C-y>"]]) NOT NEEDED, WE HAVE ALREADY MAPPED SPACE

vim.g.completion_items_priority = {
    Field = 5,
    Function = 7,
    Module = 7,
    Variables = 7,
    Method = 10,
    Interfaces = 5,
    Constant = 5,
    Class = 5,
    Keyword = 4,
    UltiSnips = 1,
    ["vim-vsnip"] = 5,
    Buffers = 1,
    TabNine = 0,
    File = 0
}
end

