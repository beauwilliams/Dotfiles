-- TODO: Teal and Moonscript equivalents!

local status, fennel = pcall(require, "fennel")
if not status then
	return nil
end

function _fennel_runtime_searcher(name)
	--[[
  Based on vim._load_package() in
  <https://github.com/neovim/neovim/blob/52e660e8570346d28f5c7f5dde0a5ca9b614a801/src/nvim/lua/vim.lua#L112-L134>.

  Manually searching the Vim &runtimepath is easier than trying to keep it
  tightly synchronized with the Lua package.path. We take the same approach for
  loading Fennel modules, skipping fennel.path entirely in favor of manually
  searching &runtimepath and returning loaders accordingly.
  --]]
	local basename = name:gsub("%.", "/")

	if vim.env.NVIM_FENNEL_DEBUG then
		print(string.format("Nvim-Fennel: Seeking loader for '%s'", basename))
	end

	local paths = {
		-- "lua/"..basename..".fnl",
		-- "lua/"..basename.."/init.fnl",
		-- "fnl/"..basename..".fnl",
		-- "fnl/"..basename.."/init.fnl",
		"fennel/" .. basename .. ".fnl",
		"fennel/" .. basename .. "/init.fnl",
	}

	for _, path in ipairs(paths) do
		local found = vim.api.nvim_get_runtime_file(path, false)
		if #found > 0 then
			if vim.env.NVIM_FENNEL_DEBUG then
				print(string.format("Nvim-Fennel: Returning loader for %s (%s)", basename, found[1]))
			end
			return function()
				if vim.env.NVIM_FENNEL_DEBUG then
					print(string.format("Nvim-Fennel: Executing loader for %s (%s)", basename, found[1]))
				end
				return fennel.dofile(found[1])
			end
		end
	end
end

if vim.env.NVIM_FENNEL_DEBUG then
	print("Loaders before Fennel init:")
	for _, searcher in ipairs(package.loaders) do
		print("  " .. tostring(searcher))
	end
end

--[[
Neovim's runtimepath Lua searcher is added at the front of `package.loaders`.
In order to make sure that compiled Lua is picked up BEFORE raw Fennel, we need
to make sure that our runtimepath Fennel searcher is located after the Neovim
runtimepath Lua searcher. But it should be located before the default searchers
in order to be consistent with Nvim's search semantics.

The final order should be something like this:

| Order | Provider     | Search method                 |
|-------|--------------|-------------------------------|
| 1     | Nvim         | Runtimepath Lua source        |
| 2     | this script  | Runtimepath Fennel source     |
| 3     | Lua built-in | Tables in package.preload     |
| 4     | Lua built-in | Lua source in package.path    |
| 5     | Lua built-in | C libraries in package.cpath  |
| 6     | built-in     | C "all-in-one" loader         |
| 7     | Fennel       | Fennel source in fennel.path  |

Refer to the Lua 5.1 manual for more information on module loading:
* http://www.lua.org/manual/5.1/manual.html#pdf-require
* http://www.lua.org/manual/5.1/manual.html#pdf-package.loaded
* http://www.lua.org/manual/5.1/manual.html#pdf-package.preload
* http://www.lua.org/manual/5.1/manual.html#pdf-package.loaders
* http://www.lua.org/manual/5.1/manual.html#pdf-package.path
* http://www.lua.org/manual/5.1/manual.html#pdf-package.cpath
--]]

-- Enable the default Fennel searcher, which looks in `fennel.path`
table.insert(package.loaders, fennel.searcher)

-- Enable our runtimepath Fennel searcher, which bypasses the `fennel.path`
-- lookup and finds Fennel files in runtimepath. This is analogous to how
-- Nvim's built-in runtimepath Lua searcher works:
-- https://github.com/neovim/neovim/blob/52e660e8570346d28f5c7f5dde0a5ca9b614a801/src/nvim/lua/vim.lua#L134
table.insert(package.loaders, 2, _fennel_runtime_searcher)

if vim.env.NVIM_FENNEL_DEBUG then
	print("Loaders after Fennel init:")
	for _, searcher in ipairs(package.loaders) do
		print("  " .. tostring(searcher))
	end
end

return fennel
