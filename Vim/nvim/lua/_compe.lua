local compe = require('compe')
local api = vim.api
local vim = vim
local protocol = require('vim.lsp.protocol')

vim.cmd('highlight link CompeDocumentation Black')

-- INIT
compe.setup {
  enabled = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  --source_timeout = ... number ...;
  --incomplete_delay = ... number ...;
  allow_prefix_unmatch = false;
  -- documentation = true; -- what does this do?
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = {menu = '[BUF]'};
    vsnip = {menu = '[SPT]'};
    nvim_lsp = {menu = '[LSP]'};
    nvim_lua = {menu = '[LUA]'};
    treesitter = {menu = '[TRS]'};
    neorg = {menu = '[ORG]'}
    -- spell = true;
    -- tags = true;
    -- snippets_nvim = true;
  };
}

-- SET SNIPPETS PATH
vim.g.vsnip_snippet_dir = vim.fn.stdpath("config").."/snippets"
vim.g.vsnip_filetypes = {
  javascriptreact = {'javascript', 'html'},
  typescriptreact = {'typescript', 'html'}
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"
-- api.nvim_command('set completeopt+=menu,longest,menuone,noinsert,noselect') --> This cuases small error with compe, might be noinsert

--" Avoid showing message extra message when using completion
api.nvim_command('set shortmess+=c')



-- CONFIGURES ICONS NEXT TO COMPLETION ITEMS FOR LSP
-- HOW CAN WE ADD BUFFER ICONS?
-- inspo from onsails/lspkind-nvim
protocol.CompletionItemKind = {
  ' Text';        -- = 1
  'ƒ Method';      -- = 2;
  'ƒ Function';    -- = 3; or 
  ' Constructor'; -- = 4;
  'ƒ Field';         -- = 5;
  ' Variable';    -- = 6;
  ' Class';       -- = 7;
  'ﰮ Interface';   -- = 8;
  ' Module';      -- = 9;
  ' Property';    -- = 10;
  ' Unit';        -- = 11;
  ' Value';       -- = 12;
  '了Enum';        -- = 13;
  ' Keyword';     -- = 14;
  '﬌ Snippet';     -- = 15;
  ' Color';       -- = 16;
  ' File';        -- = 17;
  ' Reference';     -- = 18;
  ' Folder';      -- = 19;
  ' EnumMember';  -- = 20;
  ' Constant';    -- = 21;
  ' Struct';      -- = 22;
  'ﯓ Event';         -- = 23;
  ' Operator';      -- = 24;
  ' TypeParameter'; -- = 25;
}
