--[[ Cool github configs
https://github.com/RRethy/nvim-treesitter-textsubjects
https://github.com/nvim-treesitter/nvim-treesitter-textobjects
https://github.com/nvim-treesitter/nvim-treesitter-refactor
https://github.com/haringsrob/nvim_context_vt
https://github.com/windwp/nvim-ts-autotag
https://github.com/lewis6991/spellsitter.nvim
https://github.com/nvim-treesitter/nvim-tree-docs ]]
local api = vim.api
local tsconf = require("nvim-treesitter.configs")
if not tsconf then
    vim.cmd([[ echom 'Cannot load `nvim-treesitter.configs`' ]])
    return
end

-- FOR NEORG USAGE: run :TSInstall norg
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = {"src/parser.c", "src/scanner.cc"},
        branch = "main"
    }
}

tsconf.setup(
    {
        --NOTE: As of Apr 2022 maintained flag is deprecated
        -- ensure_installed = 'all', --> Installs ALL maintained[] packages, probably better than "all" [note had issue with CSS performance, keep in mind..]
                playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?"
            }
        },

        disable = {},
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "go",
            "java",
            "javascript",
            "json",
            "lua",
            "python",
            "ruby",
            "toml",
            "solidity",
            "norg",
            "tsx",
            "typescript"
        },
        autotag = {
            enable = true
        },
        highlight = {
            enable = true,
            use_languagetree = true,
            -- disable = { "java" },  -- list of language that will be disabled
            custom_captures = {}
        },
        indent = {
            enable = true
        },
        -- NOTE: Not 0.7 nightly compatible for now
        rainbow = {
            --> VIA p00f/nvim-ts-rainbow
            enable = true
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Enter>",
                scope_incremental = "gnc",
                node_incremental = "<Enter>",
                node_decremental = "<BS>"
            }
        },
        refactor = {
            highlight_definitions = {enable = false},
            highlight_current_scope = {enable = false},
            navigation = {
                enable = true,
                keymaps = {
                    goto_next_usage = "<A-*>",
                    goto_previous_usage = "<A-#>"
                }
            },
            smart_rename = {
                enable = true,
                keymaps = {}
            }
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    -- BUG: Causes query bug using below code
                    --[[ ['iF'] = {
					python = '(function_definition) @function',
					cpp = '(function_definition) @function',
					c = '(function_definition) @function',
					java = '(method_declaration) @function',
				}, ]]
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["aC"] = "@class.outer",
                    ["iC"] = "@class.inner",
                    ["ac"] = "@conditional.outer",
                    ["ic"] = "@conditional.inner",
                    ["ae"] = "@block.outer",
                    ["ie"] = "@block.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["is"] = "@statement.inner",
                    ["as"] = "@statement.outer",
                    ["ad"] = "@comment.outer",
                    ["am"] = "@call.outer",
                    ["im"] = "@call.inner"
                }
            },
            swap = {
                enable = true,
                swap_next = {},
                swap_previous = {}
            },
            lsp_interop = {
                enable = true
            }
        },
    }
)

-- NOTE: Auto installs missing treesitter parsers for given filetype in buffer
local ask_install = {}
function EnsureTSParserInstalled()
    local parsers = require "nvim-treesitter.parsers"
    local lang = parsers.get_buf_lang()
    if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
        vim.schedule_wrap(
            function()
                -- TODO: implement a Y/n prompt util func
                print("Install treesitter parser for " .. lang .. " ? Y/n")
                -- pcall to make Ctrl-C work
                local ok, response =
                    pcall(vim.fn.confirm, "Install treesitter parser for this filetype?", "&Yes\n&No", 2)
                if ok and response == 1 then
                    vim.cmd("TSInstall " .. lang)
                else
                    ask_install[lang] = false
                end
            end
        )()
    end
end
-- TODO: convert to auto group
vim.cmd [[au FileType * :lua EnsureTSParserInstalled()]]

api.nvim_create_autocmd(
    "BufEnter",
    {
        pattern = "*",
        callback = function()
            require("hlargs").setup {color = "#83a598"}
        end,
        desc = "Enabler HLArgs treesitter upon buffer enter"
    }
)

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
