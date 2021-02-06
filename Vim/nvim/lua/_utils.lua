local Job = require("plenary.job")
local api = vim.api

local Utils = {}

function Utils.map(type, input, output)
    api.nvim_set_keymap(type, input, output, {})
end

function Utils.noremap(type, input, output)
    api.nvim_set_keymap(type, input, output, { noremap = true, silent = true })
end

function Utils.nnoremap(input, output)
    Utils.noremap('n', input, output)
end

function Utils.inoremap(input, output)
    Utils.noremap('i', input, output)
end

function Utils.vnoremap(input, output)
    Utils.noremap('v', input, output)
end

function Utils.tnoremap(input, output)
    Utils.noremap('t', input, output)
end

function Utils.nmap(input, output)
	Utils.map('n', input, output)
end

function Utils.imap(input, output)
	Utils.map('i', input, output)
end

function Utils.vmap(input, output)
	Utils.map('v', input, output)
end

function Utils.tmap(input, output)
	Utils.map('t', input, output)
end

-- returns nil if not exists
function Utils.is_dir(filepath)
    local ok, _ = os.rename(filepath, filepath)
    return ok
end


Utils.Exists = function(variable)
    local loaded = api.nvim_call_function('exists', {variable})
    return loaded ~= 0
end

Utils.Call = function(arg0, arg1)
    return api.nvim_call_function(arg0, arg1)
end

Utils.IsVersion5 = function()
    return api.nvim_call_function('has', {'nvim-0.5'}) == 1
end

Utils.translate = function(lang)
  local word = Utils.get_visual()
  local job = Job:new({
    command = "trans",
    args = {"-b", ":" .. (lang or "en"), word}
  })

  local ok, result = pcall(function() return vim.trim(job:sync()[1]) end)

  if ok then
    vim.lsp.handlers["textDocument/hover"](nil, "textDocument/hover", {
      contents = {
        {
          language = "txt",
          -- TODO(elianiva): support this for other language, though I don't
          -- think I would use this outside of English and Japanese
          value = lang == "en" and "Japanese ⟶  English" or "English ⟶  Japanese"
        },
        result
      }
    })
  end
end
vim.cmd('command! -range -nargs=1 Translate call v:lua.Util.translate(<f-args>)')

P = function(stuff) return print(vim.inspect(stuff)) end

Utils.check_backspace = function()
  local curr_col = vim.fn.col('.')
  local is_first_col = vim.fn.col('.') - 1 == 0
  local prev_char = vim.fn.getline('.'):sub(curr_col - 1, curr_col - 1)

  if is_first_col or prev_char:match("%s") then
    return true
  else
    return false
  end
end

Utils.check_surroundings = function()
  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  local prev_char = line:sub(col - 1, col - 1)
  local next_char = line:sub(col, col)
  local pattern = '[%{|%}|%[|%]]'

  if prev_char:match(pattern) and next_char:match(pattern) then
    return true
  else
    return false
  end
end

-- preview file using xdg_open
Utils.xdg_open = function()
  local filename = vim.fn.expand("<cfile>")
  vim.loop.spawn("xdg-open", {args = {filename}})
end

local to_rgb = function(hex)
  local red, green, blue, alpha

  if #hex == 9 then
    _, red, green, blue, alpha = hex:match('(.)(..)(..)(..)(..)')
    return string.format(
      'rgba(%s, %s, %s, %s)',
      tonumber("0x" .. red), tonumber("0x" .. green),
      tonumber("0x" .. blue), tonumber("0x" .. alpha)
    )
  end

  _, red, green, blue = hex:match('(.)(..)(..)(..)')
  return string.format(
    'rgb(%s, %s, %s)',
    tonumber("0x" .. red), tonumber("0x" .. green), tonumber("0x" .. blue)
  )
end

local to_hex = function(rgb)
  local red, green, blue, alpha
  if #rgb >= 16 then
    red, green, blue, alpha = rgb:match("%((%d+),%s(%d+),%s(%d+),%s(%d+)")
    return string.format('#%x%x%x%x', red, green, blue, alpha)
  end

  red, green, blue = rgb:match("%((%d+),%s(%d+),%s(%d+)")
  return string.format('#%x%x%x', red, green, blue)
end

Utils.get_word = function()
  local first_line, last_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
  local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]
  local current_word = vim.fn.getline(first_line, last_line)[1]:sub(first_col, last_col)

  return current_word
end

-- don't actually use this but I thought this might come in handy who knows ;)
Utils.get_lines = function()
  local first_line, last_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
  local lines = vim.fn.getline(first_line, last_line)

  return lines
end

-- don't actually use this but I thought this might come in handy who knows ;)
Utils.get_visual = function()
  local first_line, last_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
  local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]
  local lines = vim.fn.getline(first_line, last_line)

  if #lines == 0 then
    return ""
  end

  lines[#lines] = lines[#lines]:sub(0, last_col - 2)
  lines[1] = lines[1]:sub(first_col - 1, -1)

  return lines
end

Utils.strike_through = function()
  local first_line, _ = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
  local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]

  local strike_ns = vim.api.nvim_create_namespace("striked_text")

  vim.api.nvim_buf_add_highlight(
    0, strike_ns, "StrikeThrough", first_line - 1, first_col - 1, last_col
  )
end

Utils.convert_color = function(mode)
  local result

  if mode == 'rgb' then
    result = to_rgb(Utils.get_word())
  else
    result = to_hex(Utils.get_word())
  end

  vim.api.nvim_command(string.format('s/%s/%s', Utils.get_word(), result))
end

vim.api.nvim_exec([[
  command! -nargs=? -range=% ToRgb call v:lua.Utils.convert_color('rgb')
  command! -nargs=? -range=% ToHex call v:lua.Utils.convert_color('hex')
]], false)


Utils.is_cfg_present = function(cfg_name)
  -- this returns 1 if it's not present and 0 if it's present
  -- we need to compare it with 1 because both 0 and 1 is `true` in lua
  return vim.fn.empty(vim.fn.glob(vim.loop.cwd()..cfg_name)) ~= 1
end

-- helper for defining highlight groups
Utils.set_hl = function(group, options)
  local bg = options.bg == nil and '' or 'guibg=' .. options.bg
  local fg = options.fg == nil and '' or 'guifg=' .. options.fg
  local gui = options.gui == nil and '' or 'gui=' .. options.gui
  local link = options.link or false
  local target = options.target

  if not link then
    vim.cmd(string.format(
      'hi %s %s %s %s',
      group, bg, fg, gui
    ))
  else
    vim.cmd(string.format(
      'hi! link', group, target
    ))
  end
end

function Utils.linkHighlight(from, to)
  local hl_exists, _ = pcall(api.nvim_get_hl_by_name, from, false)
  if not hl_exists then
    vim.cmd(('highlight link %s %s'):format(from, to))
  end
end

function Utils.starts_with(str, start)
   return str:sub(1, #start) == start
end

function Utils.tprint(table)
  print(vim.inspect(table))
end



-- SET OPTS --> EG --> opt('b', 'expandtab', true)
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
function Utils.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end


-- stolen from https://github.com/fsouza/vimfiles
Utils.get_python_tool = function(bin_name)
  local result = bin_name
  if os.getenv('VIRTUAL_ENV') then
    local venv_bin_name = os.getenv('VIRTUAL_ENV') .. '/bin/' .. bin_name
    if vim.fn.executable(venv_bin_name) == 1 then
      result = venv_bin_name
    end
  end
  return result
end




return Utils
