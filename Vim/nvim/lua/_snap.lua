local snap = require("snap")
local config = require("snap.config")
local file = config.file:with({ reverse = true, suffix = " »", layout = snap.get("layout").center })
local vimgrep = config.vimgrep:with({ limit = 50000, suffix = " »" })
-- local args = {"--hidden", "--iglob", "!**/.git/*", "--iglob", "!**/.baks/*", "--iglob", "!**/.langservers/*", "--iglob", "!**/.undo/*", "--iglob", "!**/.session/*", "--iglob", "!**/coc/**","--ignore-case", "--follow",}
local args = {
	"--follow",
	"--hidden",
	"-g",
	"!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*",
}

snap.maps({
	{
		"<leader>s",
		file({
			try = {
				snap.get("producer.git.file").args({ "--cached", "--others", "--exclude-standard" }),
				snap.get("producer.ripgrep.file").args({
					"--follow",
					"--hidden",
					"-g",
					"!{.backup,.swap,.langservers,.session,.undo,.git,node_modules,vendor,.cache,.vscode-server,.Desktop,.Documents,classes,.DS_STORE}/*",
				}),
			},
			prompt = "Files",
		}),
	},
	{ "<Leader>f", vimgrep({ prompt = "Grep" }), { command = "grep" } },
	{ "<Leader>S", file({ producer = "vim.oldfile", prompt = "History" }), { command = "history" } },
	{ "<Leader>b", file({ producer = "vim.buffer", prompt = "Buffers" }), { command = "buffers" } },
	{
		"<Leader>ds",
		file({
			args = args,
			try = {
				snap.get("consumer.combine")(
					snap.get("producer.ripgrep.file").args({}, "/Users/admin/.config/nvim"),
					snap.get("producer.ripgrep.file").args({}, "/Users/admin/.config/zsh")
				),
			},
			prompt = "Search Dotfiles",
		}),
		{ command = "search dotfiles" },
	},
	{
		"<Leader>df",
		vimgrep({
			args = args,
			try = {
				snap.get("consumer.combine")(
					snap.get("producer.ripgrep.vimgrep").args({}, "/Users/admin/.config/*")
					-- snap.get'producer.ripgrep.vimgrep'.args({}, "/Users/admin/.config/zsh")
				),
			},
			prompt = "Grep Dotfiles",
		}),
		{ command = "grep dotfiles" },
	},
})
