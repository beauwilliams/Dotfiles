return {
	{
		'windwp/nvim-spectre',
		--NOTE: to prevent duplicate files we must config as per..
		-- https://github.com/nvim-pack/nvim-spectre/issues/118#issuecomment-1531683211
		config = function()
			require('spectre').setup({
				replace_engine = {
					['sed'] = {
						cmd = 'sed',
						args = {
							'-i',
							'',
							'-E',
						},
					},
				},
			})
		end,
	},
}
