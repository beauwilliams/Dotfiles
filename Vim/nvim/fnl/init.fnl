(fn init []
  ;MODULE CACHING
  (require :impatient )
  ;((. (require :impatient) :enable_profile))
  ;SAFE MODULE REQUIRE
  (require :libraries._module)
  ;DEBUG
  ; (require :libraries._debug )
  ;CORE
  (safe_require :settings._optimisations)
  (safe_require :settings._mappings )
  (safe_require :settings._commands )
  (safe_require :settings._abbreviations )
  (safe_require :settings._theme)
  (safe_require :settings._options)
  (safe_require :settings._autocmds)
  ;PLUGINS
  (safe_require :plugins._plugins)
  (safe_require :plugins._statusline)
  (safe_require :plugins._cmp)
  (safe_require :plugins._mason)
  (safe_require :plugins._startify)
  ; (safe_require :plugins._hexokinase)
  (safe_require :plugins._telescope)
  (safe_require :plugins._treesitter)
  (safe_require :plugins._my_terminal)
  (safe_require :plugins._my_highlight_cursor)
  (safe_require :plugins._nvimtree)
  (safe_require :plugins._discord)
  (safe_require :plugins._goto-preview)
  (safe_require :plugins._nvim-notify)
  (safe_require :plugins._hydra)
  (safe_require :plugins._aerial)
  (safe_require :plugins._symbols-outline)
  (safe_require :plugins._dial)
  (safe_require :plugins._noice)
  ; (safe_require :plugins._delaytrain)
  ;LSP
  (safe_require :lsp._lsp_config)
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

