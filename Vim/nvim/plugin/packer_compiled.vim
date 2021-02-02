" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif
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

_G.packer_plugins = {
  ["FTerm.nvim"] = {
    config = { "\27LJ\2\n∫\2\0\0\6\0\16\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\r\0'\3\n\0'\4\14\0005\5\15\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\0023<C-\\><C-n><CMD>lua require\"FTerm\".toggle()<CR>\6t\1\0\2\fnoremap\2\vsilent\2)<CMD>lua require\"FTerm\".toggle()<CR>\14<leader>t\6n\20nvim_set_keymap\afn\bvim\vborder\1\0\0\1\0\1\rvertical\b‚îÇ\nsetup\nFTerm\frequire\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/FTerm.nvim"
  },
  ale = {
    config = { "\27LJ\2\n÷\4\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0§\4                    let g:ale_echo_msg_error_str = 'E'\n                    let g:ale_echo_msg_warning_str = 'W'\n                    \" I have some custom icons for errors and warnings but feel free to change them.\n                    \"let g:ale_sign_error = '‚úò'\n                    \"let g:ale_sign_warning = '‚ö†'\n                    let g:ale_sign_error = '‚óè'\n                    let g:ale_sign_warning = '.'\n                    \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["beacon.nvim"] = {
    config = { "\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/beacon.nvim"
  },
  ["fuzzymenu.vim"] = {
    config = { "\27LJ\2\nÕ\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0õ\1                    let g:fuzzymenu_position =  'window'\n                    let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/fuzzymenu.vim"
  },
  fzf = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  gruvbox = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  indentLine = {
    config = { "\27LJ\2\nÆ\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0K\0\1\0\1\3\0\0\ttext\rmarkdown\31indentLine_fileTypeExclude\1\3\0\0\thelp\rterminal\30indentLine_bufTypeExclude\b‚îÇ\20indentLine_char\6g\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  kommentary = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  neoformat = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-compe"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-lspfuzzy"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["quick-scope"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/quick-scope"
  },
  rainbow = {
    config = { "\27LJ\2\n≈\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0ì\1                let g:rainbow_active = 1\n                \"set to 0 if you want to enable rainbow later via :RainbowToggle\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["statusline.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/statusline.lua"
  },
  ["vim-cheat40"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-cheat40"
  },
  ["vim-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-doge"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-doge"
  },
  ["vim-eunuch"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-illuminate"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-misc"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-misc"
  },
  ["vim-polyglot"] = {
    config = { "\27LJ\2\nk\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\2\0=\1\3\0K\0\1\0&vim_markdown_new_list_item_indent\28javascript_plugin_jsdoc\6g\bvim\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/vim-polyglot"
  },
  ["vim-rooter"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-session"] = {
    config = { "\27LJ\2\nì\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0·\5                    \"keep all sessions in one location\n                    let g:session_directory='~/.config/nvim/.session'\n                    \"remove .vim from end of files so it looks nicer in startify\n                    let g:session_extension=''\n                    \"Remove pop-up each time we close to ask to save session\n                    let g:session_autosave = 'no'\n                    \"If I want to load a session I will specify it. We also have a start page\n                    \"which displays recent sessions too so not need to auto load them\n                    let g:session_autoload = 'no'\n                    cnoreabbrev mks SaveSession\n                    cnoreabbrev mksession SaveSession\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-session"
  },
  ["vim-signify"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-signify"
  },
  ["vim-smoothie"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-startify"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-superman"] = {
    config = { "\27LJ\2\nr\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0A                    cnoreabbrev man Man\n                    \14nvim_exec\bapi\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-superman"
  },
  ["vim-surround"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vim-you-autocorrect"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/vim-you-autocorrect"
  },
  ["zepl.vim.git"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/start/zepl.vim.git"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = packer_plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

local packer_load = nil
local function handle_after(name, before)
  local plugin = packer_plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    packer_load({name}, {})
  end
end

packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if packer_plugins[name].commands then
      for _, cmd in ipairs(packer_plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if packer_plugins[name].keys then
      for _, key in ipairs(packer_plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if packer_plugins[name].config then
        for _i, config_line in ipairs(packer_plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if packer_plugins[name].after then
        for _, after_name in ipairs(packer_plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      packer_plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count ~= 0 and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    local escaped_keys = vim.api.nvim_replace_termcodes(cause.keys .. extra, true, true, true)
    vim.api.nvim_feedkeys(escaped_keys, 'm', true)
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

_packer_load_wrapper = function(names, cause)
  success, err_msg = pcall(packer_load, names, cause)
  if not success then
    vim.cmd('echohl ErrorMsg')
    vim.cmd('echomsg "Error in packer_compiled: ' .. vim.fn.escape(err_msg, '"') .. '"')
    vim.cmd('echomsg "Please check your config for correctness"')
    vim.cmd('echohl None')
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Setup for: vim-polyglot
loadstring("\27LJ\2\n<\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\thelm\22polyglot_disabled\6g\bvim\0")()
-- Setup for: quick-scope
loadstring("\27LJ\2\nÑ\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0“\4                    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                    augroup qs_colors\n                    autocmd!\n                    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                    augroup END\n                    \14nvim_exec\bapi\bvim\0")()
vim.cmd("packadd quick-scope")
-- Post-load configuration
-- Config for: vim-session
loadstring("\27LJ\2\nì\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0·\5                    \"keep all sessions in one location\n                    let g:session_directory='~/.config/nvim/.session'\n                    \"remove .vim from end of files so it looks nicer in startify\n                    let g:session_extension=''\n                    \"Remove pop-up each time we close to ask to save session\n                    let g:session_autosave = 'no'\n                    \"If I want to load a session I will specify it. We also have a start page\n                    \"which displays recent sessions too so not need to auto load them\n                    let g:session_autoload = 'no'\n                    cnoreabbrev mks SaveSession\n                    cnoreabbrev mksession SaveSession\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: FTerm.nvim
loadstring("\27LJ\2\n∫\2\0\0\6\0\16\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\r\0'\3\n\0'\4\14\0005\5\15\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\0023<C-\\><C-n><CMD>lua require\"FTerm\".toggle()<CR>\6t\1\0\2\fnoremap\2\vsilent\2)<CMD>lua require\"FTerm\".toggle()<CR>\14<leader>t\6n\20nvim_set_keymap\afn\bvim\vborder\1\0\0\1\0\1\rvertical\b‚îÇ\nsetup\nFTerm\frequire\0")()
-- Config for: rainbow
loadstring("\27LJ\2\n≈\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0ì\1                let g:rainbow_active = 1\n                \"set to 0 if you want to enable rainbow later via :RainbowToggle\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: beacon.nvim
loadstring("\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0")()
-- Config for: vim-superman
loadstring("\27LJ\2\nr\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0A                    cnoreabbrev man Man\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: ale
loadstring("\27LJ\2\n÷\4\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0§\4                    let g:ale_echo_msg_error_str = 'E'\n                    let g:ale_echo_msg_warning_str = 'W'\n                    \" I have some custom icons for errors and warnings but feel free to change them.\n                    \"let g:ale_sign_error = '‚úò'\n                    \"let g:ale_sign_warning = '‚ö†'\n                    let g:ale_sign_error = '‚óè'\n                    let g:ale_sign_warning = '.'\n                    \"let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: nvim-treesitter
loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0")()
-- Config for: quick-scope
loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0")()
-- Config for: indentLine
loadstring("\27LJ\2\nÆ\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0K\0\1\0\1\3\0\0\ttext\rmarkdown\31indentLine_fileTypeExclude\1\3\0\0\thelp\rterminal\30indentLine_bufTypeExclude\b‚îÇ\20indentLine_char\6g\bvim\0")()
-- Config for: fuzzymenu.vim
loadstring("\27LJ\2\nÕ\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0õ\1                    let g:fuzzymenu_position =  'window'\n                    let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                    \14nvim_exec\bapi\bvim\0")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
  call luaeval('_packer_load_wrapper(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  " Event lazy-loads
  au VimEnter * ++once call s:load(['vim-polyglot'], { "event": "VimEnter *" })
  " Function lazy-loads
augroup END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
