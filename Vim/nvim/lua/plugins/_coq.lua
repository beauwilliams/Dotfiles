local vim = vim
vim.g.coq_settings = {
	auto_start = 'shut-up',
	['clients.tabnine.enabled'] = true,
	['display.icons.spacing'] = 2,
	['keymap.recommended'] = false,
	--,   ["keymap.jump_to_mark"] = "<leader><tab>"
}

-- More here https://github.com/ms-jpq/coq.thirdparty

require('coq_3p')({
	-- conf_only :: Maybe bool :: only return results if current document is relative to $NVIM_HOME, default yes
	{ src = 'nvimlua', short_name = 'nLUA', conf_only = false },
	-- { src = "vimtex", short_name = "vTEX" },
	-- ...
	-- { src = "demo" },
	-- { src = "dap" }
})
