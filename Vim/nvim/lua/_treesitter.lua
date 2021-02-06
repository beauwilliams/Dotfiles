--local configs = require'nvim-treesitter.configs'
--if not configs then
   --vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
   --return
--end
require'nvim-treesitter.configs'.setup {
   ensure_installed = "all",
   highlight = {
      enable = true,
      custom_captures = {
         --Highlight the @foo.bar capture group with the "Identifier" highlight group.
         ["foo.bar"] = "Identifier",
      },
   },
   indent = {
      enable = false
   },
   rainbow = { --> VIA p00f/nvim-ts-rainbow
    enable = true,
  },
   refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
      navigation = {
         enable = true,
         keymaps = {
            goto_next_usage = "<A-*>",
            goto_previous_usage = "<A-#>",
         },
      },
   },
}
require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
--Misc
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
   --configs.setup {
      --highlight = {
         --enable = true,
         --disable = {},
      --},
   --}

