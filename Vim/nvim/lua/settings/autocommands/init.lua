local autocommands = safe_require('settings.autocommands._autocommands')
local formatter = safe_require('settings.autocommands._formatter')
local linter = safe_require('settings.autocommands._linter')

if not autocommands or not formatter or not linter then
	return
end
