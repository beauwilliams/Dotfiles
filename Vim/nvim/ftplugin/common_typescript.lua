vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufRead"},
  {
    pattern = {"*.cts"},
    callback = function()
      vim.bo.filetype = "typescript"
    end
  }
)
