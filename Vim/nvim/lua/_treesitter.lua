local tsconf = require'nvim-treesitter.configs'
if not tsconf then
   vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
   return
end
tsconf.setup {
   --ensure_installed = "maintained", --> Installs ALL maintained packages, probably better than "all"
   ensure_installed = {'bash', 'c', 'cpp', 'go', 'java', 'javascript', 'json', 'lua', 'python', 'ruby', 'toml'},
   highlight = {
      enable = true,
      --disable = { "css" },  -- list of language that will be disabled
      custom_captures = {
         --Highlight the @.bar capture group with the "Identifier" highlight group.
         -- ["foo.bar"] = "Identifier",
      },
   },
   indent = {
      enable = false
   },
   rainbow = { --> VIA p00f/nvim-ts-rainbow
    enable = true,
  },
  incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "gnn",
			scope_incremental = "gnc",
			node_decremental = "gnd",
		},
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
      smart_rename = {
          enable = true,
          keymaps = {
              -- mapping to rename reference under cursor
              -- smart_rename = "'wn",
          },
      },
  },
}




--PRETTY SURE BELOW IS NOW DEPRECATED..
--[[ require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
--Misc
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil ]]
   --configs.setup {
      --highlight = {
         --enable = true,
         --disable = {},
      --},
   --}

