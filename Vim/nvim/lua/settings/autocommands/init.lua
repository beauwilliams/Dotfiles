local autocommands = safe_require('settings.autocommands._autocommands')
local lsp = safe_require('settings.autocommands._lsp')

if not autocommands or not lsp then
	return
end
