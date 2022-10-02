-- NOTE: Currently using neoterm & nui
local Input = safe_require('nui.input')
local event = safe_require('nui.input')

if not Input or not event then
    return
end

local stored_task_command = nil

local trigger_set_command_input = function(callback_fn)
  local input_component = Input({
    position = "50%",
    size = {
      width = 50,
    },
    border = {
      style = "single",
      text = {
        top = "Command to run:",
        top_align = "center",
      },
    },
    win_options = {
    winblend = 10,
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  },
  }, {
      prompt = "> ",
      default_value = "",
      on_submit = function(value)
        stored_task_command = value
        callback_fn();
      end,
      on_close = function()
        print("Input Closed!")
      end,
    })

  --NOTE: close on buf leave
  input_component:mount()
  input_component:on('BufLeave', function()
    input_component:unmount()
  end)
  --NOTE: close on esc insert mode
  input_component:map("i", "<Esc>", function()
    input_component:unmount()
  end, { noremap = true })
  --NOTE: close on esc normal mode
  input_component:map("i", "<Esc>", function()
    input_component:unmount()
  end, { noremap = true })
end

vim.api.nvim_create_user_command('MyTermSetTaskCommand', function()
  trigger_set_command_input(function ()
  end)
end, {})

vim.api.nvim_create_user_command('MyTermRunTaskThenExit', function(input)
  local cmd = input.args
  vim.api.nvim_command(":Tnew")
  vim.api.nvim_command(":T " .. cmd .. " && exit")
  vim.api.nvim_command(":stopinsert")
end, { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('MyTermRunTaskCommand', function(input)
  local execute = function(cmd)
    vim.api.nvim_command(":1Tclear")
    vim.api.nvim_command(":1T " .. cmd)
    vim.api.nvim_command(":stopinsert")
  end

  local one_off_command = input.args

  if one_off_command and string.len(one_off_command) > 0 then
    execute(one_off_command)
  elseif stored_task_command == nil then
    trigger_set_command_input(function()
      execute(stored_task_command)
    end)
  else
    execute(stored_task_command)
  end
end, { nargs = '*' })
