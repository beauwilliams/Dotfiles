(fn init []
  ;CORE
  (require :core)
  ;DEBUG
  ; (require :libraries._debug )
  ;CORE
  ;PLUGINS
  (safe_require :plugins._lazy)
  ;SETTINGS
  (safe_require :settings._options)
  (safe_require :settings.mappings)
  (safe_require :settings.commands )
  (safe_require :settings.autocommands)
  (safe_require :settings.abbreviations )
  (safe_require :settings.lsp )
  (safe_require :settings._theme)
  ;OPTIONS
  ;(a.assoc vim.o
  ;:mouse :a)
  nil
)
(init)
nil



;-----------------------------------------------------------------------
;fennel frameworks:
;hotpot, aniseed, zest

;inspo:
;https://github.com/Gavinok/dotneovim/blob/main/fnl/init.fnl
;https://github.com/tsbohc/.garden/tree/master/etc/nvim/config/fnl
;-----------------------------------------------------------------------

