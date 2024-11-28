local cmd = vim.cmd
local nvim_lsp = vim.lsp.buf
local create_user_command = vim.api.nvim_create_user_command

create_user_command('MyLSPDiagnosticsList', function()
	telescope_builtin.diagnostics(telescope_themes.get_dropdown({}))
end, {
	bang = false,
	nargs = 0,
	desc = 'List diagnostics for the current workspace',
})

local diagnostics_active = true --Enabled by default
create_user_command('MyLSPDiagnosticsToggle', function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
		vim.notify('Showing Diagnostics', 2, { title = 'Language Server' })
	else
		vim.diagnostic.hide()
		vim.notify('Hiding Diagnostics', 2, { title = 'Language Server' })
	end
end, {
	bang = false,
	nargs = 0,
	desc = 'Toggle neovim lsp in window diagnostics',
})

create_user_command('MyLSPSymbolsTree', function()
	vim.cmd([[SymbolsOutline]])
end, {
	bang = false,
	nargs = 0,
	desc = 'Toggle symbols tree',
})

create_user_command('MyLSPCodeActionMenu', function()
	nvim_lsp.code_action()
end, {
	bang = false,
	nargs = 0,
	desc = 'Toggle symbols tree',
})

-- bad spelling

create_user_command('MySpellingSuggestions', function()
	telescope_builtin.spell_suggest(telescope_themes.get_cursor({
		prompt_title = '',
		layout_config = {
			height = 0.25,
			width = 0.25,
		},
	}))
end, {
	bang = false,
	nargs = 0,
	desc = 'List diagnostics for the current workspace',
})
