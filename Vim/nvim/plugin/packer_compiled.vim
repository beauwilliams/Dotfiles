" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, err = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(err)
  end
end

_G.packer_plugins = {
  ["FTerm.nvim"] = {
    config = { "\27LJ\2\n∫\2\0\0\6\0\16\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\r\0'\3\n\0'\4\14\0005\5\15\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\0023<C-\\><C-n><CMD>lua require\"FTerm\".toggle()<CR>\6t\1\0\2\fnoremap\2\vsilent\2)<CMD>lua require\"FTerm\".toggle()<CR>\14<leader>t\6n\20nvim_set_keymap\afn\bvim\vborder\1\0\0\1\0\1\rvertical\b‚îÇ\nsetup\nFTerm\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/FTerm.nvim"
  },
  ale = {
    config = { "\27LJ\2\n÷\4\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0§\4                    let g:ale_echo_msg_error_str = 'E'\n                    let g:ale_echo_msg_warning_str = 'W'\n                    \" I have some custom icons for errors and warnings but feel free to change them.\n                    \"let g:ale_sign_error = '‚úò'\n                    \"let g:ale_sign_warning = '‚ö†'\n                    let g:ale_sign_error = '‚óè'\n                    let g:ale_sign_warning = '.'\n                    \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["beacon.nvim"] = {
    config = { "\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/beacon.nvim"
  },
  ["fuzzymenu.vim"] = {
    config = { "\27LJ\2\nÕ\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0õ\1                    let g:fuzzymenu_position =  'window'\n                    let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/fuzzymenu.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  indentLine = {
    config = { "\27LJ\2\nÆ\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0K\0\1\0\1\3\0\0\ttext\rmarkdown\31indentLine_fileTypeExclude\1\3\0\0\thelp\rterminal\30indentLine_bufTypeExclude\b‚îÇ\20indentLine_char\6g\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  kommentary = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-bufdel"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-bufdel"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lspfuzzy"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/quick-scope"
  },
  ["statusline.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/statusline.lua"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-cheat40"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-cheat40"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-doge"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-doge"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-misc"
  },
  ["vim-polyglot"] = {
    config = { "\27LJ\2\nk\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\2\0=\1\3\0K\0\1\0&vim_markdown_new_list_item_indent\28javascript_plugin_jsdoc\6g\bvim\0" },
    loaded = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/vim-polyglot"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-session"] = {
    config = { "\27LJ\2\nì\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0·\5                    \"keep all sessions in one location\n                    let g:session_directory='~/.config/nvim/.session'\n                    \"remove .vim from end of files so it looks nicer in startify\n                    let g:session_extension=''\n                    \"Remove pop-up each time we close to ask to save session\n                    let g:session_autosave = 'no'\n                    \"If I want to load a session I will specify it. We also have a start page\n                    \"which displays recent sessions too so not need to auto load them\n                    let g:session_autoload = 'no'\n                    cnoreabbrev mks SaveSession\n                    cnoreabbrev mksession SaveSession\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-session"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-signify"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-superman"] = {
    config = { "\27LJ\2\nr\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0A                    cnoreabbrev man Man\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-superman"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vim-you-autocorrect"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-you-autocorrect"
  },
  ["zepl.vim.git"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/zepl.vim.git"
  }
}

-- Setup for: quick-scope
try_loadstring("\27LJ\2\nÑ\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0“\4                    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                    augroup qs_colors\n                    autocmd!\n                    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                    augroup END\n                    \14nvim_exec\bapi\bvim\0", "setup", "quick-scope")
vim.cmd [[packadd quick-scope]]
-- Setup for: vim-polyglot
try_loadstring("\27LJ\2\n<\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\thelm\22polyglot_disabled\6g\bvim\0", "setup", "vim-polyglot")
-- Config for: indentLine
try_loadstring("\27LJ\2\nÆ\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0K\0\1\0\1\3\0\0\ttext\rmarkdown\31indentLine_fileTypeExclude\1\3\0\0\thelp\rterminal\30indentLine_bufTypeExclude\b‚îÇ\20indentLine_char\6g\bvim\0", "config", "indentLine")
-- Config for: ale
try_loadstring("\27LJ\2\n÷\4\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0§\4                    let g:ale_echo_msg_error_str = 'E'\n                    let g:ale_echo_msg_warning_str = 'W'\n                    \" I have some custom icons for errors and warnings but feel free to change them.\n                    \"let g:ale_sign_error = '‚úò'\n                    \"let g:ale_sign_warning = '‚ö†'\n                    let g:ale_sign_error = '‚óè'\n                    let g:ale_sign_warning = '.'\n                    \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                    \14nvim_exec\bapi\bvim\0", "config", "ale")
-- Config for: quick-scope
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "quick-scope")
-- Config for: FTerm.nvim
try_loadstring("\27LJ\2\n∫\2\0\0\6\0\16\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\r\0'\3\n\0'\4\14\0005\5\15\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\0023<C-\\><C-n><CMD>lua require\"FTerm\".toggle()<CR>\6t\1\0\2\fnoremap\2\vsilent\2)<CMD>lua require\"FTerm\".toggle()<CR>\14<leader>t\6n\20nvim_set_keymap\afn\bvim\vborder\1\0\0\1\0\1\rvertical\b‚îÇ\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
-- Config for: vim-superman
try_loadstring("\27LJ\2\nr\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0A                    cnoreabbrev man Man\n                    \14nvim_exec\bapi\bvim\0", "config", "vim-superman")
-- Config for: vim-session
try_loadstring("\27LJ\2\nì\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0·\5                    \"keep all sessions in one location\n                    let g:session_directory='~/.config/nvim/.session'\n                    \"remove .vim from end of files so it looks nicer in startify\n                    let g:session_extension=''\n                    \"Remove pop-up each time we close to ask to save session\n                    let g:session_autosave = 'no'\n                    \"If I want to load a session I will specify it. We also have a start page\n                    \"which displays recent sessions too so not need to auto load them\n                    let g:session_autoload = 'no'\n                    cnoreabbrev mks SaveSession\n                    cnoreabbrev mksession SaveSession\n                    \14nvim_exec\bapi\bvim\0", "config", "vim-session")
-- Config for: beacon.nvim
try_loadstring("\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0", "config", "beacon.nvim")
-- Config for: fuzzymenu.vim
try_loadstring("\27LJ\2\nÕ\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0õ\1                    let g:fuzzymenu_position =  'window'\n                    let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                    \14nvim_exec\bapi\bvim\0", "config", "fuzzymenu.vim")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-treesitter")
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-polyglot'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
