local M = {}

function M.set_scoped_options(locality, options)
	local scopes = { o = vim.o, b = vim.bo, g = vim.g, w = vim.wo }
	local scope = scopes[locality]
	for key, value in pairs(options) do
		scope[key] = value
	end
end

return M

-----------------------
-----------------------
------DEPRECATED-------
-----------------------
-----------------------

-- SET OPTS --> EG --> opt('b', 'expandtab', true)
--[[ local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end ]]

