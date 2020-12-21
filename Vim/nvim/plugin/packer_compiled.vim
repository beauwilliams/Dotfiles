" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

lua << END
local plugins = {
  ["FTerm.nvim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/FTerm.nvim"
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
  ["vim-polyglot"] = {
    config = { "\27LJ\2\nk\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\2\0=\1\3\0K\0\1\0&vim_markdown_new_list_item_indent\28javascript_plugin_jsdoc\6g\bvim\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/admin/.local/share/nvim/site/pack/packer/opt/vim-polyglot"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
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
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
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
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Setup for: quick-scope
loadstring("\27LJ\2\n„\5\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0Ò\4                    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                    augroup qs_colors\n                    autocmd!\n                    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline\n                    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline\n                    augroup END\n                    \14nvim_exec\bapi\bvim\0")()
vim.cmd("packadd quick-scope")
-- Setup for: FTerm.nvim
loadstring("\27LJ\2\nì\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\0023<C-\\><C-n><CMD>lua require\"FTerm\".toggle()<CR>\6t\1\0\2\fnoremap\2\vsilent\2)<CMD>lua require\"FTerm\".toggle()<CR>\14<leader>t\6n\20nvim_set_keymap\afn\bvim\0")()
vim.cmd("packadd FTerm.nvim")
-- Setup for: vim-polyglot
loadstring("\27LJ\2\n<\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\thelm\22polyglot_disabled\6g\bvim\0")()
-- Post-load configuration
-- Config for: fuzzymenu.vim
loadstring("\27LJ\2\nÍ\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0›\1                    let g:fuzzymenu_position =  'window'\n                    let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: nvim-treesitter
loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0")()
-- Config for: rainbow
loadstring("\27LJ\2\nÅ\1\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0“\1                let g:rainbow_active = 1\n                \"set to 0 if you want to enable rainbow later via :RainbowToggle\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: beacon.nvim
loadstring("\27LJ\2\no\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1Z\0=\1\2\0006\0\0\0009\0\1\0)\1\25\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\18beacon_shrink\24beacon_minimal_jump\16beacon_size\6g\bvim\0")()
-- Config for: vim-superman
loadstring("\27LJ\2\nr\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0A                    cnoreabbrev man Man\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: vim-session
loadstring("\27LJ\2\n“\6\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0á\5                    \"keep all sessions in one location\n                    let g:session_directory='~/.config/nvim/.session'\n                    \"remove .vim from end of files so it looks nicer in startify\n                    let g:session_extension=''\n                    \"Remove pop-up each time we close to ask to save session\n                    let g:session_autosave = 'no'\n                    \"If I want to load a session I will specify it. We also have a start page\n                    \"which displays recent sessions too so not need to auto load them\n                    let g:session_autoload = 'no'\n                    cnoreabbrev mks SaveSession\n                    cnoreabbrev mksession SaveSession\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: ale
loadstring("\27LJ\2\nÕ\4\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0£\4                    let g:ale_echo_msg_error_str = 'E'\n                    let g:ale_echo_msg_warning_str = 'W'\n                    \" I have some custom icons for errors and warnings but feel free to change them.\n                    \"let g:ale_sign_error = 'âœ˜'\n                    \"let g:ale_sign_warning = 'âš '\n                    let g:ale_sign_error = 'â—'\n                    let g:ale_sign_warning = '.'\n                    let g:ale_lint_on_enter = 0 \"Don't lint on enter hope this speeds things up/prevents lag\n                    \14nvim_exec\bapi\bvim\0")()
-- Config for: indentLine
loadstring("\27LJ\2\n®\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0K\0\1\0\1\3\0\0\ttext\rmarkdown\31indentLine_fileTypeExclude\1\3\0\0\thelp\rterminal\30indentLine_bufTypeExclude\bâ”‚\20indentLine_char\6g\bvim\0")()
-- Config for: quick-scope
loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  " Event lazy-loads
  au VimEnter * ++once call s:load(['vim-polyglot'], { "event": "VimEnter *" })
augroup END
