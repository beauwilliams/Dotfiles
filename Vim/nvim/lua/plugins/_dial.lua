local augend = safe_require('dial.augend')
local config = safe_require('dial.config')
if not config or not augend then
	return
end

config.augends:register_group {
	default = {
		augend.integer.alias.decimal_int,
		augend.constant.alias.bool,
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%d/%m/%Y"],
		augend.date.alias["%H:%M:%S"],
		augend.date.alias["%H:%M"],
		augend.constant.new {
			elements = { "&&", "||" },
			word = false,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		},
	},
}
