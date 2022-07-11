--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: Auto dark/light & default theme settings
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: Default colorscheme to load at startup before reading OS theme settings
vim.cmd('colorscheme gruvbox')

-- NOTE: Automatic switching between dark and light mode
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd('colorscheme gruvbox')
		setGruvboxHighlights() --> NOTE: must come after :colorscheme gruvbox
	end,
	set_light_mode = function()
		-- vim.api.nvim_set_option('background', 'light')
		  vim.cmd('hi clear')
		vim.cmd('colorscheme github_light')
	end,
})
auto_dark_mode.init()
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: Gruvbox theme settings
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: Globals must be set on init, not dynamically
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_invert_selection = 0 --disables coloured visual highlights with syntax
-- vim.g.gruvbox_sign_column = "bg0"
--vim.g.gruvbox_sign_column = 'dark0_hard'
--vim.g.gruvbox_invert_selection = 0
--vim.g.gruvbox_number_column = 'dark0_hard'

setGruvboxHighlights = function()
-- CURSOR FLASH
vim.cmd('highlight Beacon guibg=white ctermbg=15')
-- treesitter highlights
vim.cmd('highlight! link TSConstBuiltin Constant') -- None
vim.cmd('highlight! link TSKeywordOperator Keyword') -- not, in
vim.cmd('highlight! link TSOperator GruvboxRed')
vim.cmd('highlight! link TSFunction GruvboxAqua')
vim.cmd('highlight! link TSMethod GruvboxAqua')

-- snap highlights
vim.cmd('highlight! link SnapSelect GruvboxBlue')
vim.cmd('highlight! link SnapMultiSelect GruvboxGray')
vim.cmd('highlight! link SnapNormal GruvboxFg1')
vim.cmd('highlight! link SnapBorder SnapNormal')
vim.cmd('highlight! link SnapPrompt GruvboxOrangeBold')
vim.cmd('highlight! link SnapPosition GruvboxOrangeBold')

-- LSP Saga highlights
vim.cmd("highlight! link DiagnosticHint GruvboxAqua")
vim.cmd("highlight! link DiagnosticInformation GruvboxBlue")
vim.cmd("highlight! link DiagnosticTruncateLine GruvboxGray")
vim.cmd("highlight! link DiagnosticFloatingError Error")
vim.cmd("highlight! link DiagnosticFloatingWarn WarningMsg")
vim.cmd("highlight! link DiagnosticFloatingInfor GruvboxBlue")
vim.cmd("highlight! link DiagnosticFloatingHint GruvboxAqua")
vim.cmd("highlight! link LspSagaAutoPreview GruvboxFg3")
vim.cmd("highlight! link LspSagaBorderTitle GruvboxOrangeBold")
vim.cmd("highlight! link LspSagaCodeActionBorder GruvboxFg2")
vim.cmd("highlight! link LspSagaCodeActionContent GruvboxAquaBold")
vim.cmd("highlight! link LspSagaCodeActionTitle GruvboxOrangeBold")
vim.cmd("highlight! link LspSagaCodeActionTruncateLine GruvboxGray")
vim.cmd("highlight! link LspSagaDefPreviewBorder GruvboxFg2")
vim.cmd("highlight! link LspSagaDiagnosticBorder GruvboxWhite")
vim.cmd("highlight! link LspSagaDiagnosticHeader GruvboxFg3")
vim.cmd("highlight! link LspSagaDiagnosticTruncateLine GruvboxPurple")
vim.cmd("highlight! link LspSagaDocTruncateLine GruvboxGray")
vim.cmd("highlight! link LspSagaFinderSelection GruvboxGreenBold")
vim.cmd("highlight! link LspSagaHoverBorder GruvboxBlue")
vim.cmd("highlight! link LspSagaLspFinderBorder GruvboxBlue")
vim.cmd("highlight! link LspSagaRenameBorder GruvboxBlue")
vim.cmd("highlight! link LspSagaRenamePromptPrefix GruvboxAqua")
vim.cmd("highlight! link LspSagaShTruncateLine GruvboxGray")
vim.cmd("highlight! link LspSagaSignatureHelpBorder GruvboxAqua")
vim.cmd("highlight! link ProviderTruncateLine GruvboxGray")
vim.cmd("highlight! link SagaShadow GruvboxBg1")
vim.cmd("highlight! link TargetWord GruvboxRed")
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: END Gruvbox theme settings
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--THICC colomuns between splits
vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}


-- NOTE: https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
vim.opt.fillchars = "fold: "
-- vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))]]
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1




--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: REST OF FILE IS FOR LATER REF
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- NOTE: Bug fixes..
-- match the fold column colors to the line number colum
--vim.cmd("highlight clear FoldColumn")
-- vim.cmd("highlight! link FoldColumn LineNr")
-- removes Cursor light grey block where cusorline is
-- vim.cmd("hi! link CursorLineNr LineNr ")
--vim.cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')
--vim.cmd('highlight SignColumn guibg=#282828')

--NOTE: Other treesitter highlights to consider.....
-- vim.cmd("highlight! link TSPunctDelimiter Delimiter") -- , . etc
-- vim.cmd("highlight! link TSPunctBracket Delimiter")
-- vim.cmd("highlight! link TSPunctSpecial Delimiter")
-- vim.cmd("highlight! link TSConstant Constant")
-- vim.cmd("highlight! link TSConstBuiltin Special") -- None, etc
-- vim.cmd("highlight! link TSConstMacro Define")
-- vim.cmd("highlight! link TSString String")
-- vim.cmd("highlight! link TSStringRegex String")
-- vim.cmd("highlight! link TSStringEscape SpecialChar")
-- vim.cmd("highlight! link TSCharacter Character")
-- vim.cmd("highlight! link TSNumber Number")
-- vim.cmd("highlight! link TSBoolean Boolean")
-- vim.cmd("highlight! link TSFloat Float")

-- vim.cmd("highlight! link TSFunction Function")
-- vim.cmd("highlight! link TSFuncBuiltin Special") -- print()
-- vim.cmd("highlight! link TSFuncMacro Macro")
-- vim.cmd("highlight! link TSParameter Identifier")
-- vim.cmd("highlight! link TSParameterReference TSParameter")
-- vim.cmd("highlight! link TSMethod Function")
-- vim.cmd("highlight! link TSField Identifier")
-- vim.cmd("highlight! link TSProperty Identifier")
-- vim.cmd("highlight! link TSConstructor Special") -- __init__()
-- vim.cmd("highlight! link TSAnnotation PreProc")
-- vim.cmd("highlight! link TSAttribute PreProc")
-- vim.cmd("highlight! link TSNamespace Include")

-- vim.cmd("highlight! link TSConditional Conditional") -- if
-- vim.cmd("highlight! link TSRepeat Repeat") -- for, while
-- vim.cmd("highlight! link TSLabel Label")
-- vim.cmd("highlight! link TSOperator Operator")
-- vim.cmd("highlight! link TSKeyword Keyword")
-- vim.cmd("highlight! link TSKeywordFunction Keyword")
-- vim.cmd("highlight! link TSKeywordOperator Operator") -- not, in
-- vim.cmd("highlight! link TSException Exception")

-- vim.cmd("highlight! link TSType Type")
-- vim.cmd("highlight! link TSTypeBuiltin Type")
-- vim.cmd("highlight! link TSInclude Include")

-- vim.cmd("highlight! link TSVariableBuiltin Special") -- self

-- vim.cmd("highlight! link TSText TSNone")
-- vim.cmd("highlight! TSStrong term=bold cterm=bold gui=bold")
-- vim.cmd("highlight! TSEmphasis term=italic cterm=italic gui=italic")
-- vim.cmd("highlight! TSUnderline term=underline cterm=underline gui=underline")
-- vim.cmd("highlight! link TSTitle Title")
-- vim.cmd("highlight! link TSLiteral String")
-- vim.cmd("highlight! link TSURI Underlined")

-- vim.cmd("highlight! link TSTag Label")
-- vim.cmd("highlight! link TSTagDelimiter Delimiter")
