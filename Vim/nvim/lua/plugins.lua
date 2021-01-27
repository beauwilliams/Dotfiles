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
        use {"psliwka/vim-smoothie"} --  some very smooth ass scrolling
        --use {
            --"vim-airline/vim-airline",
            --requires = {'vim-airline/vim-airline-themes', 'ryanoasis/vim-devicons'},
            --config = function()
                --vim.g.airline_symbols = {
                    --branch = "",
                    --readonly = ""
                --}
            --end
        --}
        --use {"ryanoasis/vim-devicons"} -- NOTE THIS MUST BE RUN AFTER AIRLINE THEMES PLUGINS
        use {"rrethy/vim-hexokinase", run = "make hexokinase"} -- preview hex colors
        use {
            -- CURSOR FLASH --> COMPANION CONFIG TO danilamihailov/beacon.nvim plugin
            "danilamihailov/beacon.nvim",
            config = function()
                vim.g.beacon_size = 90
                vim.g.beacon_minimal_jump = 25
                vim.g.beacon_shrink = 0
            end
        }
        use {
            "Yggdroot/indentLine",
            requires = "lukas-reineke/indent-blankline.nvim",
            config = function()
                vim.g.indentLine_char = "│"
                vim.g.indentLine_bufTypeExclude = {"help", "terminal"}
                vim.g.indentLine_fileTypeExclude = {"text", "markdown"}
            end
        }
        use {
            "mhinz/vim-startify",
            requires = "ryanoasis/vim-devicons"
        }
        use {
            -- VIM QUICKSCOPE --> COMPANION CONFIG TO unblevable/quick-scope
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
            end,
            config = function()
            end
        }
        use {
            "beauwilliams/FTerm.nvim",
            branch = "patch-1",
            setup = function()
                    vim.fn.nvim_set_keymap('n', '<leader>t', '<CMD>lua require"FTerm".toggle()<CR>', { noremap = true, silent = true })
                    vim.fn.nvim_set_keymap('t', '<leader>t', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>', { noremap = true, silent = true })
            end
        }
        --use {
             --""""""""""""""FLOATING TERMINAL CONFIG --> voldikss/vim-floaterm
            --"voldikss/vim-floaterm",
            --config = function()
                --vim.api.nvim_exec(
                    --[[
                    --let g:floaterm_keymap_toggle = '<Leader>t'
                    --let g:floaterm_width = 0.7
                    --"let g:floaterm_winblend = 5 "Transparency
                    --"let g:floaterm_wintype = 'floating' "neovim must have floating windows
                    --]]--,
                    --false
                --)
            --end
        --}
        use {
            -- RAINBOW BRACES --> COMPANION CONFIG TO luochen1990/rainbow
            "luochen1990/rainbow",
            config = function()
                vim.api.nvim_exec(
                    [[
                let g:rainbow_active = 1
                "set to 0 if you want to enable rainbow later via :RainbowToggle
                    ]],
                    false
                )
            end
        }

        --use {"lukas-reineke/indent-blankline.nvim"} -- an addition to indentline, we get solid lines now even between methods etc
        -- use { 'habamax/vim-gruvbit' Another gruvbox alternative
        -- use { 'https://github.com/noscript/cSyntaxAfter' -- Adds a little visual bling to () etc for semantic langs like c
        -- use { 'tjdevries/colorbuddy.nvim' -- REQUIRED for npxbr/gruvbox.nvim lua port of community/gruvbox
        -- use { 'npxbr/gruvbox.nvim' -- lua port of gruvbox community with treesitter support




--[[
    ____     ____    ____    ______    ____     ___     __  ___    __  ___    ____    _   __   ______
   / __ \   / __ \  / __ \  / ____/   / __ \   /   |   /  |/  /   /  |/  /   /  _/   / | / /  / ____/
  / /_/ /  / /_/ / / / / / / / __    / /_/ /  / /| |  / /|_/ /   / /|_/ /    / /    /  |/ /  / / __
 / ____/  / _, _/ / /_/ / / /_/ /   / _, _/  / ___ | / /  / /   / /  / /   _/ /    / /|  /  / /_/ /
/_/      /_/ |_|  \____/  \____/   /_/ |_|  /_/  |_|/_/  /_/   /_/  /_/   /___/   /_/ |_/   \____/
--]]
        --LANG PLUGS Language Servers / Linting / Snippets
        use {
            -- ALE CONFIG --> LANGUAGE ERROR DETECTION AND LINTING SERVICE
            --  Shorten error/warning flags
            "w0rp/ale",
            config = function()
                vim.api.nvim_exec(
                    [[
                    let g:ale_echo_msg_error_str = 'E'
                    let g:ale_echo_msg_warning_str = 'W'
                    " I have some custom icons for errors and warnings but feel free to change them.
                    "let g:ale_sign_error = '✘'
                    "let g:ale_sign_warning = '⚠'
                    let g:ale_sign_error = '●'
                    let g:ale_sign_warning = '.'
                    "let g:ale_lint_on_enter = 0 "Don't lint on enter hope this speeds things up/prevents lag
                    ]],
                    false
                )
            end
        }
        --use {
        --"neoclide/coc.nvim",
        --config = function()
        --end
        --}
        --use { 'yuki-ycino/fzf-preview.vim', run = ':UpdateRemotePlugins' }
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSInstall all",
            config = function()
                require("treesitter")
                -- TODO: Still a bit buggy
                -- vim.api.nvim_exec(
                --   [[
                --     set foldmethod=expr
                --     set foldexpr=nvim_treesitter#foldexpr()
                --   ]],
                --   false
                -- )
            end
        }
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

        use {"axvr/zepl.vim.git"} -- A REPL Plugin to start / manage REPL
        use {"sbdchd/neoformat"} -- Code formatting plugin
        -- NOTE: we need to clone eclips jdtls and run ./mvnw clean verify to get it working
        use {"preservim/nerdcommenter"} -- quick and easy commenting- setup to cmd+/ using iterm binding
        -- use { 'rust-lang/rust.vim' "5/12/20 Retiring for treesitter
        -- use { 'uiiaoo/java-syntax.vim' "5/12/20 Retiring For Treesitter
        --use 'SirVer/ultisnips' --> ultisnips is not great iwht neovim, vsnip is more modern and supports lsp
        use {
            'hrsh7th/vim-vsnip'
        } --config=require'plugins.vim-vsnip'
        use {'hrsh7th/vim-vsnip-integ'}
        use  'neovim/nvim-lspconfig'
        use  'nvim-lua/lsp-status.nvim'
        use  'nvim-lua/completion-nvim'
        use  'nathunsmitty/nvim-ale-diagnostic' --> PIPE LSP DIAGS TO ALE
        --use  'nvim-lua/lsp-status.nvim'
        use 'RRethy/vim-illuminate'
        use { --> USE FZF FOR LSP NAVIGATION
            'ojroques/nvim-lspfuzzy',
            --requires = {
              --{'junegunn/fzf'},
              --{'junegunn/fzf.vim'},  -- to enable preview (optional)
            --},
        }




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
                    cnoreabbrev mks SaveSession
                    cnoreabbrev mksession SaveSession
                    ]],
                    false
                )
            end
        }





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
        --==========================START FZF CONFIGS=============================
        use {"junegunn/fzf", run = function()
                vim.fn["fzf#install"]()
            end}
        use {"junegunn/fzf.vim"}
        --use {
        --"junegunn/fzf.vim",
        --requires = "/usr/local/opt/fzf",
        --opt = true,
        --event = "VimEnter *",
        --config = function()
        --vim.g.fzf_colors = {["bg+"] = {"bg", "Normal"}}
        --TODO: Convert to lua?
        --end
        --}
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

        -- use { 'tpope/vim-obsession' "Better vim sessions with :Obsess DEC20 Replace with vim-session for now as Obsess didn't fit me




--[[
   ______    ____  ______           ____     __    __  __   ______    ____    _   __   _____
  / ____/   /  _/ /_  __/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
 / / __     / /    / /            / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
/ /_/ /   _/ /    / /            / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
\____/   /___/   /_/            /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]
        --use {"airblade/vim-gitgutter"} -- Git diff gutter. DEC 2020 REPLACED WITH SIGNIFY AS GIT GUTTER CAN SLOW THINGS DOWN
        use "mhinz/vim-signify" -- ASYNC GIT DIFF GUTTER
        use {"rhysd/git-messenger.vim"} -- leader-gb to GIT BLAME i.e who wrote that code commit info and navigate history at a glance
        use {"tpope/vim-fugitive"} -- Adds 'native' git commands to vim. silent commands. e.g :Git add - won't prompt you to enter to confirm
        --use 'beauwilliams/nvim-blamer.lua' --> MY CUSTOM GIT BLAME PLUGIN
        --use {
            --"APZelos/blamer.nvim",
            --config = function()
                --vim.g.blamer_enabled = 1
            --end
        --} -- GIT LENS --> COMPANION CONFIG TO APZelos/blamer.nvim




--[[
    __  ___    ____   _____   ______           ____     __    __  __   ______    ____    _   __   _____
   /  |/  /   /  _/  / ___/  / ____/          / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/
  / /|_/ /    / /    \__ \  / /              / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \
 / /  / /   _/ /    ___/ / / /___           / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /
/_/  /_/   /___/   /____/  \____/          /_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/
--]]
        use {"tpope/vim-eunuch"} -- Allows us to do cool UNIX CLI stuff like :SudoWrite to write to read only files
        use {"airblade/vim-rooter"} -- sets cwd automatically if are in say a git folder etc
        use {"sedm0784/vim-you-autocorrect"} -- Vim autocorrection




--[[
    ____     __    __  __   ______    ____    _   __   _____         ______    ______   _____  ______    ____    _   __   ______
   / __ \   / /   / / / /  / ____/   /  _/   / | / /  / ___/        /_  __/   / ____/  / ___/ /_  __/   /  _/   / | / /  / ____/
  / /_/ /  / /   / / / /  / / __     / /    /  |/ /   \__ \          / /     / __/     \__ \   / /      / /    /  |/ /  / / __
 / ____/  / /___/ /_/ /  / /_/ /   _/ /    / /|  /   ___/ /         / /     / /___    ___/ /  / /     _/ /    / /|  /  / /_/ /
/_/      /_____/\____/   \____/   /___/   /_/ |_/   /____/         /_/     /_____/   /____/  /_/     /___/   /_/ |_/   \____/
--]]
        use 'jiangmiao/auto-pairs'
        use {"tpope/vim-surround"} -- all we need to remember is s, for surround. cs\" for ex OR ysiw' to surround current word with ''
        use {
            "jez/vim-superman",
            config = function()
                vim.api.nvim_exec([[
                    cnoreabbrev man Man
                    ]], false)
            end
        } -- Read man pages in vim easily with vman or :Man

        use 'kkoomen/vim-doge' -- DOcumentation GEnerator, Must run :call doge#install() first time for now TODO: fix
        use {"lifepillar/vim-cheat40"} -- Adds configurable cheat sheet with <leader>? great for remembering my mappings and custom commands
        -- use { 'michaelb/vim-tips' "Display vim tip at startup
        -- use { 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "A vim game

                --NOTE: Polyglot currently disables swapfiles I have sent PR
        use {
            "sheerun/vim-polyglot",
            opt = true,
            event = "VimEnter *",
            setup = function()
                vim.g.polyglot_disabled = {"helm"}
            end,
            config = function()
                vim.g.javascript_plugin_jsdoc = 1
                vim.g.vim_markdown_new_list_item_indent = 2
            end
        }
        -- use {
        --   "nvim-telescope/telescope.nvim",
        --   requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        --   config = function()
        --     vim.api.nvim_exec(
        --       [[
        --         nnoremap <C-p> <cmd>lua require'telescope.builtin'.git_files{}<CR>
        --       ]]--,
        --       false
        --     )
        --   end
        -- }
    end
}
--[[
    ______    _   __    ____           ____     ______           ______    ____    __     ______
   / ____/   / | / /   / __ \         / __ \   / ____/          / ____/   /  _/   / /    / ____/
  / __/     /  |/ /   / / / /        / / / /  / /_             / /_       / /    / /    / __/
 / /___    / /|  /   / /_/ /        / /_/ /  / __/            / __/     _/ /    / /___ / /___
/_____/   /_/ |_/   /_____/         \____/  /_/              /_/       /___/   /_____//_____/
--]]





