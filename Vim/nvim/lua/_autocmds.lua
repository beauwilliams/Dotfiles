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
		},
		onread = {
			-- Open non vim files (binaries etc) in their respective applications
			{
				'BufRead',
				'*.png,*.jpg,*.pdf,*.gif,*.xls*,*.ppt*,*.doc*,*.rtf',
				'sil exe "!open " . shellescape(expand("%:p")) | bd | let &ft=&ft',
			},
			-- Auto open vim and move cursor to last known location
			{
				'BufReadPost',
				'*',
				'silent! normal! g`"zv',
			},
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

--INSPO
-- Auto save files when focus is lost
-- cmd("au FocusLost * :wa")
-- cmd("au FocusLost * silent! wa")
