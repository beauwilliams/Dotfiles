local api = vim.api

local function nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup ' .. group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
			api.nvim_command(command)
		end
		api.nvim_command('augroup END')
	end
end

local function setup()
	local definitions = {
		--[[ insert = {
            --TURN OFF RELATIVE LINE NUMBERING WHEN WE ENTER INSERT MODE AND ENABLE OTHERWISE
            {"InsertEnter", "*", ":set norelativenumber"},
            {"InsertLeave", "*", ":set relativenumber"}
        }, ]]
		onwrite = {
			{ 'BufWritePre', '*', ':call TrimWhitespace()' },
			{ 'BufWritePost', '~/.config/nvim/*.{vim,lua}', 'so $MYVIMRC' },
			{ 'BufWritePost', '~/.config/nvim/*.{fnl}', 'make' },
		},
		onread = {
			-- Open non vim files (binaries etc) in their respective applications
			{
				'BufRead',
				'*.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc,*.docx,*.rtf',
				'sil exe "!open " . shellescape(expand("%:p")) | bd | let &ft=&ft',
			},
			-- Auto open vim and move cursor to last known location
			{
				'BufReadPost',
				'*',
				'silent! normal! g`"zv',
			},
		},
		ontextyank = {
			{ 'TextYankPost', '*', 'silent! lua require"vim.highlight".on_yank()' },
		},
		disabledconfigs = {
			{ 'BufNewFile,BufRead', '*.vimdisabled', ':set filetype=vim' },
			{ 'BufNewFile,BufRead', '*.luadisabled', ':set filetype=lua' },
			{ 'BufNewFile,BufRead', '*.jsondisabled', ':set filetype=json' },
		},
		-- wins = {
		-- { 'BufWritePre', '*.py', 'undojoin | Neoformat'},
		-- { 'BufWinEnter', '*', 'highlight ExtraWhitespace guifg=#666666' },
		-- { 'BufWinEnter', '*', [[match ExtraWhitespace /\s\+$/]] },
		-- };

		-- ft = {
		--[[ { 'FileType', 'c,python', 'set shiftwidth=4' },
      { 'FileType', 'go', 'set noexpandtab' },
      { 'FileType', 'go', 'set shiftwidth=4' },
      { 'FileType', 'go', 'set softtabstop=4' },
      { 'FileType', 'go', 'set tabstop=4' },}]]
		-- { 'FileType', 'NvimTree', "lua vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>t', ':wincmd l | :Files<CR>', {})" },
		-- };
	}

	nvim_create_augroups(definitions)
end
setup()

local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn
local augroup = api.nvim_create_augroup('user', { clear = true })
autocmd('BufNewFile', {
	pattern = '*',
	callback = function(details)
		if fn.filereadable(details.file) == 1 then
			-- Another BufNewFile event might have handled this already.
			-- Per https://github.com/EinfachToll/DidYouMean
			return
		else
			local swapfile = fn.swapname(api.nvim_buf_get_name(0))
			local possibles = {}
			for _, file in ipairs(vim.split(fn.glob(details.file .. '*'), '\n')) do
				-- In case you have a swapfile in the same directory,
				-- with the same name but ending in .swp
				if file ~= swapfile and #file > 1 then
					table.insert(possibles, file)
				end
			end

			if #possibles > 0 then
				vim.ui.select(possibles, {
					prompt = 'File does not exist. Did you mean? (esc to continue)',
					format_item = function(item)
						local parts = vim.split(item, '/')
						return parts[#parts]
					end,
				}, function(choice)
					if choice then
						local empty_bufnr = api.nvim_win_get_buf(0)
						vim.cmd('edit ' .. vim.fn.fnameescape(choice))
						api.nvim_buf_delete(empty_bufnr, {})
					end
				end)
			end
		end
	end,
	group = augroup,
})

-- dont list quickfix buffers
autocmd('FileType', {
	pattern = 'qf',
	group = augroup,
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Disable statusline in dashboard
autocmd('FileType', {
	pattern = { 'alpha', 'startify' },
	group = augroup,
	callback = function()
		vim.opt.laststatus = 0
		vim.cmd([[IndentBlanklineDisable]])
	end,
})
autocmd('BufUnload', {
	buffer = 0,
	group = augroup,
	callback = function()
		vim.opt.laststatus = 3
	end,
})
-- Don't auto commenting new lines
autocmd('BufEnter', {
	pattern = '*',
	group = augroup,
	command = 'set fo-=c fo-=r fo-=o',
})

-- AUTO SAVES HELP TAGS
autocmd('BufWritePost', {
	pattern = os.getenv('HOME') .. '/.config/nvim/doc/*',
	group = augroup,
	command = ':helptags ~/.config/nvim/doc',
})

--NOTE: This refuses to work in /ftplugin /ftdetect
autocmd({ 'BufNewFile', 'BufRead' }, {
	pattern = { '*.prisma' },
	callback = function()
		vim.bo.filetype = 'prisma'
	end,
})

--NOTE: LSP diags popup on cursor hold
--[[ autocmd('CursorHold', {
	group = augroup,
	pattern = '*',
	callback = function()
		-- skip when a float-win already exists.
		if vim.w.diag_shown then
			return
		end

		-- open float-win when hovering on a cursor-word.
		if vim.w.cursor_word ~= '' then
			vim.diagnostic.open_float(nil, {
				focusable = true,
				close_events = { 'InsertEnter' },
				border = 'rounded',
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			})
			vim.w.diag_shown = true
		end
	end,
}) ]]

--INSPO
-- Auto save files when focus is lost
-- cmd("au FocusLost * :wa")
-- cmd("au FocusLost * silent! wa")
