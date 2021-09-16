-- ========================
-- HEXOKINASE CONFIGURATION
-- ========================
-- Adds colour bling at end of lines to display the colour like VSC

return function()
	vim.g.Hexokinase_highlighters = { "virtual" }
	vim.g.Hexokinase_optInPatterns = {
		"full_hex",
		"triple_hex",
		"rgb",
		"rgba",
		"hsl",
		"hsla",
		"colour_names",
	}
end
