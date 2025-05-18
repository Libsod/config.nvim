-- This file defines configuration options for lsp_signature.nvim,
-- a plugin that displays function signature help (parameter hints)
-- as you type or on demand.

local M = {}

-- The primary configuration table for lsp_signature.nvim.
M.cfg = {
  -- If true, enables default keybindings provided by the plugin for triggering signature help.
  -- For example, often automatically shows signature on typing '(' or ','.
  bind = true,

  -- Options passed to the handler that creates the signature help window.
  handler_opts = {
    -- Sets the border style for the floating signature help window to "single".
    border = "single",
  },

  -- If true, enables virtual text hints for the current parameter. This is disabled.
  hint_enable = false,
  -- If true, long signature lines will be wrapped within the floating window. This is disabled.
  wrap = false,

  -- Specifies the maximum width of the signature help window in columns.
  max_width = 115,

  -- Horizontal offset (in columns) for the floating window from the cursor position.
  -- 0 means it will align directly with the cursor or as determined by other positioning logic.
  floating_window_off_x = 0,
  -- If true, positions the floating signature help window above the current line
  -- if there isn't enough space below.
  floating_window_above_cur_line = true,
}

return M
