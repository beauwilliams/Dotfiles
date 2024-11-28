local utils = safe_require('libraries._set_mappings')
if not utils then
	return
end

local leader = '<space>'
-- CODE FORMATTERS
--Remove indents from code! (a simple code formatter)
utils.nnoremap(leader .. 'i', 'gg=G<c-o>')
-- Run Neoformat
utils.nnoremap(leader .. 'F', ':lua require("conform").format()<CR>')
