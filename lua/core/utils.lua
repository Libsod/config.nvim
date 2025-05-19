local M = {}

-- Function M.toggle_inlay_hints
-- Purpose: Toggles the visibility of LSP inlay hints for the current buffer.
function M.toggle_inlay_hints()
  -- Get the current buffer number.
  local bufnr = vim.api.nvim_get_current_buf()
  -- Create a filter to specify that the inlay hint operation should apply only to the current buffer.
  local filter = { bufnr = bufnr }
  -- Check if inlay hints are currently enabled for the buffer.
  -- The 'enabled' variable will be set to the opposite of the current state, effectively toggling it.
  local enabled = not vim.lsp.inlay_hint.is_enabled(filter)
  -- Enable or disable inlay hints based on the new 'enabled' state for the specified buffer.
  vim.lsp.inlay_hint.enable(enabled, filter)
end

-- Function M.hover_opts
-- Purpose: Calculates and returns an options table for `vim.lsp.buf.hover()`.
-- This function adaptively sizes and positions the LSP hover window to avoid
-- overlapping with the statusline and to fit content nicely on the screen.
function M.hover_opts()
  -- Get the total number of screen lines available in the Neovim instance.
  local total_lines = vim.o.lines
  -- Set the desired hover window height to be 60% of the total screen lines.
  local desired_height = math.floor(total_lines * 0.6)

  -- Calculate the number of lines reserved at the bottom of the screen.
  -- This includes the command line height (`cmdheight`) and one line for the statusline
  -- if `laststatus` is set to show it (value > 0).
  local bottom_reserved = vim.o.cmdheight + ((vim.o.laststatus or 0) > 0 and 1 or 0)

  -- Account for the border of the hover window, which typically takes one line at the top and one at the bottom.
  local border_overhead = 2
  -- Define a vertical offset: how many lines below the cursor the hover window should start.
  local cursor_offset = 1

  -- Get the screen position (row, column) of the top-left corner of the current window (window 0).
  -- These are 1-indexed values.
  local window_pos = vim.fn.win_screenpos(0)
  -- Compute the cursor's absolute screen row (0-indexed).
  -- `window_pos[1]` is the screen row of the window's top.
  -- `vim.fn.winline()` is the cursor's line number within the window (1-indexed).
  -- Subtract 1 to make it 0-indexed relative to the window top, then add window's screen row.
  local cursor_screen_row = window_pos[1] + vim.fn.winline() - 1

  -- Calculate how many lines of content can actually fit below the cursor before hitting the statusline.
  local space_below_cursor = total_lines -- Start with total screen lines
    - bottom_reserved -- Subtract lines taken by cmdline/statusline
    - cursor_screen_row -- Subtract lines above the cursor (and the cursor line itself)
    - cursor_offset -- Subtract the intended offset from the cursor
    - border_overhead -- Subtract the lines for the hover window's border
    + 1 -- Add 1 because the cursor line itself is a potential start if offset is 0. More accurately, this adjusts for 0-indexing vs 1-indexing in subtractions.

  -- Determine the halfway point of the usable screen area (excluding bottom reserved lines).
  -- This is used to decide whether to prioritize fitting content below the cursor if it's in the upper half.
  local halfway_point = math.ceil((total_lines - bottom_reserved) / 2)

  -- Determine the final height for the hover window.
  local final_height = desired_height
  -- If the desired height is too tall to fit in the space below the cursor,
  -- AND the cursor is in the upper half of the screen,
  -- then clamp the hover window's height to the available space below the cursor.
  -- Otherwise (if there's enough space, or cursor is in lower half), use the desired_height.
  if space_below_cursor < desired_height and cursor_screen_row <= halfway_point then
    final_height = space_below_cursor
  end
  -- Ensure final_height is at least a minimal value (e.g., 1 or more, depending on border)
  -- to prevent negative or zero height which might cause errors.
  final_height = math.max(1, final_height) -- Ensure at least 1 line for content if borders are handled.

  -- Return the configured options table for `vim.lsp.buf.hover()`.
  return {
    border = "single", -- Use a single border style for the hover window.
    silent = true, -- Suppress any extra messages when showing the hover.
    title = nil, -- Do not display a title line in the hover window.
    wrap = true, -- Enable text wrapping for long lines within the hover window.
    offset_row = cursor_offset, -- Set the vertical offset from the cursor line.
    max_width = math.floor(vim.o.columns * 0.6), -- Limit max width to 60% of screen columns.
    max_height = final_height, -- Use the dynamically computed final height.
  }
end

return M
