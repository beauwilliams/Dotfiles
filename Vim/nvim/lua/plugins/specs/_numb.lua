-- PREVIEW LINE IN BUFFER --> e.g :35 will show you line 35, without having to hit enter, close command palette and you are back
return {
	'nacro90/numb.nvim',
	config = function()
		require('numb').setup()
	end,
}
