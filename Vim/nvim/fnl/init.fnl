;inspo https://github.com/Gavinok/dotneovim/blob/main/fnl/init.fnl
;https://github.com/tsbohc/.garden/tree/master/etc/nvim/config/fnl

;frameworks: hotpot, aniseed, zest
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
  (require :plugins._discord)
  ;LSP
  (require :lsp._lsp_config)
  ;MY STATUSLINE
  (local statusline (require :statusline))
   (set statusline.enable true)
   (set statusline.lsp_diagnostics true)
   (set statusline.ale_diagnostics false)
;   (a.assoc vim.o
;         :mouse          :a)
  statusline
  ; )
; (init)
