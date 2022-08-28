--NOTE: Sample hello fn that takes args.
vim.api.nvim_create_user_command('Hello', function(input)
  local args = input.args
  print('Hello '..args)
end, { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('HighlightsUnderCursor', function(input)
  local args = input.args
  vim.cmd("TSHighlightCapturesUnderCursor")
end, { bang = true, nargs = '*' })
