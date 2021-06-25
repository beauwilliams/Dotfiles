local snap = require'snap'
local config = require'snap.config'

local file = config.file:with {reverse = false, suffix = " »", layout = snap.get"layout".top}
local vimgrep = config.vimgrep:with {limit = 50000, suffix = " »"}
-- local args = {"--hidden", "--iglob", "!**/.git/*", "--iglob", "!**/.baks/*", "--iglob", "!**/.langservers/*", "--iglob", "!**/.undo/*", "--iglob", "!**/.session/*", "--iglob", "!**/coc/**","--ignore-case", "--follow",}
local args = {"--follow", "--hidden", "-g", "!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*"}

snap.maps {
  {"<Leader>f", vimgrep {prompt = "Grep"}, "grep"},
  {"<Leader>s", file {args = args, producer = "ripgrep.file", prompt = "Files"}, "files"},
  {"<Leader>S", file {producer = "vim.oldfile", prompt = "History"}, "history"},
  {"<Leader>b", file {producer = "vim.buffer", prompt = "Buffers"}, "buffers"},
  {"<Leader>2", file {
      args = args,
      try = {snap.get'consumer.combine'(
      snap.get'producer.ripgrep.file'.args({}, "/Users/admin/.config/nvim"),
      snap.get'producer.ripgrep.file'.args({}, "/Users/admin/.config/zsh")
      )},
      prompt = "Search Dotfiles"
  }, "search dotfiles"},
  {"<Leader>df", vimgrep {
      args = args,
      try = {snap.get'consumer.combine'(
      snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/*")
      -- snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/zsh")
      )},
      prompt = "Grep Dotfiles"
  }, "grep dotfiles"},
}
-- "-g", "!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes}/*"


--[[ snap.register.map('n', '<Leader>e', snap.create(function ()
  return {
  producer = snap.get'consumer.fzf'(snap.get'producer.git.file'),
  select = snap.get'select.file'.select,
  multiselect = snap.get'select.file'.multiselect,
  views = {snap.get'preview.file'}
  }
end))

-- creates normal mode mapping <Leader>f for grepping files in cwd
snap.register.map('n', '<Leader>f', snap.create(function ()
  return {
    producer = snap.get'producer.ripgrep.vimgrep',
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get'preview.vimgrep'}
  }
end))

-- normal mode mapping <Leader><Leader> for searching files in cwd
snap.register.map('n', '<Leader>s', snap.create(function ()
  return {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end)) ]]
