-- local Job = require('plenary.job')
local api = vim.api
local cmd = vim.cmd
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
	return api.nvim_call_function('has', { 'nvim-' .. version }) == 1
end

--M.translate = function(lang)
--	local word = M.get_visual()
--	local job = Job:new({
--		command = 'trans',
--		args = { '-b', ':' .. (lang or 'en'), word },
--	})
--
--	local ok, result = pcall(function()
--		return vim.trim(job:sync()[1])
--	end)
--
--	if ok then
--		vim.lsp.handlers['textDocument/hover'](nil, 'textDocument/hover', {
--			contents = {
--				{
--					language = 'txt',
--					-- currently only support think English and Japanese
--					value = lang == 'en' and 'Japanese ⟶  English' or 'English ⟶  Japanese',
--				},
--				result,
--			},
--		})
--	end
--end
--vim.cmd('command! -range -nargs=1 Translate call v:lua.Util.translate(<f-args>)')

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

M.TestInBufferOnWrite = function()
	-- TODO: Add nui popup to ask for pattern, create new buffer, with ft out
	local bufnr = 16
	vim.api.nvim_create_autocmd('BufWritePost', {
		group = vim.api.nvim_create_augroup('TestInBufferOnWriteAuGroup', { clear = true }),
		pattern = '*', --NOTE: Here we can feed in array of patterns chosen by user at runtime
		callback = function()
			vim.api.nvim_buf_call(16, function()
				vim.cmd('set ft=term')
			end)
			vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { '-------------------OUTPUT------------------' })
			-- vim.fn.jobs
			vim.fn.jobstart({ 'echo', 'hello', 'world' }, {
				stdout_buffered = true,
				on_stdout = function(_, data) --NOTE: Print stdout
					if data and data[1] ~= '' then --NOTE: Ignore empty lines
						vim.pretty_print(data)
						vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
						vim.api.nvim_buf_call(16, function()
							vim.cmd('norm G')
						end)
					end
				end,
				on_stderr = function(_, data) --NOTE: print stderr
					if data and data[1] ~= '' then
						vim.pretty_print(data)
						vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data) --NOTE: use -1,-1 to append to bottom of buffer
					end
				end,
			})
		end,
	})
end

-- closes tab + all of its buffers
M.closeAllBufs = function(action)
	local bufs = vim.t.bufs

	if action == 'closeTab' then
		vim.cmd('tabclose')
	end

	for _, buf in ipairs(bufs) do
		M.close_buffer(buf)
	end

	if action ~= 'closeTab' then
		vim.cmd('enew')
	end
end

M.close_buffer = function(bufnr)
	if vim.bo.buftype == 'terminal' then
		vim.cmd(vim.bo.buflisted and 'set nobl | enew' or 'hide')
	elseif vim.bo.modified then
		print('save the file bruh')
	else
		bufnr = bufnr or api.nvim_get_current_buf()
		require('core.utils').tabuflinePrev()
		vim.cmd('bd' .. bufnr)
	end
end

--[[ vim.o.confirm = true
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end

	end
}) ]]

--[[ get win layout,
determine if [leaf, winnr]
if leaf, determine if last tab (cur is 1)
if so exit vim, not exit tab (or just :q which works for both closing tab and vim?)
else do nothing ]]
-- run on winenter?

--[[ vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("quit") end
	end
}) ]]

-- lua local layout = vim.api.nvim_call_function("winlayout", {}) if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("quit")end

--[[ local ft = api.nvim_buf_get_option(api.nvim_win_get_buf(M.sizes.current_window), "filetype")
    local tabpage = api.nvim_get_current_tabpage()
if tbl[i][1] == "leaf" then
    ft = api.nvim_buf_get_option(api.nvim_win_get_buf(tbl[i][2]), "filetype")
end ]]

return M
---------
---EOF---
---------
