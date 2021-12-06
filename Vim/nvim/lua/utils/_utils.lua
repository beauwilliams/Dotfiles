local Job = require('plenary.job')
local api = vim.api
local cmd = vim.cmd
local M = {}

-- NOTE: DEBUG
P = function(stuff)
	return print(vim.inspect(stuff))
end
-- help to inspect results, e.g.:
-- ':lua _G.dump(vim.fn.getwininfo())'
function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end

function _G.reload(package)
	package.loaded[package] = nil
	return require(package)
end

local M = {}

function M._echo_multiline(msg)
	for _, s in ipairs(vim.fn.split(msg, '\n')) do
		vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
	end
end

function M.info(msg)
	vim.cmd('echohl Directory')
	M._echo_multiline(msg)
	vim.cmd('echohl None')
end

function M.warn(msg)
	vim.cmd('echohl WarningMsg')
	M._echo_multiline(msg)
	vim.cmd('echohl None')
end

function M.err(msg)
	vim.cmd('echohl ErrorMsg')
	M._echo_multiline(msg)
	vim.cmd('echohl None')
end

function M.set_options(locality, options)
	local scopes = { o = vim.o, b = vim.bo, g = vim.g, w = vim.wo }
	local scope = scopes[locality]
	for key, value in pairs(options) do
		scope[key] = value
	end
end

function M.map(type, input, output)
	api.nvim_set_keymap(type, input, output, {})
end

function M.noremap(type, input, output)
	api.nvim_set_keymap(type, input, output, { noremap = true, silent = true })
end

function M.remap(type, input, output)
	api.nvim_set_keymap(type, input, output, { noremap = false, silent = true })
end

function M.nnoremap(input, output)
	M.noremap('n', input, output)
end

function M.inoremap(input, output)
	M.noremap('i', input, output)
end

function M.vnoremap(input, output)
	M.noremap('v', input, output)
end

function M.tnoremap(input, output)
	M.noremap('t', input, output)
end

function M.cnoremap(input, output)
	M.noremap('c', input, output)
end

function M.nmap(input, output)
	M.remap('n', input, output)
end

function M.imap(input, output)
	M.remap('i', input, output)
end

function M.vmap(input, output)
	M.remap('v', input, output)
end

function M.tmap(input, output)
	M.remap('t', input, output)
end

-- returns nil if not exists
function M.is_dir(filepath)
	local ok, _ = os.rename(filepath, filepath)
	return ok
end

M.Exists = function(variable)
	local loaded = api.nvim_call_function('exists', { variable })
	return loaded ~= 0
end

M.Call = function(arg0, arg1)
	return api.nvim_call_function(arg0, arg1)
end

M.IsVersion5 = function()
	return api.nvim_call_function('has', { 'nvim-0.5' }) == 1
end

M.hasVersion = function(version)
	return api.nvim_call_function('has', { 'nvim-'..version }) == 1
end


M.translate = function(lang)
	local word = M.get_visual()
	local job = Job:new({
		command = 'trans',
		args = { '-b', ':' .. (lang or 'en'), word },
	})

	local ok, result = pcall(function()
		return vim.trim(job:sync()[1])
	end)

	if ok then
		vim.lsp.handlers['textDocument/hover'](nil, 'textDocument/hover', {
			contents = {
				{
					language = 'txt',
					-- TODO(elianiva): support this for other language, though I don't
					-- think I would use this outside of English and Japanese
					value = lang == 'en' and 'Japanese ⟶  English' or 'English ⟶  Japanese',
				},
				result,
			},
		})
	end
end
vim.cmd('command! -range -nargs=1 Translate call v:lua.Util.translate(<f-args>)')

M.check_backspace = function()
	local curr_col = vim.fn.col('.')
	local is_first_col = vim.fn.col('.') - 1 == 0
	local prev_char = vim.fn.getline('.'):sub(curr_col - 1, curr_col - 1)

	if is_first_col or prev_char:match('%s') then
		return true
	else
		return false
	end
end

M.check_surroundings = function()
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
M.xdg_open = function()
	local filename = vim.fn.expand('<cfile>')
	vim.loop.spawn('xdg-open', { args = { filename } })
end

local to_rgb = function(hex)
	local red, green, blue, alpha

	if #hex == 9 then
		_, red, green, blue, alpha = hex:match('(.)(..)(..)(..)(..)')
		return string.format(
			'rgba(%s, %s, %s, %s)',
			tonumber('0x' .. red),
			tonumber('0x' .. green),
			tonumber('0x' .. blue),
			tonumber('0x' .. alpha)
		)
	end

	_, red, green, blue = hex:match('(.)(..)(..)(..)')
	return string.format('rgb(%s, %s, %s)', tonumber('0x' .. red), tonumber('0x' .. green), tonumber('0x' .. blue))
end

local to_hex = function(rgb)
	local red, green, blue, alpha
	if #rgb >= 16 then
		red, green, blue, alpha = rgb:match('%((%d+),%s(%d+),%s(%d+),%s(%d+)')
		return string.format('#%x%x%x%x', red, green, blue, alpha)
	end

	red, green, blue = rgb:match('%((%d+),%s(%d+),%s(%d+)')
	return string.format('#%x%x%x', red, green, blue)
end

M.get_word = function()
	local first_line, last_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
	local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]
	local current_word = vim.fn.getline(first_line, last_line)[1]:sub(first_col, last_col)

	return current_word
end

-- don't actually use this but I thought this might come in handy who knows ;)
M.get_lines = function()
	local first_line, last_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
	local lines = vim.fn.getline(first_line, last_line)

	return lines
end

-- don't actually use this but I thought this might come in handy who knows ;)
M.get_visual = function()
	local first_line, last_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
	local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]
	local lines = vim.fn.getline(first_line, last_line)

	if #lines == 0 then
		return ''
	end

	lines[#lines] = lines[#lines]:sub(0, last_col - 2)
	lines[1] = lines[1]:sub(first_col - 1, -1)

	return lines
end

M.strike_through = function()
	local first_line, _ = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
	local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]

	local strike_ns = vim.api.nvim_create_namespace('striked_text')

	vim.api.nvim_buf_add_highlight(0, strike_ns, 'StrikeThrough', first_line - 1, first_col - 1, last_col)
end

M.convert_color = function(mode)
	local result

	if mode == 'rgb' then
		result = to_rgb(M.get_word())
	else
		result = to_hex(M.get_word())
	end

	vim.api.nvim_command(string.format('s/%s/%s', M.get_word(), result))
end

vim.api.nvim_exec(
	[[
  command! -nargs=? -range=% ToRgb call v:lua.M.convert_color('rgb')
  command! -nargs=? -range=% ToHex call v:lua.M.convert_color('hex')
]],
	false
)

M.is_cfg_present = function(cfg_name)
	-- this returns 1 if it's not present and 0 if it's present
	-- we need to compare it with 1 because both 0 and 1 is `true` in lua
	return vim.fn.empty(vim.fn.glob(vim.loop.cwd() .. cfg_name)) ~= 1
end

-- helper for defining highlight groups
M.set_hl = function(group, options)
	local bg = options.bg == nil and '' or 'guibg=' .. options.bg
	local fg = options.fg == nil and '' or 'guifg=' .. options.fg
	local gui = options.gui == nil and '' or 'gui=' .. options.gui
	local link = options.link or false
	local target = options.target

	if not link then
		vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
	else
		vim.cmd(string.format('hi! link', group, target))
	end
end

function M.linkHighlight(from, to)
	local hl_exists, _ = pcall(api.nvim_get_hl_by_name, from, false)
	if not hl_exists then
		vim.cmd(('highlight link %s %s'):format(from, to))
	end
end

function M.starts_with(str, start)
	return str:sub(1, #start) == start
end

function M.tprint(table)
	print(vim.inspect(table))
end

-- stolen from https://github.com/fsouza/vimfiles
M.get_python_tool = function(bin_name)
	local result = bin_name
	if os.getenv('VIRTUAL_ENV') then
		local venv_bin_name = os.getenv('VIRTUAL_ENV') .. '/bin/' .. bin_name
		if vim.fn.executable(venv_bin_name) == 1 then
			result = venv_bin_name
		end
	end
	return result
end

-- Stolen from https://github.com/kyazdani42/nvim-palenight.lua/blob/master/lua/palenight.lua#L10
-- Usage:
-- highlight(Cursor, { fg = bg_dark, bg = yellow })
function M.highlight(group, styles)
	local s = vim.tbl_extend('keep', styles, { gui = 'NONE', sp = 'NONE', fg = 'NONE', bg = 'NONE' })

	cmd('highlight! ' .. group .. ' gui=' .. s.gui .. ' guisp=' .. s.sp .. ' guifg=' .. s.fg .. ' guibg=' .. s.bg)
end

-- Usage:
-- highlight({
--      CursorLine   = { bg = bg },
--      Cursor       = { fg = bg_dark, bg = yellow }
-- })
function M.highlights(hi_table)
	for group, styles in pairs(hi_table) do
		M.highlight(group, styles)
	end
end

function M.hiLink(src, dest)
	cmd('highlight link ' .. src .. ' ' .. dest)
end

function M.hiLinks(hi_table)
	for src, dest in pairs(hi_table) do
		M.hiLink(src, dest)
	end
end

-- expand or minimize current buffer in a more natural direction (tmux-like)
-- ':resize <+-n>' or ':vert resize <+-n>' increases or decreasese current
-- window horizontally or vertically. When mapped to '<leader><arrow>' this
-- can get confusing as left might actually be right, etc
-- the below can be mapped to arrows and will work similar to the tmux binds
-- map to: "<cmd>lua require'utils'.resize(false, -5)<CR>"
M.resize = function(vertical, margin)
	local cur_win = vim.api.nvim_get_current_win()
	-- go (possibly) right
	vim.cmd(string.format('wincmd %s', vertical and 'l' or 'j'))
	local new_win = vim.api.nvim_get_current_win()

	-- determine direction cond on increase and existing right-hand buffer
	local not_last = not (cur_win == new_win)
	local sign = margin > 0
	-- go to previous window if required otherwise flip sign
	if not_last == true then
		vim.cmd([[wincmd p]])
	else
		sign = not sign
	end

	sign = sign and '+' or '-'
	local dir = vertical and 'vertical ' or ''
	local cmd = dir .. 'resize ' .. sign .. math.abs(margin) .. '<CR>'
	vim.cmd(cmd)
end

M.sudo_exec = function(cmd, print_output)
	local password = vim.fn.inputsecret('Password: ')
	if not password or #password == 0 then
		M.warn('Invalid password, sudo aborted')
		return false
	end
	local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
	if vim.v.shell_error ~= 0 then
		print('\r\n')
		M.err(out)
		return false
	end
	if print_output then
		print('\r\n', out)
	end
	return true
end

-- NOTE: Replaces use('lambdalisue/suda.vim') -- Neovim compatible :SudoWrite
M.sudo_write = function(tmpfile, filepath)
	if not tmpfile then
		tmpfile = vim.fn.tempname()
	end
	if not filepath then
		filepath = vim.fn.expand('%')
	end
	if not filepath or #filepath == 0 then
		M.err('E32: No file name')
		return
	end
	-- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
	-- Both `bs=1M` and `bs=1m` are non-POSIX
	local cmd = string.format('dd if=%s of=%s bs=1048576', vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
	-- no need to check error as this fails the entire function
	vim.api.nvim_exec(string.format('write! %s', tmpfile), true)
	if M.sudo_exec(cmd) then
		M.info(string.format('\r\n"%s" written', filepath))
		vim.cmd('e!')
	end
	vim.fn.delete(tmpfile)
end

return M
---------
---EOF---
---------

-----------------------
-----------------------
------DEPRECATED-------
-----------------------
-----------------------

-- SET OPTS --> EG --> opt('b', 'expandtab', true)
--[[ local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end ]]
