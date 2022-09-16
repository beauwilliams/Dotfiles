--Print stuff
P = function(stuff)
	return print(vim.inspect(stuff))
end

-- help to inspect results, e.g.:
-- ':lua _G.dump(vim.fn.getwininfo())'
function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end
