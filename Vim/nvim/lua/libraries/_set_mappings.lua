local M = {}
local api = vim.api

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
return M
