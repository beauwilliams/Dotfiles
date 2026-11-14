local bufnr = vim.api.nvim_get_current_buf()
local lang_to_parse_as = 'typescript' -- The Tree-sitter parser we'll use (e.g., "typescript" or "rust")
local adl_filetype = 'adl' -- The filetype of the current buffer (should be "adl")

-- Ensure we are on Neovim 0.9+ for vim.treesitter.set_language
if vim.fn.has('nvim-0.9') == 0 then
	vim.notify_once(
		'ADL_TS_VERSION_WARN',
		'ADL Tree-sitter: Neovim 0.9+ is recommended for this setup.',
		vim.log.levels.WARN
	)
	return
end

local parsers_module = require('nvim-treesitter.parsers')

-- Check if the chosen fallback parser is installed
if not parsers_module.is_parser_installed(lang_to_parse_as) then
	vim.notify_once(
		'ADL_TS_PARSER_WARN',
		"ADL Tree-sitter: Parser for '" .. lang_to_parse_as .. "' is not installed. TSInstall " .. lang_to_parse_as,
		vim.log.levels.WARN
	)
	return
end

-- Tell Neovim's core Tree-sitter engine to use the `lang_to_parse_as` parser for this buffer.
vim.treesitter.set_language(bufnr, lang_to_parse_as)

-- Your nvim-treesitter highlight configuration (enable = true) will then:
-- 1. See that a parser is attached to this buffer (the `typescript` parser).
-- 2. Look for highlighting queries based on the buffer's filetype, which is `adl`.
-- 3. Find and use `~/.config/nvim/queries/adl/highlights.scm` (and others).

-- Log a trace message (visible with :messages or if you have a notification plugin that shows trace)
vim.notify(
	"ADL Tree-sitter: Using '" .. lang_to_parse_as .. "' parser with '" .. adl_filetype .. "' queries.",
	vim.log.levels.TRACE,
	{ title = 'ADL Setup' }
)

-- vim.notify_once is a helper to prevent message spam. If it's not a custom function you have,
-- you can replace vim.notify_once("UNIQUE_KEY", "message", level) with just vim.notify("message", level).
-- For simplicity, I'll use vim.notify directly here if vim.notify_once is not standard.
-- (Neovim 0.9+ has vim.notify_once built-in, so the above should be fine)
