------------------------------------------------------------------
--[[
     ____     __    __  __   ______    ____    _   __   _____
   / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
   ______   ____     _   __    ______    ____   ______
  / ____/  / __ \   / | / /   / ____/   /  _/  / ____/
 / /      / / / /  /  |/ /   / /_       / /   / / __
/ /___   / /_/ /  / /|  /   / __/     _/ /   / /_/ /
\____/   \____/  /_/ |_/   /_/       /___/   \____/
--]]
-----------------------------------------------------------------


--[[
    ____     ___    ______    __ __    ______    ____            ____    _   __    ____  ______
   / __ \   /   |  / ____/   / //_/   / ____/   / __ \          /  _/   / | / /   /  _/ /_  __/
  / /_/ /  / /| | / /       / ,<     / __/     / /_/ /          / /    /  |/ /    / /    / /
 / ____/  / ___ |/ /___    / /| |   / /___    / _, _/         _/ /    / /|  /   _/ /    / /
/_/      /_/  |_|\____/   /_/ |_|  /_____/   /_/ |_|         /___/   /_/ |_/   /___/   /_/

--/*
--* INSTALL PACKER, LUA BASED PACKAGE MANAGER. USE/DEPENDENCY BASED PACKAGE MGMT
--*/
--]]
--local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

--if fn.empty(fn.glob(install_path)) > 0 then
--execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--end

local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    -- TODO: Maybe handle windows better?
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out =
    vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print("Downloading packer.nvim...")

    return
end




--[[
    ____     __    __  __   ______    ____    _   __           ____    _   __    ____  ______   _____
   / __ \   / /   / / / /  / ____/   /  _/   / | / /          /  _/   / | / /   /  _/ /_  __/  / ___/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /           / /    /  |/ /    / /    / /     \__ \
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /          _/ /    / /|  /   _/ /    / /     ___/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/          /___/   /_/ |_/   /___/   /_/     /____/
--]]
--PACKER IS CAPABLE OF MANAGING ITSELF. IT INITS FIRST THEN CALLS REST OF OUR PLUGINS
require("packer").startup {
    function(use)
        use {"wbthomason/packer.nvim", opt = true}





--[[
  ______    __  __    ______    __  ___    ______   _____          ___             __  __    ____
 /_  __/   / / / /   / ____/   /  |/  /   / ____/  / ___/         ( _ )           / / / /   /  _/
  / /     / /_/ /   / __/     / /|_/ /   / __/     \__ \         / __ \/|        / / / /    / /
 / /     / __  /   / /___    / /  / /   / /___    ___/ /        / /_/  <        / /_/ /   _/ /
/_/     /_/ /_/   /_____/   /_/  /_/   /_____/   /____/         \____/\/        \____/   /___/

--]]
        --THEMES/UX/UI PLUGINS
        use "gruvbox-community/gruvbox"
        use 'eddyekofo94/gruvbox-flat.nvim'
        use 'beauwilliams/statusline.lua'
        use 'beauwilliams/focus.nvim'
        --TODO: Archive
        -- use 'romgrk/barbar.nvim' --> better tab bars using my own happy with it tho
        --[[ use {
            "vim-airline/vim-airline",
            requires = {'vim-airline/vim-airline-themes', 'ryanoasis/vim-devicons'},
            config = function()
                vim.g.airline_symbols = {
                    branch = "",
                    readonly = ""
                }
            end
        } ]]

        --TODO: Archive
        -- START: QUIKFIX configs, includes diag list, todo list, terminal, qflist
        use 'EthanJWright/toolwindow.nvim' -- A toolwindow for trouble, nvim-toggleterm, quickfix, todos
        use { -- toolwindow compatible terminal
            'akinsho/nvim-toggleterm.lua',
            config = 'require("toggleterm").setup{}'
        }
        use { --> toolwindow compatible list for navigating errors etc
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {
                }
            end
        }
        use {
            "folke/todo-comments.nvim", --> TOOLWWINDOW COMPATIBLE, Highlight and navigate comments in code
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup {
                }
            end
        }
        -- END: QUICKFIX configs
        use {"psliwka/vim-smoothie"} --  some very smooth ass scrolling
        use {"rrethy/vim-hexokinase", run = "make hexokinase"} -- preview hex colors with litle square
        use 'p00f/nvim-ts-rainbow' --> Treesitter compatible rainbow parentheses
        use {
            -- CURSOR FLASH --> helps orientate quicker switching windows etc cursorline flash when switch
            "danilamihailov/beacon.nvim",
            config = function()
                vim.g.beacon_size = 90
                vim.g.beacon_minimal_jump = 25
                vim.g.beacon_shrink = 0
            end
        }
        use {'lukas-reineke/indent-blankline.nvim', branch = 'lua', config = "vim.g.indent_blankline_char = '│'"}

        --TODO: ARCHIVE
        --[[ use { --> INDENT GUIDES/LINES
        "Yggdroot/indentLine",
        requires = "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.g.indentLine_char = "│"
            vim.g.indentLine_bufTypeExclude = {"help", "terminal"}
            vim.g.indentLine_fileTypeExclude = {"text", "markdown"}
        end
        } ]]
        --TODO: ARCHIVE
        --[[ use {'lukas-reineke/indent-blankline.nvim', branch = 'lua', --> USING LUA BRANCH FOR NOW
        config = function()
            vim.g.indent_blankline_char = '│'
        end,
        setup = function()
            vim.g.indent_blankline_char_highlight='Whitespace'
            vim.g.indent_blankline_buftype_exclude = {"help", "terminal"}
            vim.g.indent_blankline_filetype_exclude = {"text", "markdown"}
            vim.g.indent_blankline_bufname_exclude = 'startify'
        end
        } ]]

        use { --> STARTPAGE
        "mhinz/vim-startify",
        requires = "ryanoasis/vim-devicons"
        }
        use {
            -- VIM QUICKSCOPE --> after press t and f this highlights chars to help you nav faster
            "unblevable/quick-scope",
            setup = function()
                vim.api.nvim_exec(
                [[
                highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
                highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
                augroup qs_colors
                autocmd!
                autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
                autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
                augroup END
                ]],
                false
                )
            end
        }
        use {
            'numToStr/FTerm.nvim', --> Floating terminal window
            config = function()
                require'FTerm'.setup({
                    border = 'single'})
            end
        }
        --[[ use {
            --FLOATING TERMINAL CONFIG --> voldikss/vim-floaterm retired for fterm nvim
            "voldikss/vim-floaterm",
            config = function()
                vim.api.nvim_exec(
                [[
                let g:floaterm_keymap_toggle = '<Leader>t'
                let g:floaterm_width = 0.7
                "let g:floaterm_winblend = 5 "Transparency
                "let g:floaterm_wintype = 'floating' "neovim must have floating windows
                ]\],
                false
                )
            end
        } ]]
        -- use { 'habamax/vim-gruvbit' Another gruvbox alternative
        -- use { 'tjdevries/colorbuddy.nvim' -- REQUIRED for npxbr/gruvbox.nvim lua port of community/gruvbox
        -- use { 'npxbr/gruvbox.nvim' -- lua port of gruvbox community with treesitter support




--[[
    ____     ____    ____    ______    ____     ___     __  ___    __  ___    ____    _   __   ______
   / __ \   / __ \  / __ \  / ____/   / __ \   /   |   /  |/  /   /  |/  /   /  _/   / | / /  / ____/
  / /_/ /  / /_/ / / / / / / / __    / /_/ /  / /| |  / /|_/ /   / /|_/ /    / /    /  |/ /  / / __
 / ____/  / _, _/ / /_/ / / /_/ /   / _, _/  / ___ | / /  / /   / /  / /   _/ /    / /|  /  / /_/ /
/_/      /_/ |_|  \____/  \____/   /_/ |_|  /_/  |_|/_/  /_/   /_/  /_/   /___/   /_/ |_/   \____/
--]]

        use 'dbeniamine/cheat.sh-vim' --> E.G :Howin javascript open file || :Cheat! factory [takes &ft e.g lua/factory]
        --LANG PLUGS Language Servers / Linting / Snippets
        use {
            -- ALE CONFIG --> LANGUAGE ERROR DETECTION AND LINTING SERVICE
            --  Shorten error/warning flags
            "w0rp/ale",
            config = function()
                vim.api.nvim_exec(
                [[
                "let g:ale_echo_msg_error_str = 'A'
                "let g:ale_echo_msg_warning_str = 'B'
                "let g:ale_echo_msg_hint_str = 'C'
                " I have some custom icons for errors and warnings but feel free to change them.
                "⚠
                let g:ale_sign_error = '✘'
                let g:ale_sign_warning = ''
                "let g:ale_sign_information = ''
                "let g:ale_sign_error = '●'
                "let g:ale_sign_warning = '.'
                "let g:ale_lint_on_enter = 0 "Don't lint on enter hope this speeds things up/prevents lag
                ]],
                false
                )
            end
        }
        use 'haringsrob/nvim_context_vt' --> Show treesitter context at end of functions etc
        use {
            "nvim-treesitter/nvim-treesitter",
            --run = ":TSInstall all"
        }
        -- romgrk/nvim-treesitter-context
        -- use {  -- This is rad, but stupid slow right now.
        --   "romgrk/nvim-treesitter-context",
        --   requires = "nvim-treesitter/nvim-treesitter"
        -- }
        -- use "nvim-treesitter/nvim-treesitter-refactor"
        -- use {"nvim-treesitter/completion-treesitter", opt = true}
        -- use {
            --   "nvim-treesitter/playground",
            --   requires = "nvim-treesitter/nvim-treesitter"
            -- }

        use { --> A REPL Plugin to start / manage REPL
        "axvr/zepl.vim",
        config = function()
            vim.api.nvim_exec(
            [[
            cnoreabbrev repl Repl
            ]],
            false
            )
        end
        }
        use 'b3nj5m1n/kommentary' -- HIGHLY DOCUMENTED AND HACKABLE LUA BASED COMMENTING PLUGIN
        use 'hrsh7th/vim-vsnip' --> FAST SNIPPETS FOR NVIM
        use 'hrsh7th/vim-vsnip-integ' --> SNIPPET INTEGRATION WITH compe
        use 'rafamadriz/friendly-snippets' --> Snippets library compatible with vim-vsnip
        use 'neovim/nvim-lspconfig' --> PREMADE LSPCONFIGS
        use 'mfussenegger/nvim-jdtls' --> Better jdtls setup than lspconfig
        use 'nvim-lua/lsp-status.nvim' --> Lsp statusline
        -- use 'ojroques/nvim-lspfuzzy'  --> USE FZF FOR LSP NAVIGATION [CODE ACTION NOT WORKING..]
        use 'ray-x/lsp_signature.nvim' --> LSP SignatureInformation
        use 'hrsh7th/nvim-compe' --> COMPLETION MENU
        use 'Raimondi/delimitMate' --> Compatible with compe auto braces etc
        use 'kosayoda/nvim-lightbulb' --> CODE ACTION LIGHTBULB
        use 'nathunsmitty/nvim-ale-diagnostic' --> PIPE LSP DIAGS TO ALE
        use 'sbdchd/neoformat' -- Code formatting plugin
        use {'RRethy/vim-illuminate',  --> Highlight word under cursor
        config = function()
            vim.cmd[[    autocmd VimEnter * hi illuminatedWord guibg=#504648 guifg=none "cterm=grey gui=grey]]
            vim.cmd[[autocmd VimEnter * hi illuminatedCurWord cterm=none gui=none]]
        end,
        }
        use 'mizlan/iswap.nvim' --> Easily SWAP function variables using treesitter
        -- use 'Pocco81/DAPInstall.nvim' --> Install debugger automatically -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
        -- use 'ahmedkhalf/lsp-rooter.nvim'
        -- use 'skywind3000/vim-rt-format' --> Prettify current line on ENTER
        -- use 'michaelb/sniprun' --> RUN CODE SNIPPETS/BLOCKS

        -- use { --> LANGUAGE FILES AND SYNTAX. SUPPOSED TO NOT SLOW VIM DOWN BASICALLY AT ALL SO WHY NOT RUN FOR NOW
        --[[ "sheerun/vim-polyglot", --> REMOVED FOR NOW BECAUSE THEY KEEP MESSING WITH SWAP FILES & DOING TOO MUCH
        opt = true,
        event = "VimEnter *",
        setup = function()
            vim.g.polyglot_disabled = {"helm"}
        end, ]]
        --[[ config = function()
            vim.g.javascript_plugin_jsdoc = 1
            vim.g.vim_markdown_new_list_item_indent = 2
        end
                } ]]
        -- alexaandru/nvim-lspupdate USE THIS TO AUTO INSTALL LSP SERVERS
        -- use  'glepnir/lspsaga.nvim'
        -- use { 'uiiaoo/java-syntax.vim' "5/12/20 Retiring For Treesitter
        -- use { 'rust-lang/rust.vim' "5/12/20 Retiring for treesitter
        -- use 'jbyuki/instant.nvim' --> Collaborative pair programming in NVIM



--[[
   _____    ______   _____   _____    ____   ____     _   __           ___     _   __    ____
  / ___/   / ____/  / ___/  / ___/   /  _/  / __ \   / | / /          /   |   / | / /   / __ \
  \__ \   / __/     \__ \   \__ \    / /   / / / /  /  |/ /          / /| |  /  |/ /   / / / /
 ___/ /  / /___    ___/ /  ___/ /  _/ /   / /_/ /  / /|  /          / ___ | / /|  /   / /_/ /
/____/  /_____/   /____/  /____/  /___/   \____/  /_/ |_/          /_/  |_|/_/ |_/   /_____/
 _       __   ____     ____     __ __   _____    ____     ___    ______    ______   _____
| |     / /  / __ \   / __ \   / //_/  / ___/   / __ \   /   |  / ____/   / ____/  / ___/
| | /| / /  / / / /  / /_/ /  / ,<     \__ \   / /_/ /  / /| | / /       / __/     \__ \
| |/ |/ /  / /_/ /  / _, _/  / /| |   ___/ /  / ____/  / ___ |/ /___    / /___    ___/ /
|__/|__/   \____/  /_/ |_|  /_/ |_|  /____/  /_/      /_/  |_|\____/   /_____/   /____/
--]]
        -- SESSION/WORKSPACE MGMT -> :SaveSession :DeleteSession :ViewSession --> sessions saved
        use {
            "xolox/vim-session", -- Centralise sessions to a .sessions folder and easily save sessions with :SaveSession <name>
            requires = "xolox/vim-misc",
            config = function()
                vim.api.nvim_exec(
                [[
                "keep all sessions in one location
                let g:session_directory='~/.config/nvim/.session'
                "remove .vim from end of files so it looks nicer in startify
                let g:session_extension=''
                "Remove pop-up each time we close to ask to save session
                let g:session_autosave = 'no'
                "If I want to load a session I will specify it. We also have a start page
                "which displays recent sessions too so not need to auto load them
                let g:session_autoload = 'no'
                cnoreabbrev restart RestartVim
                cnoreabbrev mks SaveSession
                cnoreabbrev mksession SaveSession
                ]],
                false
                )
            end
        }
        -- use { 'tpope/vim-obsession' "Better vim sessions with :Obsess DEC20 Replace with vim-session for now as Obsess didn't fit me





--[[
    ______    ____    __     ______           _   __    ___  _    __
   / ____/   /  _/   / /    / ____/          / | / /   /   || |  / /
  / /_       / /    / /    / __/            /  |/ /   / /| || | / /
 / __/     _/ /    / /___ / /___           / /|  /   / ___ || |/ /
/_/       /___/   /_____//_____/          /_/ |_/   /_/  |_||___/
   ___             _____    ______    ___     ____    ______    __  __
  ( _ )           / ___/   / ____/   /   |   / __ \  / ____/   / / / /
 / __ \/|         \__ \   / __/     / /| |  / /_/ / / /       / /_/ /
/ /_/  <         ___/ /  / /___    / ___ | / _, _/ / /___    / __  /
\____/\/        /____/  /_____/   /_/  |_|/_/ |_|  \____/   /_/ /_/
--]]


        use {
            "kyazdani42/nvim-tree.lua",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }
        --[[ use 'preservim/nerdtree'
        use 'ms-jpq/chadtree' ]]
        --==========================START FZF CONFIGS=============================
        use {"junegunn/fzf", run = function()
            vim.fn["fzf#install"]()
        end}
        use {"junegunn/fzf.vim"}
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {
            'sudormrfbin/cheatsheet.nvim', --> Telescope Based Cheatsheet
            -- optional
            requires = {
                {'nvim-telescope/telescope.nvim'},
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'},
            }
        }
        use 'nvim-telescope/telescope-fzy-native.nvim'
        use 'nvim-telescope/telescope-symbols.nvim'
        use {
            --HELP MENU FOR FZF & VIM ctrl+p
            "laher/fuzzymenu.vim",
            config = function()
                vim.api.nvim_exec(
                [[
                let g:fuzzymenu_position =  'window'
                let g:fuzzymenu_size = {'height': 0.6, 'width': 0.9}
                ]],
                false
                )
            end
        }


        --use { 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } -- FILE BROWSER
        --use { 'tiagofumo/vim-nerdtree-syntax-highlight'
        --[[ use { -- NO LONGER NEEDED, but keep for now
            "junegunn/fzf.vim",
            requires = "/usr/local/opt/fzf",
            opt = true,
            event = "VimEnter *",
            config = function()
                vim.g.fzf_colors = {["bg+"] = {"bg", "Normal"}}
                --TODO: Convert to lua?
            end
        } ]]


--[[
   ______    ____  ______           ____     __    __  __   ______    ____    _   __   _____
  / ____/   /  _/ /_  __/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
 / / __     / /    / /            / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
/ /_/ /   _/ /    / /            / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
\____/   /___/   /_/            /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]
        -- use 'beauwilliams/nvim-blamer.lua' --> MY CUSTOM GIT BLAME PLUGIN
        use {
            'APZelos/blamer.nvim',
            config = function()
                -- vim.g.blamer_prefix = ' > '
                vim.g.blamer_enabled = 1
                vim.g.blamer_template = '<committer> │ <summary> │ <committer-time>'
                vim.g.blamer_date_format = '%d/%m/%y'
            end
        }

        use "mhinz/vim-signify" -- ASYNC GIT DIFF GUTTER
        use {"rhysd/git-messenger.vim"} -- leader-gb to GIT BLAME i.e who wrote that code commit info and navigate history at a glance
        use {"tpope/vim-fugitive"} -- Adds 'native' git commands to vim. silent commands. e.g :Git add - won't prompt you to enter to confirm
        --use {
            --"APZelos/blamer.nvim",
            --config = function()
                --vim.g.blamer_enabled = 1
                --end
                --} -- GIT LENS --> COMPANION CONFIG TO APZelos/blamer.nvim
        --use {"airblade/vim-gitgutter"} -- Git diff gutter. DEC 2020 REPLACED WITH SIGNIFY AS GIT GUTTER CAN SLOW THINGS DOWN




--[[
    __  ___    ____   _____   ______           ____     __    __  __   ______    ____    _   __   _____
   /  |/  /   /  _/  / ___/  / ____/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
  / /|_/ /    / /    \__ \  / /              / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
 / /  / /   _/ /    ___/ / / /___           / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
/_/  /_/   /___/   /____/  \____/          /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]

        use {"tpope/vim-eunuch"} -- Allows us to do cool UNIX CLI stuff like :Rename, Delete, Move, Mkdir, Chmod
        use 'lambdalisue/suda.vim' -- Neovim compatible :SudoWrite
        -- use {"airblade/vim-rooter"} -- sets cwd automatically if are in say a git folder etc
        use {"sedm0784/vim-you-autocorrect"} -- Vim autocorrection
        use {'ojroques/nvim-bufdel'} --> Better buffer deletion defaults
        use {"tpope/vim-surround"} -- all we need to remember is s, for surround. cs\" for ex OR ysiw' to surround current word with ''
        use {'NTBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' }} -- Open HTTP files - a curl wrapper




--[[
    ____     __    __  __   ______    ____    _   __   _____         ______    ______   _____  ______    ____    _   __   ______
   / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/        /_  __/   / ____/  / ___/ /_  __/   /  _/   / | / /  / ____/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \          / /     / __/     \__ \   / /      / /    /  |/ /  / / __
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /         / /     / /___    ___/ /  / /     _/ /    / /|  /  / /_/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/         /_/     /_____/   /____/  /_/     /___/   /_/ |_/   \____/
--]]
        --[[ use {-- Read man pages in vim easily with vman or :Man
        --NOTE: NO LONGER NEEDED. JUST USE :Telescope man_pages
        "jez/vim-superman",
        config = function()
            vim.api.nvim_exec([[
            cnoreabbrev man Man
            ]\], false)
        end
        } ]]

        -- use 'kevinhwang91/nvim-bqf' --> BETTER QF
        -- use 'monaqa/dial.nvim' BETTER INCREMENTING IN VIM (TO BE TESTED)
        -- use 'danth/pathfinder.vim' --> SUGGEST BETTER normal mode commands to navigate vim! [not working]
        -- use 'oknozor/illumination' --> :Illuminate, :IlluminateClose [MARKDOWN RENDERERER]
        -- use 'drzel/vim-repo-edit' --> PREVIEW GIT REPO [:RepoEdit https://github.com/drzel/vim-repo-edit]
        use 'npxbr/glow.nvim' --> might ned to run :GlowInstall --> :mdreader to read md
        use 'andweeb/presence.nvim' -- discord presence
        use {
            'kkoomen/vim-doge', -- DOcumentation GEnerator, Must run :call doge#install() first time for now TODO: fix
            run = "vim.cmd[[call doge#install()]]"
        }
        -- use {"lifepillar/vim-cheat40"} -- Adds configurable cheat sheet with <leader>? great for remembering my mappings and custom commands
        use 'nanotee/zoxide.vim' -- :Z command in vim, quickly jump to recent dirs
        -- use { 'michaelb/vim-tips' "Display vim tip at startup
        -- use { 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "A vim game
        -- use 'jiangmiao/auto-pairs' --> replaced with delimited mate, bettr with compe
        -- use 'chaoren/vim-wordmotion' --> IMPROVED VIM WORD MOTIONS, now includes _ and camel case etc.

        -- LUA/VIM DEVELOPMENT
        -- use 'notomo/lreload.nvim' --> Hot reloading for lua development
        -- use 'wadackel/nvim-syntax-info' Display highlight links etc using :SyntaxInfo


    end --> End of the packer(use) function
}
--[[
    ______    _   __    ____           ____     ______           ______    ____    __     ______
   / ____/   / | / /   / __ \         / __ \   / ____/          / ____/   /  _/   / /    / ____/
  / __/     /  |/ /   / / / /        / / / /  / /_             / /_       / /    / /    / __/
 / /___    / /|  /   / /_/ /        / /_/ /  / __/            / __/     _/ /    / /___ / /___
/_____/   /_/ |_/   /_____/         \____/  /_/              /_/       /___/   /_____//_____/
--]]





