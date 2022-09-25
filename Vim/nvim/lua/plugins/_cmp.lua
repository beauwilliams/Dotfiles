local icons = safe_require('libraries._icons')
local cmp = safe_require('cmp')
local cmp_comparators = safe_require('copilot_cmp.comparators')
local luasnip = safe_require('luasnip')
local luasnip_vscode = safe_require('luasnip.loaders.from_vscode')


if not icons or not cmp or not cmp_comparators or not luasnip or not luasnip_vscode then
	return
end


local kind_icons = icons.kind
luasnip_vscode.lazy_load() --> loads friendly snippets
require("luasnip.loaders.from_vscode").lazy_load({paths = {vim.fn.stdpath("config") .. "/snippets/vscode-snippets"}})

local check_backspace = function()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		['<C-y>'] = cmp.config.disable,
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<up>'] = cmp.mapping.select_prev_item(),
		['<down>'] = cmp.mapping.select_next_item(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			'i',
			's',
		}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			'i',
			's',
		}),
	},
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, vim_item)
			vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
			vim_item.menu = ({
				copilot = '[cop]',
				nvim_lsp_signature_help = '[sig]',
				buffer = '[buf]',
				nvim_lsp = '[lsp]',
				nvim_lua = '[api]',
				luasnip = '[spt]',
				path = '[pat]',
				tn = '[tb9]',
				cmdline = '[cmd]',
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = 'nvim_lsp_signature_help', group_index = 1 },
		{ name = 'copilot', group_index = 2, max_item_count = 3 },
		{ name = 'luasnip', group_index = 2 },
		{ name = 'path' , group_index = 2 },
		{ name = 'nvim_lsp', group_index = 2 },
		{ name = 'nvim_lua', group_index = 2 },
		{ name = 'buffer', group_index = 2 },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = false, --like copolit, inlay completion hints
	},
	view = {},
	sorting = {
		-- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
		comparators = {
			require('copilot_cmp.comparators').prioritize,
			require('copilot_cmp.comparators').score,
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			-- copied from cmp-under, but I don't think I need the plugin for this.
			-- I might add some more of my own.
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find('^_+')
				local _, entry2_under = entry2.completion_item.label:find('^_+')
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	}),
})
-- `/` cmdline setup.
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{
			name = 'buffer',
			max_item_count = 15,
			keyword_length = 1,
		},
	},
})
cmp.setup.cmdline('?', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{
			name = 'buffer',
			max_item_count = 15,
			keyword_length = 1,
		},
		--[[ {
		{ name = "nvim_lsp_document_symbol" },
	}, ]]
	},
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline({}),
	formatting = {
		fields = { 'menu', 'abbr', 'kind' },
		format = function(entry, vim_item)
			vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
			vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, 50) -- hack to clamp cmp-cmdline-history len
			vim_item.menu = ({
				cmdline = '[cmd]',
				fuzzy_path = '[pat]',
				buffer = '[buf]',
				cmdline_history = '[his]',
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = 'cmdline_history', priority = 2, group_index = 2 },
		{ name = 'cmdline', priority = 2, group_index = 1 },
		{ name = 'fuzzy_path', priority = 1, group_index = 2 }, -- from tzacher
		{ name = 'buffer', priority = 1, group_index = 2 },
	}),
})

-- Add vim-dadbod-completion in sql files
--_ =
--    vim.cmd [[
--  augroup DadbodSql
--    au!
--    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
--  augroup END
--]]
--
--_ =
--    vim.cmd [[
--  augroup CmpZsh
--    au!
--    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
--  augroup END
--]]

--[[
" Disable cmp for a buffer
-- autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]

-- Setup lspconfig. NOTE: This snippet is saved here but placed in lspconfig
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
