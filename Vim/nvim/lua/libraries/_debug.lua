-- Inspector
-- ':lua printi(vim.fn.getwininfo())'
_G.printi = function(stuff)
	return vim.inspect(stuff)
end

-- Pwetty
-- ':lua printd(fn.get_value())'
_G.printp = function(stuff)
	return vim.pretty_print(stuff)
end

-- Dumper
-- ':lua printd(vim.fn.getwininfo())'
function _G.printd(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end
