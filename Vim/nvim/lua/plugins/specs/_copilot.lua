return {
	{
		'zbirenbaum/copilot.lua',
		event = { 'VimEnter' },
		config = function()
			vim.defer_fn(function()
				require('copilot').setup()
			end, 100)
		end,
	},
	--	{
	--		'CopilotC-Nvim/CopilotChat.nvim',
	--		branch = 'canary',
	--		dependencies = {
	--			{ 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
	--			{ 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
	--		},
	--		build = 'make tiktoken', -- Only on MacOS or Linux
	--		opts = {
	--			-- See Configuration section for options
	--		},
	--		-- See Commands section for default commands if you want to lazy load on them
	--	},
}
