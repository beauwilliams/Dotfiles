--[[ Cool github configs
https://github.com/RRethy/nvim-treesitter-textsubjects
https://github.com/nvim-treesitter/nvim-treesitter-textobjects
https://github.com/nvim-treesitter/nvim-treesitter-refactor
https://github.com/haringsrob/nvim_context_vt
https://github.com/windwp/nvim-ts-autotag
https://github.com/lewis6991/spellsitter.nvim
https://github.com/nvim-treesitter/nvim-tree-docs ]]

local tsconf = require'nvim-treesitter.configs'
if not tsconf then
   vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
   return
end

-- FOR NEORG USAGE: run :TSInstall norg
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c" },
        branch = "main"
    },
}


tsconf.setup {
   ensure_installed = "maintained", --> Installs ALL maintained packages, probably better than "all" [note had issue with CSS performance, keep in mind..]
   -- ensure_installed = {'bash', 'c', 'cpp', 'go', 'java', 'javascript', 'json', 'lua', 'python', 'ruby', 'toml'},
    autotag = { -- NOTE: Not working https://github.com/windwp/nvim-ts-autotag
        enable = true,
    },
   highlight = {
      enable = true,
      use_languagetree = true,
    -- disable = { "java" },  -- list of language that will be disabled
      custom_captures = {
         --Highlight the @.bar capture group with the "Identifier" highlight group.
         -- ["foo.bar"] = "Identifier",
      },
    },
    indent = {
        enable = true
    },
    rainbow = { --> VIA p00f/nvim-ts-rainbow
        enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<Leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<Leader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
      },
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>",
        scope_incremental = "gnc",
        node_incremental = "<Enter>",
        node_decremental = "<BS>",
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
                smart_rename = "<leader>r",
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

