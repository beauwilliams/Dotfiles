; (fn init []
  ;CORE
  (require :impatient ) ;Speed up require caching
  (require :settings._mappings )
  (require :plugins._plugins)
  (require :settings._theme)
  (require :settings._options)
  (require :settings._autocmds)
  ;PLUGINS
  (require :plugins._startify)
  (require :plugins._hexokinase)
  (require :plugins._telescope)
  (require :plugins._treesitter)
  (require :plugins._nvimtree)
  ;LSP
  (require :lsp._lsp_config)
  ;MY STATUSLINE
  (local statusline (require :statusline))
   (set statusline.enable true)
   (set statusline.lsp_diagnostics true)
   (set statusline.ale_diagnostics false)
  statusline
  ; )
; (init)
