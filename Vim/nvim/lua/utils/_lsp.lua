local utils = require('utils._utils')
local M = {}

-- DISPLAY DIAGNOSTICS IN THE COMMAND BAR
-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }

-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil

-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 250

-- The highlight group to use for warning messages.
local warning_hlgroup = 'WarningMsg'

-- The highlight group to use for error messages.
local error_hlgroup = 'ErrorMsg'

-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20

-- Shows the current line's diagnostics in a floating window.
function M.show_line_diagnostics()
	vim.lsp.diagnostic.show_line_diagnostics({ severity_limit = 'Warning' }, vim.fn.bufnr(''))
end

-- Prints the first diagnostic for the current line.
function M.echo_diagnostic()
	if echo_timer then
		echo_timer:stop()
	end

	echo_timer = vim.defer_fn(function()
		local line = vim.fn.line('.') - 1
		local bufnr = vim.api.nvim_win_get_buf(0)

		if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
			return
		end

		local diags = vim.lsp.diagnostic.get_line_diagnostics()

		if #diags == 0 then
			-- If we previously echo'd a message, clear it out by echoing an empty
			-- message.
			if last_echo[1] then
				last_echo = { false, -1, -1 }

				vim.api.nvim_command('echo ""')
			end

			return
		end

		last_echo = { true, bufnr, line }

		local diag = diags[1]
		local width = vim.api.nvim_get_option('columns') - 15
		local lines = vim.split(diag.message, '\n')
		local message = lines[1]
		local trimmed = false

		if #lines > 1 and #message <= short_line_limit then
			message = message .. ' ' .. lines[2]
		end

		if width > 0 and #message >= width then
			message = message:sub(1, width) .. '...'
		end

		local kind = 'warning'
		local hlgroup = warning_hlgroup

		if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
			kind = 'error'
			hlgroup = error_hlgroup
		end

		local chunks = {
			{ kind .. ': ', hlgroup },
			{ message },
		}

		vim.api.nvim_echo(chunks, false, {})
	end, echo_timeout)
end


-- async formatting
-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
-- NOTE: This is 0.6 only this error https://github.com/jose-elias-alvarez/null-ls.nvim/issues/390#issuecomment-984641678
local format_async = function(err, result, ctx)
	if err ~= nil or result == nil then
		return
	end

	local bufnr = ctx.bufnr
	if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, bufnr)
		vim.fn.winrestview(view)
		if bufnr == vim.api.nvim_get_current_buf() then
			vim.api.nvim_command('noautocmd :update')
		end
	end
end

-- NOTE: This is 0.5 only this error https://github.com/jose-elias-alvarez/null-ls.nvim/issues/390#issuecomment-984641678
local format_async_legacy = function(err, _, result, _, bufnr)
	if err ~= nil or result == nil then
		return
	end
	if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
		local view = fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, bufnr)
		fn.winrestview(view)
		vim.api.nvim_command('noautocmd :update')
	end
end

M.get_async_format_fn = function()
	if utils.hasVersion("0.5.1") then
		return format_async
	elseif utils.hasVersion("0.5") then
		return format_async_legacy
	end
end



return M
