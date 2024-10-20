local M = {}

local function floating_window_y()
  local pumheight = vim.o.pumheight
  local winline = vim.fn.winline()
  local winheight = vim.fn.winheight(0)

  local remaining_space_below = winheight - winline

  if remaining_space_below < pumheight then
    return -pumheight
  elseif winline - 1 < pumheight then
    return pumheight
  else
    return 0
  end
end

M.cfg = {
  bind = true,

  handler_opts = {
    border = "rounded",
  },

  hint_enable = false,
  wrap = false,

  max_width = 115,

  floating_window_off_x = 5, -- adjust float window's x position.
  floating_window_off_y = floating_window_y, -- dynamically adjust float window's y position based on cursor location.
}

return M
