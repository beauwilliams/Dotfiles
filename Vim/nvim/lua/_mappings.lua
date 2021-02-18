local leader = "<space>"
local g = vim.g
local utils = require('_utils')
local api = vim.api

--SET LEADER GLOBALLY
g.mapleader = ' '

--TELESCOPE MAPPINGS
utils.nnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({hidden = true}))<cr>")
utils.vnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({hidden = true}))<cr>")
utils.nnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'G', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'G', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'f', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'f', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")

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
vim.api.nvim_set_keymap('v', '++', '<Plug>kommentary_visual_default', { silent = true })

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

--TERMINAL MAPPINGS
utils.nnoremap('<leader>t', '<CMD>lua require"FTerm".toggle()<CR>')
utils.tnoremap('<leader>t', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')

--COMPE MAPPINGS [COMPLETION]
--" Use <Tab> and <S-Tab> to navigate through popup menu
api.nvim_command('inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"')
api.nvim_command('inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"')
-- SET COMPE MAPPINGS --> DELIMITMATE COMPATIBLE FOR AUTO-CLOSING BRACES
api.nvim_command("inoremap <silent><expr> <C-Space> compe#complete()")
api.nvim_command("inoremap <silent><expr> <CR>      compe#confirm({ 'keys': '<Plug>delimitMateCR', 'mode': '' })")
api.nvim_command("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")

--TREESITTER MAPPINGS
--smart_rename = "'rn",





--TODO: REFACTOR
--[[ vim.api.nvim_set_keymap('i', '<C-=>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-=>"', { silent = true, expr = true })
vim.api.nvim_set_keymap('s', '<C-=>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-=>"', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-->', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-->"', { silent = true, expr = true })
vim.api.nvim_set_keymap('s', '<C-->', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-->"', { silent = true, expr = true }) ]]
--VSNIP, EXPAND, JUMP
--[[ imap <expr> <C-j> vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-j>"
imap <expr> <C-k> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)"      : "<C-k>"

VSNIP DISPLAY SNIPPETS
inoremap <silent> <C-s> <C-r>=SnippetsComplete()<CR>

function! SnippetsComplete() abort
    let wordToComplete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
    let fromWhere      = col('.') - len(wordToComplete)
    let containWord    = "stridx(v:val.word, wordToComplete)>=0"
    let candidates     = vsnip#get_complete_items(bufnr("%"))
    let matches        = map(filter(candidates, containWord),
                \  "{
                \      'word': v:val.word,
                \      'menu': v:val.kind,
                \      'dup' : 1,
                \   }")


    if !empty(matches)
        call complete(fromWhere, matches)
    endif

    return ""
endfunction
 ]]



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

