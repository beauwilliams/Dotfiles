local gotopreview = safe_require('goto-preview')
if not gotopreview then
	return
end

gotopreview.setup {
    width = 120, -- Width of the floating window
    height = 25, -- Height of the floating window
    border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
    opacity = 5, -- 0-100 opacity level of the floating window where 100 is fully transparent
    default_mappings = false, -- Bind default mappings
    focus_on_open = true, -- Focus the floating window when opening it
    dismiss_on_move = false, -- Dismiss the floating window when moving the cursor
    resizing_mappings = false, -- Binds arrow keys to resizing the floating window
    force_close = true, -- Force close the last window of a buffer eve with unwritten changes. See :h nvim_win_close
    bufhidden = "wipe", -- Specifies what happens when a buffer is no longer displayed in a window. See :h bufhidden
    debug = false, -- Print debug information

    -- Setup a post_open_hook that gets called right before setting the cursor position in the new floating window
    post_open_hook = function(buf_handle, win_handle)
        -- Set a keymap that will close the floating window
        vim.api.nvim_buf_set_keymap(
            buf_handle,
            "n",
            "q",
            ("<Cmd>call nvim_win_close(%d, v:false)<CR>"):format(win_handle),
            { noremap = true }
        )
    end,
}

-- utils.map("n", "gp", "<Cmd>lua require('goto-preview').goto_preview_definition()<CR>")
-- utils.map("n", "gP", "<Cmd>lua require('goto-preview').close_all_win()<CR>")
