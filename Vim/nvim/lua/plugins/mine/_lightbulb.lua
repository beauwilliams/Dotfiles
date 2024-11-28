--LIGHTBULB, A CODE ACTION LIGHTBULB LIKE VSC
local vim = vim --> DON'T CALL GLOBAL EACH TIME

local nvimlightbulb = safe_require('nvim-lightbulb')
if not nvimlightbulb then
	return
end
nvimlightbulb.get_status_text()
vim.cmd([[ autocmd CursorHold,CursorHoldI * lua LightBulbFunction() ]])
LightBulbFunction = function()
	nvimlightbulb.update_lightbulb({
		sign = {
			enabled = false,
			-- Priority of the gutter sign
			priority = 10,
		},
		float = {
			enabled = false,
			-- Text to show in the popup float
			text = '',
			win_opts = { offset_x = 40 },
			-- Available keys for window options:
			-- - height     of floating window
			-- - width      of floating window
			-- - wrap_at    character to wrap at for computing height
			-- - max_width  maximal width of floating window
			-- - max_height maximal height of floating window
			-- - pad_left   number of columns to pad contents at left
			-- - pad_right  number of columns to pad contents at right
			-- - pad_top    number of lines to pad contents at top
			-- - pad_bottom number of lines to pad contents at bottom
			-- - offset_x   x-axis offset of the floating window
			-- - offset_y   y-axis offset of the floating window
			-- - anchor     Corner of float to place at the cursor (NW, NE, SW, SE)
		},
		status_text = {
			enabled = true,
			-- Text to provide when code actions are available
			text = '💡',
			-- Text to provide when no actions are available
			text_unavailable = '',
		},
	})
end
