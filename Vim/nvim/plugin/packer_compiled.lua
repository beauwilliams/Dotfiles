-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/admin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FTerm.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\vborder\vsingle\nsetup\nFTerm\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/FTerm.nvim"
  },
  ale = {
    config = { "\27LJ\2\n∞\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0˛\4                \"let g:ale_echo_msg_error_str = 'A'\n                \"let g:ale_echo_msg_warning_str = 'B'\n                \"let g:ale_echo_msg_hint_str = 'C'\n                \" I have some custom icons for errors and warnings but feel free to change them.\n                \"‚ö†\n                let g:ale_sign_error = '‚úò'\n                let g:ale_sign_warning = 'ÔÑ™'\n                \"let g:ale_sign_information = 'ÔÑ®'\n                \"let g:ale_sign_error = '‚óè'\n                \"let g:ale_sign_warning = '.'\n                \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["alternate-toggler"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/alternate-toggler"
  },
  ["beacon.nvim"] = {
    config = { "\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/beacon.nvim"
  },
  ["blamer.nvim"] = {
    config = { "\27LJ\2\n´\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\r%d/%m/%y\23blamer_date_format3<committer> ‚îÇ <summary> ‚îÇ <committer-time>\20blamer_template\19blamer_enabled\6g\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/blamer.nvim"
  },
  ["cheat.sh-vim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/cheat.sh-vim"
  },
  ["cheatsheet.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/cheatsheet.nvim"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["focus.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/focus.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["fuzzymenu.vim"] = {
    config = { "\27LJ\2\n¡\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0è\1                let g:fuzzymenu_position =  'window'\n                let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                \14nvim_exec\bapi\bvim\0" },
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
  ["git-worktree.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/git-worktree.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["indent-blankline.nvim"] = {
    config = { "vim.g.indent_blankline_char = '‚îÇ'" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["iswap.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/iswap.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  neorg = {
    config = { "\27LJ\2\n¬\2\0\0\a\0\17\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0004\4\0\0=\4\4\0035\4\6\0005\5\5\0=\5\a\4=\4\b\0034\4\0\0=\4\t\0035\4\r\0005\5\v\0005\6\n\0=\6\f\5=\5\a\4=\4\14\3=\3\16\2B\0\2\1K\0\1\0\tload\1\0\0\21core.norg.dirman\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace,~/Dropbox/Software Eng/Workspaces/Neorg\24core.norg.concealer\18core.keybinds\vconfig\1\0\0\1\0\2\17neorg_leader\14<Leader>o\21default_keybinds\2\18core.defaults\1\0\0\nsetup\nneorg\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/neorg"
  },
  ["numb.nvim"] = {
    config = { "require('numb').setup()" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/numb.nvim"
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
  ["nvim-hlslens"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-hlslens"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-jdtls"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-peekup"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-peekup"
  },
  ["nvim-toggleterm.lua"] = {
    config = { 'require("toggleterm").setup{}' },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_context_vt = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim_context_vt"
  },
  ["octo.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
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
    loaded = true,
    needs_bufread = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/quick-scope"
  },
  ["rest.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/rest.nvim"
  },
  snap = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/snap"
  },
  ["statusline.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/statusline.lua"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/suda.vim"
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
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["toolwindow.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/toolwindow.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/trouble.nvim"
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
    config = { "\27LJ\2\n†\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0/ hi illuminatedCurWord cterm=none gui=noneF hi illuminatedWord guibg=#504648 guifg=none \"cterm=grey gui=grey\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-misc"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\2\nó\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0\"let g:rooter_silent_chdir = 1Jlet g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-session"] = {
    config = { "\27LJ\2\në\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0ﬂ\5                \"keep all sessions in one location\n                let g:session_directory='~/.cache/nvim/.session'\n                \"remove .vim from end of files so it looks nicer in startify\n                let g:session_extension=''\n                \"Remove pop-up each time we close to ask to save session\n                let g:session_autosave = 'no'\n                \"If I want to load a session I will specify it. We also have a start page\n                \"which displays recent sessions too so not need to auto load them\n                let g:session_autoload = 'no'\n                cnoreabbrev restart RestartVim\n                cnoreabbrev mks SaveSession\n                cnoreabbrev mksession SaveSession\n                \14nvim_exec\bapi\bvim\0" },
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
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-you-autocorrect"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-you-autocorrect"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/wilder.nvim"
  },
  ["zepl.vim"] = {
    config = { "\27LJ\2\nd\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0003            cnoreabbrev repl Repl\n            \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/zepl.vim"
  },
  ["zoxide.vim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/zoxide.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: quick-scope
time([[Setup for quick-scope]], true)
try_loadstring("\27LJ\2\n‰\4\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0≤\4                highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                augroup qs_colors\n                autocmd!\n                autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                augroup END\n                \14nvim_exec\bapi\bvim\0", "setup", "quick-scope")
time([[Setup for quick-scope]], false)
time([[packadd for quick-scope]], true)
vim.cmd [[packadd quick-scope]]
time([[packadd for quick-scope]], false)
-- Config for: fuzzymenu.vim
time([[Config for fuzzymenu.vim]], true)
try_loadstring("\27LJ\2\n¡\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0è\1                let g:fuzzymenu_position =  'window'\n                let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                \14nvim_exec\bapi\bvim\0", "config", "fuzzymenu.vim")
time([[Config for fuzzymenu.vim]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
require('numb').setup()
time([[Config for numb.nvim]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\vborder\vsingle\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n†\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0/ hi illuminatedCurWord cterm=none gui=noneF hi illuminatedWord guibg=#504648 guifg=none \"cterm=grey gui=grey\bcmd\bvim\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
require("toggleterm").setup{}
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: ale
time([[Config for ale]], true)
try_loadstring("\27LJ\2\n∞\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0˛\4                \"let g:ale_echo_msg_error_str = 'A'\n                \"let g:ale_echo_msg_warning_str = 'B'\n                \"let g:ale_echo_msg_hint_str = 'C'\n                \" I have some custom icons for errors and warnings but feel free to change them.\n                \"‚ö†\n                let g:ale_sign_error = '‚úò'\n                let g:ale_sign_warning = 'ÔÑ™'\n                \"let g:ale_sign_information = 'ÔÑ®'\n                \"let g:ale_sign_error = '‚óè'\n                \"let g:ale_sign_warning = '.'\n                \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                \14nvim_exec\bapi\bvim\0", "config", "ale")
time([[Config for ale]], false)
-- Config for: vim-rooter
time([[Config for vim-rooter]], true)
try_loadstring("\27LJ\2\nó\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0\"let g:rooter_silent_chdir = 1Jlet g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']\bcmd\bvim\0", "config", "vim-rooter")
time([[Config for vim-rooter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
vim.g.indent_blankline_char = '‚îÇ'
time([[Config for indent-blankline.nvim]], false)
-- Config for: vim-session
time([[Config for vim-session]], true)
try_loadstring("\27LJ\2\në\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0ﬂ\5                \"keep all sessions in one location\n                let g:session_directory='~/.cache/nvim/.session'\n                \"remove .vim from end of files so it looks nicer in startify\n                let g:session_extension=''\n                \"Remove pop-up each time we close to ask to save session\n                let g:session_autosave = 'no'\n                \"If I want to load a session I will specify it. We also have a start page\n                \"which displays recent sessions too so not need to auto load them\n                let g:session_autoload = 'no'\n                cnoreabbrev restart RestartVim\n                cnoreabbrev mks SaveSession\n                cnoreabbrev mksession SaveSession\n                \14nvim_exec\bapi\bvim\0", "config", "vim-session")
time([[Config for vim-session]], false)
-- Config for: blamer.nvim
time([[Config for blamer.nvim]], true)
try_loadstring("\27LJ\2\n´\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\r%d/%m/%y\23blamer_date_format3<committer> ‚îÇ <summary> ‚îÇ <committer-time>\20blamer_template\19blamer_enabled\6g\bvim\0", "config", "blamer.nvim")
time([[Config for blamer.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: zepl.vim
time([[Config for zepl.vim]], true)
try_loadstring("\27LJ\2\nd\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0003            cnoreabbrev repl Repl\n            \14nvim_exec\bapi\bvim\0", "config", "zepl.vim")
time([[Config for zepl.vim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: beacon.nvim
time([[Config for beacon.nvim]], true)
try_loadstring("\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0", "config", "beacon.nvim")
time([[Config for beacon.nvim]], false)
-- Config for: neorg
time([[Config for neorg]], true)
try_loadstring("\27LJ\2\n¬\2\0\0\a\0\17\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0004\4\0\0=\4\4\0035\4\6\0005\5\5\0=\5\a\4=\4\b\0034\4\0\0=\4\t\0035\4\r\0005\5\v\0005\6\n\0=\6\f\5=\5\a\4=\4\14\3=\3\16\2B\0\2\1K\0\1\0\tload\1\0\0\21core.norg.dirman\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace,~/Dropbox/Software Eng/Workspaces/Neorg\24core.norg.concealer\18core.keybinds\vconfig\1\0\0\1\0\2\17neorg_leader\14<Leader>o\21default_keybinds\2\18core.defaults\1\0\0\nsetup\nneorg\frequire\0", "config", "neorg")
time([[Config for neorg]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
