local telescope = safe_require('settings.commands._telescope')
local hotkeys = safe_require('settings.commands._lsp')

if not utils or not telescope or not lsp then
	return
end

local cmd = vim.cmd
local nvim_lsp = vim.lsp.buf
local create_user_command = vim.api.nvim_create_user_command

------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTE: THEME Commands
------------------------------------------------------------------------------------------------------------------------------------------------

create_user_command('MyHighlightsUnderCursor', function(input)
	local args = input.args
	cmd('TSHighlightCapturesUnderCursor')
end, { bang = false, nargs = 0, desc = 'Highlights all captures under cursor' })

------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTE: SPELL CHECK COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------

--SPELLING
-- NOTE: plgn is vim-you/autocorrect
-- Note we are using neovims built in spellcheck and dictionary
cmd('cnoreabbrev <silent>spell :set spell!<cr>')
cmd([[
    function SpellAuto()
    :EnableAutocorrect
    :set spell
    endfunction
    function SpellOff()
    :DisableAutocorrect
    :set nospell
    endfunction

]])
