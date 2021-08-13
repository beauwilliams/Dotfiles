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
  ["beacon.nvim"] = {
    config = { "\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/beacon.nvim"
  },
  ["cheat.sh-vim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/cheat.sh-vim"
  },
  ["compe-tabnine"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/compe-tabnine"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/delimitMate"
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
  gruvbox = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/guihua.lua"
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
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["navigator.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/navigator.lua"
  },
  neoformat = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nf\0\0\3\0\5\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\1\0009\0\4\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14lspconfig\vconfig\fnull-ls\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-compe"
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
  ["nvim-toggleterm.lua"] = {
    config = { 'require("toggleterm").setup{}' },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\ns\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0Bau FileType html let b:delimitMate_matchpairs = \"(:),[:],{:}\"\14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
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
  snap = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/snap"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["statusline.lua"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/statusline.lua"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-z.nvim"] = {
    config = { "\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\6z\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/telescope-z.nvim"
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
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n†\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0/ hi illuminatedCurWord cterm=none gui=noneF hi illuminatedWord guibg=#504648 guifg=none \"cterm=grey gui=grey\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/wilder.nvim"
  },
  ["zepl.vim"] = {
    config = { "\27LJ\2\nd\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0003            cnoreabbrev repl Repl\n            \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/zepl.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\vborder\vsingle\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: fuzzymenu.vim
time([[Config for fuzzymenu.vim]], true)
try_loadstring("\27LJ\2\n¡\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0è\1                let g:fuzzymenu_position =  'window'\n                let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                \14nvim_exec\bapi\bvim\0", "config", "fuzzymenu.vim")
time([[Config for fuzzymenu.vim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\ns\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0Bau FileType html let b:delimitMate_matchpairs = \"(:),[:],{:}\"\14nvim_exec\bapi\bvim\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: beacon.nvim
time([[Config for beacon.nvim]], true)
try_loadstring("\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0", "config", "beacon.nvim")
time([[Config for beacon.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
require("toggleterm").setup{}
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n†\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0/ hi illuminatedCurWord cterm=none gui=noneF hi illuminatedWord guibg=#504648 guifg=none \"cterm=grey gui=grey\bcmd\bvim\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: zepl.vim
time([[Config for zepl.vim]], true)
try_loadstring("\27LJ\2\nd\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0003            cnoreabbrev repl Repl\n            \14nvim_exec\bapi\bvim\0", "config", "zepl.vim")
time([[Config for zepl.vim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nf\0\0\3\0\5\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\1\0009\0\4\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14lspconfig\vconfig\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: telescope-z.nvim
time([[Config for telescope-z.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\6z\19load_extension\14telescope\frequire\0", "config", "telescope-z.nvim")
time([[Config for telescope-z.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
vim.g.indent_blankline_char = '‚îÇ'
time([[Config for indent-blankline.nvim]], false)
-- Config for: ale
time([[Config for ale]], true)
try_loadstring("\27LJ\2\n∞\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0˛\4                \"let g:ale_echo_msg_error_str = 'A'\n                \"let g:ale_echo_msg_warning_str = 'B'\n                \"let g:ale_echo_msg_hint_str = 'C'\n                \" I have some custom icons for errors and warnings but feel free to change them.\n                \"‚ö†\n                let g:ale_sign_error = '‚úò'\n                let g:ale_sign_warning = 'ÔÑ™'\n                \"let g:ale_sign_information = 'ÔÑ®'\n                \"let g:ale_sign_error = '‚óè'\n                \"let g:ale_sign_warning = '.'\n                \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                \14nvim_exec\bapi\bvim\0", "config", "ale")
time([[Config for ale]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
