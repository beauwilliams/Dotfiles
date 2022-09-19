local utils = safe_require('libraries._set_mappings')
if not utils then
    return
end

local leader = '<space>'
local g = vim.g
--- @diagnostic disable-next-line: unused-local
local api = vim.api
local cmd = vim.cmd
local set_keymap = vim.keymap.set

------------------------------------------------------------------------------------------------------------------------------------------------
--SET LEADER GLOBALLY
------------------------------------------------------------------------------------------------------------------------------------------------
g.mapleader = ' '
-- REFACTOR VIM MAPPINGS QUICK
cmd([[nnoremap <leader>9 :ConvertMapToLua<CR>]])
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--VIM NAVIGATION MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
--i've been using the shift key w my pinky so much lately its getting sore realised leader leader is free so its now an easy way to enter cmd mode
utils.map('n', leader .. leader, ':')

--KOMMENTARY MAPPINGS, COMMENT WITH CMD+/
utils.nmap('++', '<Plug>kommentary_line_default')
utils.vmap('++', '<Plug>kommentary_visual_default')

--Toggle between 0 and ^ with JUST 0. Does not work well with wrap off and side scrolling..
set_keymap('n', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})

-- Keep selection when shifting
set_keymap('v', '>', '>gv', { noremap = true })
set_keymap('v', '<', '<gv', { noremap = true })

-- Switch Between Buffers with backspace and retain cursor location and center to cursor
set_keymap('n', '<bs>', '<c-^>zz', { silent = true, noremap = true })
-- set_keymap('n', '<bs>', '<c-^>\'"zz', { silent = true, noremap = true })

--Bring search results to middle of screen, zv at end makes this compatible with folds
set_keymap('n', 'n', 'nzzzv', { noremap = true })
set_keymap('n', 'N', 'Nzzzv', { noremap = true })

--whenever you're in parentheses, you can simple invoke dp or cp to wipe it's contents (same for brackets, but db or cb).
set_keymap('o', 'b', 'i[|', { noremap = true })
set_keymap('o', 'p', 'i(|', { noremap = true })

--PAGEUP/PAGEDN ONLY HALF PAGE AT A TIME
set_keymap('', '<PageUp>', '<C-U>', { silent = true })
set_keymap('', '<PageDown>', '<C-D>', { silent = true })

--Disable highlights when cursor moved, enable then on n/N
cmd([[autocmd cursormoved * set nohlsearch]])
set_keymap('n', 'n', 'n:set hlsearch<cr>', { noremap = true, silent = true })
set_keymap('n', 'N', 'N:set hlsearch<cr>', { noremap = true, silent = true })
-- Clear highlights quick! Removed for above
-- utils.nnoremap(leader .. "/", ":nohlsearch<cr>")

--Smart dd, don't replace yank register if deleting empty line in NORMAL MODE
local function smart_dd_normal()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end
--Smart dd, don't replace yank register if deleting empty line in VISUAL MODE
local function smart_dd_visual()
  local l, c = unpack(vim.api.nvim_win_get_cursor(0))
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, l - 1, l, true)) do
    if line:match("^%s*$") then
      return "\"_d"
    end
  end
  return "d"
end

set_keymap("v", "d", smart_dd_visual, { noremap = true, expr = true } )
set_keymap( "n", "dd", smart_dd_normal, { noremap = true, expr = true } )

--TODO: command refactor
--Insert lines above
set_keymap(
  'n',
  '<leader>o',
  ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
  { noremap = true, silent = true }
)
--Insert lines below
set_keymap(
  'n',
  '<leader>O',
  ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
  { noremap = true, silent = true }
)

-- Explanation: The 0 (Zero) register is special because it only stores the last item you yank and only if you yank it, not if you delete it with any of d,x,c,s.
-- We use this because we have the vim register synced with the system clipboard. Meaning we can't do simple text replacement easily as deleting text will overwrite yanked text in the register.
utils.nnoremap('yp', '0p')
utils.nnoremap('yP', '0P')

-- jj to escape quick yo... turns out there arent many words with jj in them if ya really need it... just type it slowly
utils.inoremap('jj', '<ESC>')

-- DITCH THOSE ARROW KEYS --> MOVE UP AND DOWN IN INSERT MODE WITH HJKL BY SIMPLY HOLDING CONTROL
utils.inoremap('<c-j>', '<esc>ji')
utils.inoremap('<c-k>', '<esc>ki')
utils.inoremap('<c-h>', '<esc>i')
utils.inoremap('<c-l>', '<esc>la')

--Better normal mode TAB
utils.nnoremap('<Tab>', 'w')
utils.nnoremap('<s-Tab>', 'b')

--TODO: command refactor
--TOGGLE AND INCREMENT NUMBERS, BOOLS ETC EASILY
set_keymap('n', '<leader>=', require('dial.map').inc_normal(), {})
set_keymap('n', '<leader>-', require('dial.map').dec_normal(), {})
set_keymap('v', '<leader>=', require('dial.map').inc_visual(), {})
set_keymap('v', '<leader>-', require('dial.map').dec_visual(), {})
--TODO: command refactor
--FILE TREE
utils.nnoremap(leader .. 'n', ':NvimTreeToggle<cr>')
utils.vnoremap(leader .. 'n', ':NvimTreeToggle<cr>')

--TODO: command refactor
-- DOCUMENTATION GENERATION
vim.cmd('let g:doge_enable_mappings=0') -- disable leader-d default
utils.nnoremap(leader .. 'D', ':DogeGenerate<cr>')
utils.vnoremap(leader .. 'D', ':DogeGenerate<cr>')
--TODO: ABBREVIATIONS refactor
vim.cmd([[cnoreabbrev dgen DogeGenerate]])

--TODO: command refactor
-- DIFFVIEW
utils.nnoremap(leader .. 'd', ':DiffviewOpen<cr>')
utils.vnoremap(leader .. 'd', ':DiffviewOpen<cr>')
--TODO: ABBREVIATIONS refactor
vim.cmd([[cnoreabbrev diff DiffviewOpen]])

--TODO: command refactor
-- GIT (MAGIT/NEOGIT/LazyGit)
utils.nnoremap(leader .. 'g', ':LazyGit<cr>')
utils.vnoremap(leader .. 'g', ':LazyGit<cr>')
--TODO: ABBREVIATIONS refactor
vim.cmd([[cnoreabbrev gd LazyGit]])
--api.nvim_add_user_command('LazyGitFloat', function()
--   require('FTerm').run({'lazygit'})
--end, { bang = true })


--TODO: ABBREVIATIONS refactor
--Fugitive Shortcut
vim.cmd([[cnoreabbrev git Git]])

--TODO: ABBREVIATIONS refactor
--Markdown Previwer
vim.cmd([[cnoreabbrev mdp MarkdownPreview]])


--TODO: command refactor
-- CODE FORMATTERS
--Remove indents from code! (a simple code formatter)
utils.nnoremap(leader .. 'i', 'gg=G<c-o>')
-- Run Neoformat
utils.nnoremap(leader .. 'F', ':Neoformat<CR>')
vim.cmd('cnoreabbrev fmt Neoformat')
vim.cmd('ca fmtlsp w <bar> lua vim.lsp.buf.formatting_sync()')

--TODO: command refactor
-- SEARCH AND REPLACE
-- replace word under cursor
utils.nnoremap(leader .. 'r', ':lua require("spectre").open()<cr>')
utils.vnoremap(leader .. 'r', ':lua require("spectre").open()<cr>')
utils.nnoremap('R', ':%s/\\<<C-r><C-w>\\>//g<Left><Left><C-r><C-w>')
-- Replace/Delete words quick! ONE BY ONE.
-- c. c, d. d,
utils.nnoremap('c.', "/\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgn")
utils.nnoremap('c,', "?\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgN")
utils.nnoremap('d.', "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgn")
utils.nnoremap('d,', "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgN")

-- NOTE: WINDOW NAVIGATION
-- leader-w for SPLIT CYCLING (cycle current windows)
-- leader-W takes us anticlockwise
set_keymap('n', '<Leader>k', ':FocusSplitUp<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>j', ':FocusSplitDown<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>h', ':FocusSplitLeft<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>l', ':FocusSplitRight<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>w', ':FocusSplitCycle<CR>', { noremap = true, silent = true})
set_keymap('n', '<Leader>W', ':FocusSplitCycle reverse<CR>', { noremap = true, silent = true})

-- Resize our splits with <leader> ;/'/,/.- easily
set_keymap("n", "<Leader>.", ":exe \"resize \" . (winheight(0) * 4/3)<CR>", { silent = true, noremap = true, })
set_keymap("n", "<Leader>,", ":exe \"resize \" . (winheight(0) * 3/4)<CR>", { silent = true, noremap = true, })
set_keymap("n", "<leader>;", ":exe \"vertical resize \" . (winwidth(0) * 3/4)<CR>", { silent = true, noremap = true, })
set_keymap("n", "<leader>'", ":exe \"vertical resize \" . (winwidth(0) * 4/3)<CR>", { silent = true, noremap = true, })

-- CHANGE A SPLIT ORENTATION FROM HORIZONTAL TO VERTICAL AND VICE VERSA
set_keymap("n", "<leader>[", "<c-w>H", { silent = true, noremap = true, })
set_keymap("n", "<leader>]", "<c-w>K", { silent = true, noremap = true, })



------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------









------------------------------------------------------------------------------------------------------------------------------------------------
--TERMINAL MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
utils.tnoremap('<esc>', '<C-\\><C-n>') --Allows escape key to work correctly
-- utils.nnoremap(leader .. 't', '<CMD>lua require"FTerm".toggle()<CR>')
-- utils.tnoremap(leader .. 't', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')
--TODO: command refactor
utils.nnoremap(leader .. 'T', '<CMD>1Ttoggle<CR>') --NOTE: this has bug uysing toggle
set_keymap("n", "<leader>t", ":MyTermRunTaskCommand<CR>",{})
vim.cmd[[let g:neoterm_default_mod='botright vnew']]
vim.cmd[[let g:neoterm_keep_term_open=0]]
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------








-- INCREMENTAL SEARCH UI
--[[ set_keymap(
  'n',
  '/',
  '<cmd>lua require("searchbox").incsearch()<CR>',
  {noremap = true}
) ]]
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------









--TODO: command refactor
------------------------------------------------------------------------------------------------------------------------------------------------
-- HOT KEYS
------------------------------------------------------------------------------------------------------------------------------------------------
set_keymap('n', '<leader>2', ':MySearchDotfiles<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>2', ':MySearchDotfiles<CR>', { noremap = true, silent = true })
utils.nnoremap(
  leader .. 1,
  ":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown({}))<CR>"
)

utils.nnoremap(
  leader .. '3',
  ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>"
)
utils.vnoremap(
  leader .. '3',
  ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>"
)
utils.nnoremap(
  leader .. '4',
  ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.vnoremap(
  leader .. '4',
  ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.nnoremap(leader .. '5', ':Startify<cr>')
utils.vnoremap(leader .. '5', ':Startify<cr>')
-- utils.nnoremap(leader .. '6', ':GitMessenger<CR>') -- "SHOW GIT COMMIT / GIT BLAME POPUP
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------









------------------------------------------------------------------------------------------------------------------------------------------------
--TELESCOPE MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
set_keymap('n', '<leader>s', ':MySearchFiles<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>s', ':MySearchFiles<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>S', ':MySearchFilesHistory<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>S', ':MySearchFilesHistory<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>f', ':MySearchGrep<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>f', ':MySearchGrep<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>b', ':MySearchBuffers<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>b', ':MySearchBuffers<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>c', ':MySearchCommands<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>c', ':MySearchCommands<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>y', ':MySearchYankHistory<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>y', ':MySearchYankHistory<CR>', { noremap = true, silent = true })
--[[ set_keymap('n', '<leader>g', ':MySearchGitFiles<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>g', ':MySearchGitFiles<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>b', ':MySearchGitBranches<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>b', ':MySearchGitBranches<CR>', { noremap = true, silent = true }) ]]
set_keymap('n', '<leader>p', ':MySearchProjects<CR>', { noremap = true, silent = true })
set_keymap('v', '<leader>p', ':MySearchProjects<CR>', { noremap = true, silent = true })
--TODO: ABBREVIATIONS refactor
cmd('cnoreabbrev <silent>tel Telescope')
cmd("cnoreabbrev <silent>gwa lua require('telescope').extensions.git_worktree.create_git_worktree()")
cmd("cnoreabbrev <silent>gwl lua require('telescope').extensions.git_worktree.git_worktrees()")
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------











--TODO: command refactor
------------------------------------------------------------------------------------------------------------------------------------------------
--LSP MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
--Hover actions
-- vim.cmd[[autocmd CursorHold * silent :lua require'lspsaga.diagnostic'.show_cursor_diagnostics()]] -- NOTE: Auto open on hover
-- vim.cmd[[autocmd CursorHold * silent :lua vim.lsp.buf.hover()]] -- NOTE: Auto open on hover

--  Shortcut Actions
--[[ utils.nnoremap(',h', ':lua require("lspsaga.hover").render_hover_doc()<CR>')
utils.nnoremap(",'", ':lua vim.lsp.diagnostic.goto_next()<CR>')
utils.nnoremap(',;', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.nnoremap(
  ',c',
  ":lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_dropdown({}))<CR>"
)
utils.nnoremap(',r', ':lua vim.lsp.buf.rename()<CR>')
utils.nnoremap(',f', ':lua vim.lsp.buf.formatting()<CR>')
-- Search Actions
utils.nnoremap(',g', ':lua vim.lsp.buf.definition()<CR>')
utils.nnoremap(',R', ":lua require'telescope.builtin'.lsp_references()<CR>")
utils.nnoremap(',w', ":lua require'telescope.builtin'.workspace_symbols()<CR>")
utils.nnoremap(',d', ":lua require'telescope.builtin'.document_symbols()<CR>")
-- utils.nnoremap(',s', ':lua vim.lsp.buf.signature_help()<CR>')
utils.nnoremap(',t', ':lua vim.lsp.buf.type_definition()<CR>')
utils.nnoremap(',i', ':lua vim.lsp.buf.implementation()<CR>') ]]

--Archived
-- utils.nnoremap(".c", ":lua require('jdtls').code_action()<CR>") -- NOTE: We need to use jdtls version, works with other lsps fine eg lua

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------









--TODO: command refactor
------------------------------------------------------------------------------------------------------------------------------------------------
--TREESITTER MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
--smart_rename = "'rn",
set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', { noremap = true })
set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------









--TODO: command refactor
------------------------------------------------------------------------------------------------------------------------------------------------
--TOOLWINDOW/TROUBLE/QUICKFIX/LOCLIST MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
utils.nnoremap(leader .. 'qq', ':lua require("toolwindow").close()<cr>')
utils.nnoremap(leader .. 'qd', ':lua require("toolwindow").open_window("trouble", nil)<cr>')
utils.nnoremap(leader .. 'qf', ':lua require("toolwindow").open_window("quickfix", nil)<cr>')
utils.nnoremap(leader .. 'qt', ':lua require("toolwindow").open_window("term", nil)<cr>')
utils.nnoremap(leader .. 'qc', ':lua require("toolwindow").open_window("todo", nil)<cr>')
-- utils.nnoremap(leader..'qc', ':TodoTrouble<cr>')
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------













------------------------------------------------------------------------------------------------------------------------------------------------
--ARCHIVED MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-- COMPLETION/COQ MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
--local remap = set_keymap
--local npairs = require('nvim-autopairs')
--
--npairs.setup({ map_bs = false })
--
--vim.g.coq_settings = { keymap = { recommended = false } }
--
---- these mappings are coq recommended mappings unrelated to nvim-autopairs
--remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
--remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
--remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
--remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
----NOTE: ,leader+tab is command to move to next snippet location
--remap('n', leader .. '<tab>', '<c-h>', { noremap = false })
--
---- remap('i', '<cr>', [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]], { expr = true, noremap = true })
--
---- skip it, if you use another global object
--_G.COQMaps = {}
--
--COQMaps.CR = function()
--  if vim.fn.pumvisible() ~= 0 then
--    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
--      return npairs.esc('<c-y>')
--    else
--      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
--    end
--  else
--    return npairs.autopairs_cr()
--  end
--end
--remap('i', '<cr>', 'v:lua.COQMaps.CR()', { expr = true, noremap = true })
--
--COQMaps.BS = function()
--  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
--    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
--  else
--    return npairs.autopairs_bs()
--  end
--end
--remap('i', '<bs>', 'v:lua.COQMaps.BS()', { expr = true, noremap = true })
--
--local t = function(str)
--  return vim.api.nvim_replace_termcodes(str, true, true, true)
--end

--NOTE: Requires https://github.com/ms-jpq/coq_nvim/pull/249
--[[ COQMaps.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-n>')
  elseif _G.COQ.Marks_available() == true then
    return t('<C-h>')
  else
    return t('<Tab>')
  end
end
set_keymap('i', '<Tab>', 'v:lua.COQMaps.tab_complete()', { expr = true }) ]]
-- set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

--FUZZYMENU (ctrl+p)
-- utils.nmap(leader .. 'p', '<Plug>(Fzm)')
-- utils.vmap(leader .. 'p', '<Plug>(FzmVisual)')

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
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

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--SNAP MAPPINGS
--[[ local snap = require('snap')
local config = require('snap.config')
local file = config.file:with({ reverse = true, suffix = ' »', layout = snap.get('layout').center })
local vimgrep = config.vimgrep:with {limit = 50000, suffix = " »"}
local args = {"--hidden", "--iglob", "!**/.git/*", "--iglob", "!**/.baks/*", "--iglob", "!**/.langservers/*", "--iglob", "!**/.undo/*", "--iglob", "!**/.session/*", "--iglob", "!**/coc/**","--ignore-case", "--follow",}
local args = {
  '--follow',
  '--hidden',
  '-g',
  '!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*',
}

snap.maps({
  {
    '<leader>s', file {
      try = {
        snap.get('producer.git.file').args({'--cached', '--others', '--exclude-standard'}),
        snap.get('producer.ripgrep.file').args({"--follow", "--hidden", "-g", "!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*"}),
      },
      prompt = 'Files',
    },
  },
  {"<Leader>f", vimgrep {prompt = "Grep"},{command =  "grep"}},
  {"<Leader>S", file {producer = "vim.oldfile", prompt = "History"},{command =  "history"}},
  {"<Leader>b", file {producer = "vim.buffer", prompt = "Buffers"},{command =  "buffers"}},
  {
    '<Leader>2',
    file({
      args = args,
      try = {
        snap.get('consumer.combine')(
          snap.get('producer.ripgrep.file').args({}, '/Users/admin/.config/nvim'),
          snap.get('producer.ripgrep.file').args({}, '/Users/admin/.config/zsh')
        ),
      },
      prompt = 'Search Dotfiles',
    }),
    { command = 'search dotfiles' },
  },
  {"<Leader>df", vimgrep {
    args = args,
    {snap.get'consumer.combine'(
      snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/nvim"),
      snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/zsh")
    )},
    prompt = "Grep Dotfiles"
  },
    {command =  "grep dotfiles"}},
}) ]]

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--[[ set_keymap('i', '<C-=>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-=>"', { silent = true, expr = true })
set_keymap('s', '<C-=>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-=>"', { silent = true, expr = true })
set_keymap('i', '<C-->', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-->"', { silent = true, expr = true })
set_keymap('s', '<C-->', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-->"', { silent = true, expr = true }) ]]
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

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--COMPE MAPPINGS [COMPLETION]
--" Use <Tab> and <S-Tab> to navigate through popup menu
-- api.nvim_command('inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"')
-- api.nvim_command('inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"')
-- SET COMPE MAPPINGS --> DELIMITMATE COMPATIBLE FOR AUTO-CLOSING BRACES
--[[ api.nvim_command("inoremap <silent><expr> <C-Space> compe#complete()")
api.nvim_command("inoremap <silent><expr> <CR>      compe#confirm({ 'keys': '<Plug>delimitMateCR', 'mode': '' })")
api.nvim_command("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end

set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true}) ]]
