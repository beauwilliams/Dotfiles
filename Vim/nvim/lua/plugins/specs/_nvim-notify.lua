return {
	-- Notifications plugin for Neovim
	{
		'rcarriga/nvim-notify',
		event = 'VeryLazy', -- Load after startup (or lazy-loaded as needed)
		config = function()
			local telescope = safe_require('telescope')
			local notify = safe_require('notify')
			local stages_util = safe_require('notify.stages.util')

			if not telescope or not notify or not stages_util then
				return
			end

			-- Load telescope extension for notify
			telescope.load_extension('notify')

			-- Custom function for notification display (bottom-up)
			local function bottom_up()
				return {
					function(state)
						local next_height = state.message.height + 2
						local next_row =
							stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
						if not next_row then
							return nil
						end
						return {
							relative = 'editor',
							anchor = 'NE',
							width = state.message.width,
							height = state.message.height,
							col = vim.opt.columns:get(),
							row = next_row,
							border = 'rounded',
							style = 'minimal',
							opacity = 0,
							focusable = false, -- Make the window non-focusable
						}
					end,
					function(state, win)
						return {
							opacity = { 100 },
							col = { vim.opt.columns:get() },
							row = {
								stages_util.slot_after_previous(
									win,
									state.open_windows,
									stages_util.DIRECTION.BOTTOM_UP
								),
								frequency = 3,
								complete = function()
									return true
								end,
							},
						}
					end,
					function(state, win)
						return {
							col = { vim.opt.columns:get() },
							time = true,
							row = {
								stages_util.slot_after_previous(
									win,
									state.open_windows,
									stages_util.DIRECTION.BOTTOM_UP
								),
								frequency = 3,
								complete = function()
									return true
								end,
							},
						}
					end,
					function(state, win)
						return {
							opacity = {
								0,
								frequency = 2,
								complete = function(cur_opacity)
									return cur_opacity <= 4
								end,
							},
							row = {
								stages_util.slot_after_previous(
									win,
									state.open_windows,
									stages_util.DIRECTION.BOTTOM_UP
								),
								frequency = 3,
								complete = function()
									return true
								end,
							},
						}
					end,
				}
			end

			-- Configure notification options
			local opts = {
				fps = 60,
				level = 2,
				minimum_width = 50,
				render = 'default',
				direction = 'left_right',
				stages = bottom_up(),
				max_width = 80,
				max_height = 15,
				timeout = 2500,
				background_colour = 'Normal',
				icons = {
					DEBUG = ' ',
					ERROR = ' ',
					INFO = ' ',
					TRACE = '✎ ',
					WARN = ' ',
				},
			}

			-- Setup nvim-notify with options
			notify.setup(opts)

			-- Set notify as the default message handler
			vim.notify = notify
		end,
	},
}
