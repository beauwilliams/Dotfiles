--TODO: Implement https://github.com/b0o/mapx.nvim
--Also add whichkey support

local utils = require('libraries._utils')
local leader = '<space>'
local g = vim.g
local api = vim.api
local cmd = vim.cmd

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--SET LEADER GLOBALLY
g.mapleader = ' '
-- REFACTOR VIM MAPPINGS QUICK
cmd([[nnoremap <leader>9 :ConvertMapToLua<CR>]])
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--VIM NAVIGATION MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
--Toggle between 0 and ^ with JUST 0 =D. Does not work well with wrap off and side scrolling..
-- vim.api.nvim_set_keymap('n', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})
--i've been using the shift key w my pinky so much lately its getting sore realised leader leader is free so its now an easy way to enter cmd mode
utils.map("n", leader..leader, ":")

--KOMMENTARY MAPPINGS, COMMENT WITH CMD+/
utils.nmap('++', '<Plug>kommentary_line_default')
utils.vmap('++', '<Plug>kommentary_visual_default')

-- F(ROM) and T(O) MAPPINGS
function repeat_ft(reverse)
	local ls = require('lightspeed')
	ls.ft['instant-repeat?'] = true
	ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>', { noremap = true, silent = true })

-- Keep selection when shifting
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })

-- Switch Between Buffers with backspace and retain cursor location and center to cursor
vim.api.nvim_set_keymap('n', '<bs>', '<c-^>`”zz', { silent = true, noremap = true })

--Bring search results to middle of screen, zv at end makes this compatible with folds
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

--whenever you're in parentheses, you can simple invoke dp or cp to wipe it's contents (same for brackets, but db or cb).
vim.api.nvim_set_keymap('o', 'b', 'i[|', { noremap = true })
vim.api.nvim_set_keymap('o', 'p', 'i(|', { noremap = true })

--PAGEUP/PAGEDN ONLY HALF PAGE AT A TIME
vim.api.nvim_set_keymap('', '<PageUp>', '<C-U>', { silent = true })
vim.api.nvim_set_keymap('', '<PageDown>', '<C-D>', { silent = true })

--Disable highlights when cursor moved
cmd([[autocmd cursormoved * set nohlsearch]])
vim.api.nvim_set_keymap('n', 'n', 'n:set hlsearch<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'N:set hlsearch<cr>', { noremap = true, silent = true })
-- Clear highlights quick! Removed for above
-- utils.nnoremap(leader .. "/", ":nohlsearch<cr>")

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

--TOGGLE AND INCREMENT NUMBERS EASILY
utils.nnoremap(leader .. '0', ':ToggleAlternate<cr>')
vim.cmd([[
    nmap <space>= <Plug>(dial-increment)
    nmap <space>- <Plug>(dial-decrement)
    vmap <space>= <Plug>(dial-increment)
    vmap <space>- <Plug>(dial-decrement)
]])

--FUZZYMENU (ctrl+p)
utils.nmap(leader .. 'p', '<Plug>(Fzm)')
utils.vmap(leader .. 'p', '<Plug>(FzmVisual)')

--FILE TREE
utils.nnoremap(leader .. 'n', ':NvimTreeToggle<cr>')
utils.vnoremap(leader .. 'n', ':NvimTreeToggle<cr>')

-- DOCUMENTATION GENERATION
utils.nnoremap(leader .. 'D', ':DogeGenerate<cr>')
utils.vnoremap(leader .. 'D', ':DogeGenerate<cr>')
vim.cmd([[cnoreabbrev dgen DogeGenerate]])

-- CODE FORMATTERS
--Remove indents from code! (a simple code formatter)
utils.nnoremap(leader .. 'i', 'gg=G<c-o>')
-- Run Neoformat
utils.nnoremap(leader .. 'F', ':Neoformat<CR>')
vim.cmd('cnoreabbrev fmt Neoformat')
vim.cmd('ca fmtlsp w <bar> lua vim.lsp.buf.formatting()')

-- SEARCH AND REPLACE
-- replace word under cursor
utils.nnoremap('R', ':%s/\\<<C-r><C-w>\\>//g<Left><Left><C-r><C-w>')
-- Replace/Delete words quick! ONE BY ONE.
-- c. c, d. d,
utils.nnoremap('c.', "/\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgn")
utils.nnoremap('c,', "?\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgN")
utils.nnoremap('d.', "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgn")
utils.nnoremap('d,', "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgN")

--TERMINAL MAPPINGS
-- utils.nnoremap(leader .. 't', '<CMD>lua require"neoterm".toggle()<CR>')
utils.nnoremap(leader .. 't', '<CMD>lua require"FTerm".toggle()<CR>')
utils.tnoremap(leader .. 't', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')
utils.tnoremap('<esc>', '<C-\\><C-n>')

--WINDOW NAVIGATION
local focusmap = function(direction)
	vim.api.nvim_set_keymap(
		'n',
		'<Leader>' .. direction,
		":lua require'focus'.split_command('" .. direction .. "')<CR>",
		{ silent = true }
	)
end
-- Use `<Leader>h` to split the screen to the left, same as command FocusSplitLeft etc
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

-- TODO: Implement utils fn into FOCUS to do natural resizing of windows like tmux etc
vim.cmd([[
	"leader-w for SPLIT CYCLING (cycle current windows)
"leader-W takes us anticlockwise
nnoremap <silent> <leader>w :FocusSplitCycle<CR>
vnoremap <silent> <leader>w :FocusSplitCycle<CR>
tnoremap <silent> <leader>w :FocusSplitCycle<CR>
nnoremap <silent> <leader>W :FocusSplitCycle reverse<CR>
vnoremap <silent> <leader>W :FocusSplitCycle reverse<CR>
tnoremap <silent> <leader>W :FocusSplitCycle reverse<CR>
"Resize our splits with <leader> ;/'/,/.- easily
nnoremap <silent> <Leader>. :exe "resize " . (winheight(0) * 5/3)<CR>
nnoremap <silent> <Leader>, :exe "resize " . (winheight(0) * 2/4)<CR>
nnoremap <silent> <leader>; :exe "vertical resize " . (winwidth(0) * 2/4)<CR>
nnoremap <silent> <leader>' :exe "vertical resize " . (winwidth(0) * 5/3)<CR>

" if nvim_win_get_width(window) > nvim_get_height(window)
    "this means its a horizontal split, so we can resize the height
    "
" else
    "this means its a vertical split, so we can resize the width
" endif
" nnoremap <silent> <leader>; :vertical resize -10<CR>
" nnoremap <silent> <leader>' :vertical resize +10<CR>
"CHANGE A SPLIT ORENTATION FROM HORIZONTAL TO VERTICAL AND VICE VERSA
nnoremap <silent><leader>[ <c-w>H
nnoremap <silent><leader>] <c-w>K
]])

--[[ utils.nnoremap(leader.."h", ":FocusSplitLeft<cr>")
utils.nnoremap(leader.."j", ":FocusSplitDown<cr>")
utils.nnoremap(leader.."k", ":FocusSplitUp<cr>")
utils.nnoremap(leader.."l", ":FocusSplitRight<cr>") ]]
--TAB/BUFFER CYCLING
--[[ utils.nnoremap("gt", ":WintabsNext<cr>")
utils.nnoremap("gT", ":WintabsPrevious<cr>") ]]
-- MISCELLANEOUS
-- utils.nnoremap("<leader>z", ":ToggleAlternate<cr>")
--[[ vim.cmd("cnoreabbrev swap ToggleAlternate")
vim.cmd("cnoreabbrev swapfile swap") ]]
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-- ABREVIATIONS
------------------------------------------------------------------------------------------------------------------------------------------------
--TOGGLE LIGHT/DARK THEME
cmd([[cnoreabbrev light lua vim.o.background = 'light']])
cmd([[cnoreabbrev dark lua vim.o.background = 'dark']])

--CHEATSHEAT
cmd([[cnoreabbrev cheat Cheatsheet]])
cmd([[cnoreabbrev cheatedit CheatsheetEdit]])

--SESSION MANAGEMENT (VIA STARTIFY)
vim.cmd([[
    cnoreabbrev mks SSave
    cnoreabbrev mksession SSave
    cnoreabbrev lds SLoad
    cnoreabbrev ldsession SLoad
    cnoreabbrev dls SDelete
    cnoreabbrev dlsession SDelete
]])

--SPELLING
-- NOTE: plgn is vim-you/autocorrect
-- Note we are using neovims built in spellcheck and dictionary
vim.cmd('cnoreabbrev <silent>spell :set spell!<cr>')
vim.cmd([[
    function SpellAuto()
        :EnableAutocorrect
        :set spell
    endfunction
    function SpellOff()
        :DisableAutocorrect
        :set nospell
    endfunction

]])
vim.cmd('cnoreabbrev <silent> spellauto exe SpellAuto()')
vim.cmd('cnoreabbrev <silent> spelloff exe SpellOff()')
vim.cmd('cnoreabbrev spelladd spell')

-- Enable use to write to ----READONLY---- files using --> w!! (i.e. Add an extra !)
-- utils.cnoremap('w!!', "<esc>:lua require'_utils'.sudo_write()<CR>")
vim.cmd('cnoreabbrev w!! lua require"libraries._utils".sudo_write()')
-- vim.cmd('cnoreabbrev w!! SudaWrite')

-- MARKDOWN RENDERER [glow.nvim]
vim.cmd('cnoreabbrev mdreader MarkdownPreview')

--  Saves the shift key I force quit a lot!
vim.cmd('cnoreabbrev qq q!')

--  zoxide vim and :y print command switching
vim.cmd('cnoreabbrev Z z')
vim.cmd('cnoreabbrev z Z')

-- FUGITIVE/GIT
vim.cmd('cnoreabbrev <silent>gp :G push')

--PACKER
cmd([[cnoreabbrev pc PackerCompile]])
cmd([[cnoreabbrev pi PackerInstall]])
cmd([[cnoreabbrev ps PackerSync]])
cmd([[cnoreabbrev pcl PackerClean]])
-- cmd('cnoreabbrev <silent>pf lua TelescopeMaps.installed_plugins()')

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--TELESCOPE MAPPINGS
-- OLD VERSION -- utils.vnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({hidden = true}))<cr>")
-- TESTING NEW VERSION WITH RG OPTS JUN2021 utils.nnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({hidden = true, find_command = {'rg', '--files', '--hidden', '--glob=!.git'}}))<cr>")

utils.nnoremap(
	leader .. 's',
	":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({hidden = true, find_command = {'rg', '--files', '--hidden', '--glob=!.git'}}))<cr>"
)
utils.vnoremap(
	leader .. 's',
	":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({hidden = true, find_command = {'rg', '--files', '--hidden', '--glob=!.git'}}))<cr>"
)
utils.nnoremap(
	leader .. 'S',
	":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.vnoremap(
	leader .. 'S',
	":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>"
)
--[[ utils.nnoremap(leader..'gf', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'gf', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>") ]]
utils.nnoremap(
	leader .. 'gb',
	":lua require('_telescope').git_branches(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.vnoremap(
	leader .. 'gb',
	":lua require('_telescope').git_branches(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.nnoremap(
	leader .. 'b',
	":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.vnoremap(
	leader .. 'b',
	":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.nnoremap(leader .. 'c', ":lua require'telescope.builtin'.commands()<cr>")
utils.vnoremap(leader .. 'c', ":lua require'telescope.builtin'.commands()<cr>")
utils.nnoremap(
	leader .. 'f',
	":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>"
)
utils.vnoremap(
	leader .. 'f',
	":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>"
)
cmd('cnoreabbrev <silent>tel Telescope')
cmd('cnoreabbrev <silent>clip Telescope neoclip')
cmd("cnoreabbrev <silent>gwa lua require('telescope').extensions.git_worktree.create_git_worktree()")
cmd("cnoreabbrev <silent>gwl lua require('telescope').extensions.git_worktree.git_worktrees()")
--[[ cmd("cnoreabbrev <silent>tmaps lua require'telescope.builtin'.keymaps(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>tbrowse lua require'telescope.builtin'.file_browser(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>tcomm lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>ttags lua require'telescope.builtin'.tags(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>tmarks lua require'telescope.builtin'.marks(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>tlocs lua require'telescope.builtin'.loclist(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>topts lua require'telescope.builtin'.options(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>tcmds lua require'telescope.builtin'.autocommands(require('telescope.themes').get_dropdown({}))")
cmd("cnoreabbrev <silent>thl lua require'telescope.builtin'.highlights(require('telescope.themes').get_dropdown({}))") ]]
_G.TelescopeMaps = {}
function TelescopeMaps.installed_plugins()
	require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
		winblend = 5,
		border = true,
		cwd = vim.fn.stdpath('data') .. '/site/pack/packer/start/',
	}))
end

function TelescopeMaps.dotfiles()
	require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
		winblend = 5,
		border = true,
		cwd = vim.fn.stdpath('config'),
	}))
end
-- vim.api.nvim_set_keymap("n", leader .. "2", ":lua TelescopeMaps.dotfiles()<cr>", {})
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
-- HOT KEYS
utils.nnoremap(
	leader .. 1,
	":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown({}))<CR>"
)

-- USING SNAP FOR NOW leader-2
--[[ utils.nnoremap(leader..'2', ":lua require('_telescope').search_dotfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'2', ":lua require('_telescope').search_dotfiles(require('telescope.themes').get_dropdown({}))<cr>") ]]
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
utils.nnoremap(leader .. '6', ':GitMessenger<CR>') -- "SHOW GIT COMMIT / GIT BLAME POPUP
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--LSP MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
utils.nnoremap('K', ':lua vim.lsp.buf.hover()<CR>')
-- vim.cmd[[autocmd CursorHold * silent :lua vim.lsp.buf.hover()]] -- NOTE: Auto open on hover
utils.nnoremap("'gd", ':lua vim.lsp.buf.definition()<CR>')
utils.nnoremap("'gr", ":lua require'telescope.builtin'.lsp_references()<CR>")
utils.nnoremap("'gs", ':Telescope lsp_workspace_symbols')
utils.nnoremap("'gw", ':lua vim.lsp.buf.workspace_symbol()<CR>')
utils.nnoremap("'rn", ':lua vim.lsp.buf.rename()<CR>')
utils.nnoremap("'ft", ':lua vim.lsp.buf.formatting()<CR>')
utils.nnoremap("'dn", ':lua vim.lsp.diagnostic.goto_next()<CR>')
utils.nnoremap("'dp", ':lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.nnoremap("'gh", ':lua vim.lsp.buf.signature_help()<CR>')
utils.nnoremap("'ca", ":lua require('jdtls').code_action()<CR>") -- NOTE: We need to use jdtls version, works wih other lsps find eg lua
utils.nnoremap("'gt", ':lua vim.lsp.buf.type_definition()<CR>')
utils.nnoremap("'gi", ':lua vim.lsp.buf.implementation()<CR>')
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-- COMPLETION/COQ MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
--NOTE: ,leader+tab is command to move to next snippet location
remap('n', leader .. '<tab>', '<c-h>', { noremap = false })

-- remap('i', '<cr>', [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.COQMaps = {}

COQMaps.CR = function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
			return npairs.esc('<c-y>')
		else
			return npairs.esc('<c-e>') .. npairs.autopairs_cr()
		end
	else
		return npairs.autopairs_cr()
	end
end
remap('i', '<cr>', 'v:lua.COQMaps.CR()', { expr = true, noremap = true })

COQMaps.BS = function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
		return npairs.esc('<c-e>') .. npairs.autopairs_bs()
	else
		return npairs.autopairs_bs()
	end
end
remap('i', '<bs>', 'v:lua.COQMaps.BS()', { expr = true, noremap = true })

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

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
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.COQMaps.tab_complete()', { expr = true }) ]]
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
--TREESITTER MAPPINGS
------------------------------------------------------------------------------------------------------------------------------------------------
--smart_rename = "'rn",
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

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
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--NOTE: ARCHIVE
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
local snap = require('snap')
local config = require('snap.config')
local file = config.file:with({ reverse = true, suffix = ' »', layout = snap.get('layout').center })
-- local vimgrep = config.vimgrep:with {limit = 50000, suffix = " »"}
-- local args = {"--hidden", "--iglob", "!**/.git/*", "--iglob", "!**/.baks/*", "--iglob", "!**/.langservers/*", "--iglob", "!**/.undo/*", "--iglob", "!**/.session/*", "--iglob", "!**/coc/**","--ignore-case", "--follow",}
local args = {
	'--follow',
	'--hidden',
	'-g',
	'!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*',
}

snap.maps({
	--[[{
    '<leader>s', file {
      try = {
        snap.get('producer.git.file').args({'--cached', '--others', '--exclude-standard'}),
        snap.get('producer.ripgrep.file').args({"--follow", "--hidden", "-g", "!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*"}),
      },
      prompt = 'Files',
    },
  }, ]]
	-- {"<Leader>f", vimgrep {prompt = "Grep"},{command =  "grep"}},
	-- {"<Leader>S", file {producer = "vim.oldfile", prompt = "History"},{command =  "history"}},
	-- {"<Leader>b", file {producer = "vim.buffer", prompt = "Buffers"},{command =  "buffers"}},
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
})
--[[ {"<Leader>df", vimgrep {
      args = args,
      {snap.get'consumer.combine'(
      snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/nvim"),
      snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/zsh")
      )},
      prompt = "Grep Dotfiles"
  },{command =  "grep dotfiles"}}, ]]
-- }

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
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

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true}) ]]
