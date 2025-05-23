--- Defines which kind source to use
-- local kind_source = _G.IsWSL() and "default" or "vscode"
local kind_source = 'default'

local kind = {
	default = {
		Copilot = '',
		Class = ' ',
		Color = ' ',
		Constant = ' ',
		Constructor = ' ',
		Enum = '',
		EnumMember = ' ',
		Event = ' ',
		Field = ' ',
		File = ' ',
		Folder = ' ',
		Function = 'ƒ ',
		Interface = ' ',
		Keyword = ' ',
		Method = ' ',
		Module = ' ',
		Operator = ' ',
		Property = ' ',
		Reference = ' ',
		Snippet = '﬌ ',
		Struct = ' ',
		Text = ' ',
		TypeParameter = ' ',
		Unit = '塞',
		Value = ' ',
		Variable = ' ',
	},
	-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
	vscode = {
		Text = '  ',
		Method = '  ',
		Function = '  ',
		Constructor = '  ',
		Field = '  ',
		Variable = '  ',
		Class = '  ',
		Interface = '  ',
		Module = '  ',
		Property = '  ',
		Unit = '  ',
		Value = '  ',
		Enum = '  ',
		Keyword = '  ',
		Snippet = '﬌  ',
		Color = '  ',
		File = '  ',
		Reference = '  ',
		Folder = '  ',
		EnumMember = '  ',
		Constant = '  ',
		Struct = '  ',
		Event = '  ',
		Operator = '  ',
		TypeParameter = '  ',
	},
}

local diagnostics = {
	Error = '',
	Hint = '',
	Info = '',
	Warn = '',
}

local misc = {
	ArrowClosed = '',
	ArrowOpen = '',
	ArrowRight = '➜',
	BigCircle = ' ',
	BigUnfilledCircle = ' ',
	Branch = '',
	Bulb = '',
	Bullets = 'ﯟ',
	Calendar = '',
	CheckMark = '✓',
	ChevronRight = '>',
	Circle = ' ',
	XMark = '✗',
	LeftFilledArrow = '',
	LeftUnfilledArrow = '',
	Owl = '',
	Plug = '',
	RightFilledArrow = '',
	RightUnfilledArrow = '',
	Star = '*',
	Storage = '',
	VerticalShadowedBox = ' ',
}

local document = {
	Document = '',
	DocumentSearch = '',
	DocumentWord = '',
	DoubleDocument = '',
	FolderClosed = '',
	FolderEmpty = 'ﰊ',
	FolderOpen = '',
}

return {
	kind = kind[kind_source],
	diagnostics = diagnostics,
	document = document,
	misc = misc,
}
