local snap = require'snap'
local defaults = require'snap.defaults'

local file = defaults.file:with {reverse = false, suffix = " »"}
local vimgrep = defaults.vimgrep:with {limit = 50000, suffix = " »"}
local args = {"--hidden", "--iglob", "!.git/*"}

snap.maps {
  {"<Leader>f", vimgrep {args = args, prompt = "Grep"}, "grep"},
  {"<Leader>s", file {args = args, try = {"git.file", "ripgrep.file"}, prompt = "Files"}, "files"},
  {"<Leader>S", file {producer = "vim.oldfile", prompt = "History"}, "history"},
  {"<Leader>b", file {producer = "vim.buffer", prompt = "Buffers"}, "buffers"},
  -- {"<Leader>aaaa", file {combine = {"vim.buffer", "vim.oldfiles"}}}
}

--[[ snap.register.map({'n'}, {'<Leader>fb'}, function ()
  snap.run({
    prompt = 'Buffers',
    producer = fzy(producer_buffer),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = {preview_file}
  })
end)

snap.register.map({'n'}, {'<Leader>fo'}, function ()
  snap.run({
    prompt = 'Oldfiles',
    producer = fzy(producer_oldfile),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = {preview_file}
  })
end)

snap.register.map({'n'}, {'<Leader>m'}, function ()
  snap.run({
    prompt = 'Grep',
    producer = limit(10000, producer_vimgrep),
    select = select_vimgrep.select,
    multiselect = select_vimgrep.multiselect,
    initial_filter = vim.fn.expand('<cword>')
  })
end) ]]
