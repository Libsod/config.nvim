-- This file configures trouble.nvim, a plugin for displaying diagnostics,
-- LSP references, TODOs, and other items in a structured list.

-- Defines a table of configuration options for trouble.nvim.
local options = {
  -- Automatically closes the Trouble window if it becomes empty (no items to display).
  auto_close = true,
  -- Prevents the Trouble window from automatically opening when new items (e.g., diagnostics) appear.
  auto_open = false,
  -- Automatically opens a preview (e.g., of the code location) when an item in the Trouble list is selected.
  auto_preview = true,
  -- Automatically refreshes the Trouble list with the latest information when it's already open.
  auto_refresh = true,
  -- Prevents automatically jumping to an item if it's the only one in the list.
  auto_jump = false,
  -- Sets the Trouble window to be focused when it is opened.
  focus = true,
  -- Restores the previously selected item and scroll position when reopening the Trouble list.
  restore = true,
  -- Keeps the Trouble list synchronized with the currently selected item if possible (e.g., cursor moves in buffer).
  follow = true,
  -- Displays indent guides within the Trouble list for better visual structure.
  indent_guides = true,
  -- Limits the maximum number of items displayed per section in the Trouble list to prevent clutter.
  max_items = 200,
  -- Allows diagnostic messages or other items in the list to span multiple lines if necessary.
  multiline = true,
  -- If set to true, an opened Trouble window would be bound to the current buffer,
  -- meaning it would only show items relevant to that buffer. Currently disabled.
  pinned = false,
  -- Shows a warning message if a Trouble command is run (e.g., :Trouble diagnostics) but finds no results.
  warn_no_results = true,
  -- Prevents the Trouble window from opening if a command is run that yields no results.
  open_no_results = false,
  -- signs = { ... } -- Default signs are used as this section is omitted.
  -- use_diagnostic_signs = false -- Default behavior for diagnostic signs is used.
}

return options
