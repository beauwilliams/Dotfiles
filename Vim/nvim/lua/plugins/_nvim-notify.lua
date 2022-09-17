local telescope = safe_require('telescope')
local notify = safe_require('notify')
local stages_util = safe_require('notify.stages.util')

if not telescope or not notify or not stages_util then
  return
end

-- NOTE: Load telescope extension
telescope.load_extension("notify")

-- NOTE: Make sure windows are not focusable
-- Have a custom implementation below it is set there for now
--[[ require("notify").setup({
  on_open = function (win)
    vim.api.nvim_win_set_config(win, { focusable = false })
  end,
}) ]]





local function bottom_up() return {
  function(state)
    local next_height = state.message.height + 2
    local next_row =
      stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
    if not next_row then
      return nil
    end
    return {
      relative = "editor",
      anchor = "NE",
      width = state.message.width,
      height = state.message.height,
      col = vim.opt.columns:get(), --I START HERE
      row = next_row,
      border = "rounded",
      style = "minimal",
      opacity = 0,
      --NOTE: here is non focusable option
      focusable = false,
    }
  end,
  function(state, win)
    return {
      opacity = { 100 },
      col = { vim.opt.columns:get() }, --I FIRST STOP HERE,
      row = {
        stages_util.slot_after_previous(win, state.open_windows, stages_util.DIRECTION.BOTTOM_UP),
        frequency = 3,
        complete = function()
          return true
        end,
      },
    }
  end,
  function(state, win)
    return {
      col = { vim.opt.columns:get()}, --I SECOND STOP HERE
      time = true,
      row = {
        stages_util.slot_after_previous(win, state.open_windows, stages_util.DIRECTION.BOTTOM_UP),
        frequency = 3,
        complete = function()
          return true
        end,
      },
    }
  end,
  function(state, win)
    return {
      -- NOTE Slide animation
      --[[ width = {
        1,
        frequency = 2.5,
        damping = 0.9,
        complete = function(cur_width)
          return cur_width < 3
        end,
      }, ]]
      opacity = {
        0,
        frequency = 2,
        complete = function(cur_opacity)
          return cur_opacity <= 4
        end,
      },
      -- col = { vim.opt.columns:get()}, -- Slide out animation...
      row = {
        stages_util.slot_after_previous(win, state.open_windows, stages_util.DIRECTION.BOTTOM_UP),
        frequency = 3,
        complete = function()
          return true
        end,
      },
    }
  end,
}
end






local opts = {
  fps = 60,
  level = 2,
  minimum_width = 50,
  render = "default",
  direction = 'left_right',
  stages = bottom_up(),
  max_width = 80,
  max_height = 15,
  timeout = 2500,
  background_colour = "Normal",
  icons = {
    DEBUG = " ",
    ERROR = " ",
    INFO = " ",
    TRACE = "✎ ",
    WARN = " "
        },
}

notify.setup(opts)
--NOTE: here I set notify as default
vim.notify = notify


