(fn init []
  ;MODULE CACHING
  (require :impatient )
  ;((. (require :impatient) :enable_profile))
  ;SAFE MODULE REQUIRE
  (require :libraries._module)
  ;DEBUG
  ; (require :libraries._debug )
  ;CORE
  (require :settings._optimisations)
  (require :settings._mappings )
  (require :settings._commands )
  (require :settings._abbreviations )
  (require :settings._theme)
  (require :settings._options)
  (require :settings._autocmds)
  ;PLUGINS
  (require :plugins._plugins)
  (require :plugins._statusline)
  (require :plugins._cmp)
  (require :plugins._mason)
  (require :plugins._startify)
  ; (require :plugins._hexokinase)
  (require :plugins._telescope)
  (require :plugins._treesitter)
  (require :plugins._my_terminal)
  (require :plugins._nvimtree)
  (require :plugins._discord)
  (require :plugins._goto-preview)
  (require :plugins._nvim-notify)
  (require :plugins._hydra)
  (require :plugins._aerial)
  (require :plugins._symbols-outline)
  (require :plugins._dial)
  (require :plugins._noice)
  ;LSP
  (require :lsp._lsp_config)
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

