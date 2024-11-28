local cmd = vim.cmd
--TODO: ABBREVIATIONS refactor
------------------------------------------------------------------------------------------------------------------------------------------------
-- ABBREVIATIONS
------------------------------------------------------------------------------------------------------------------------------------------------
--TOGGLE LIGHT/DARK THEME
-- cmd([[cnoreabbrev light lua vim.o.background = 'light']])
-- cmd([[cnoreabbrev dark lua vim.o.background = 'dark']])
-- cmd([[cnoreabbrev light colorscheme github_light]])
-- cmd([[cnoreabbrev dark colorscheme gruvbox <bar> lua vim.o.background = 'dark']])

--CHEATSHEAT
cmd([[cnoreabbrev cheat Cheatsheet]])
cmd([[cnoreabbrev cheatedit CheatsheetEdit]])

--Clipboard
cmd(
	[[cnoreabbrev clipboard lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({}))]]
)

--SESSION MANAGEMENT (VIA STARTIFY)
cmd([[
    cnoreabbrev mks SSave
    cnoreabbrev mksession SSave
    cnoreabbrev lds SLoad
    cnoreabbrev ldsession SLoad
    cnoreabbrev dls SDelete
    cnoreabbrev dlsession SDelete
]])

cmd('cnoreabbrev <silent> spellauto exe SpellAuto()')
cmd('cnoreabbrev <silent> spelloff exe SpellOff()')
cmd('cnoreabbrev spelladd spell')

-- Enable use to write to ----READONLY---- files using --> w!! (i.e. Add an extra !)
-- utils.cnoremap('w!!', "<esc>:lua require'_utils'.sudo_write()<CR>")
cmd('cnoreabbrev w!! lua require"libraries._utils".sudo_write()')
-- vim.cmd('cnoreabbrev w!! SudaWrite')

-- MARKDOWN RENDERER [glow.nvim]
cmd('cnoreabbrev mdreader MarkdownPreview')

--  Saves the shift key I force quit a lot!
cmd('cnoreabbrev qq q!')

--  zoxide vim and :y print command switching
cmd('cnoreabbrev Z z')
cmd('cnoreabbrev z Z')

-- FUGITIVE/GIT
-- cmd('cnoreabbrev <silent>gp :G push')

--PACKER
cmd([[cnoreabbrev pc PackerCompile]])
cmd([[cnoreabbrev pu PackerUpdate]])
cmd([[cnoreabbrev pi PackerInstall]])
cmd([[cnoreabbrev ps PackerSync]])
cmd([[cnoreabbrev pcl PackerClean]])
