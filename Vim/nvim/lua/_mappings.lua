local leader = "<space>"
local utils = require('_utils')

--TELESCOPE MAPPINGS
utils.nnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'sg', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'sg', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'g', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'g', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")

utils.nnoremap(leader..'5', ":Startify<cr>")
utils.vnoremap(leader..'5', ":Startify<cr>")
utils.nnoremap(leader..'4', ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'4', ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'3', ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>")
utils.vnoremap(leader..'3', ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>")
utils.nnoremap(leader..'2', ":lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'2', ":lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>")
utils.noremap('',leader..'1', ":lua require'telescope.builtin'.builtin()<cr>")

--KOMMENTARY MAPPINGS
vim.api.nvim_set_keymap('n', '++', '<Plug>kommentary_line_default', { silent = true })

--LSP MAPPINGS
-- NOTE: Close quickfix with :cclose
utils.nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
utils.nnoremap("'gd", ":lua vim.lsp.buf.definition()<CR>")
utils.nnoremap("'gr", ":lua require'telescope.builtin'.lsp_references()<CR>")
utils.nnoremap("'gs",':lua vim.lsp.buf.document_symbol()<CR>')
utils.nnoremap("'gw",':lua vim.lsp.buf.workspace_symbol()<CR>')
utils.nnoremap("'rn", ":lua vim.lsp.buf.rename()<CR>")
utils.nnoremap("'ft", ":lua vim.lsp.buf.formatting()<CR>")
utils.nnoremap("'dn", ':lua vim.lsp.diagnostic.goto_next()<CR>')
utils.nnoremap("'dp", ':lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.nnoremap("'gh",':lua vim.lsp.buf.signature_help()<CR>')
utils.nnoremap("'ca", ":lua vim.lsp.buf.code_action()<CR>")

utils.nnoremap("'gt",':lua vim.lsp.buf.type_definition()<CR>')
utils.nnoremap("'gi", ":lua vim.lsp.buf.implementation()<CR>")



--ARCHIVE
-- Move cursor to the next and previous diagnostic
-- utils.nnoremap("gp", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- utils.nnoremap('gp', '<cmd>lua vim.lsp.buf.definition()<CR>')--:lua vim.lsp.diagnostic.goto_prev()
-- Keybindings for LSPs
-- utils.nnoremap('gd', 'vim.lsp.buf.definition()')
-- utils.nnoremap('gh', 'vim.lsp.buf.hover()')
-- utils.nnoremap('gD', 'vim.lsp.buf.implementation()')
-- mavim.lsp.diagnostic.goto_prev<CR>pper('gr',':lua vim.lsp.buf.references()')
--fn.nvim_set_keymap("n", "<leader>ge", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>gt", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
--fn.nvim_set_keymap("n", "<a-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true, silent = true})
--vim.api.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

