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

return M
