local statusline = safe_require('statusline')
if not statusline then
  return
end
statusline.enable = true
statusline.lsp_diagnostics = true
statusline.ale_diagnostics = false
