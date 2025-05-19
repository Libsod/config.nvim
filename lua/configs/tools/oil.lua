-- This file defines configuration options for oil.nvim, a file explorer plugin for Neovim
-- that aims to provide a fast and intuitive way to navigate and manage files.

-- Main configuration table for oil.nvim.
local options = {
  -- If true, files deleted via oil.nvim will be moved to the system trash/recycle bin
  -- instead of being permanently deleted. This is currently disabled.
  delete_to_trash = false,
  -- If true, simple edits like renaming or creating a file might not require
  -- an explicit confirmation step.
  skip_confirm_for_simple_edits = true,
  -- Constrains the cursor movement within the oil.nvim buffer.
  -- "name" means the cursor will be primarily constrained to the file/directory name column.
  constrain_cursor = "name",
  -- Enables an experimental feature that watches for file system changes
  -- and attempts to update the oil.nvim view automatically.
  experimental_watch_for_changes = true,
  -- Default options for the main oil.nvim view.
  view_options = {
    -- If true, hidden files and directories (those starting with a dot) will be shown by default.
    show_hidden = true,
    -- sort = { ... } -- Could define default sort order here.
    -- is_hidden_file = function(name, bufnr) ... end -- Custom logic to determine hidden files.
  },
  -- Configuration for displaying oil.nvim in a floating window.
  float = {
    -- Padding (in cells) inside the floating window border.
    padding = 2,
    -- Sets the maximum height of the floating window, calculated dynamically
    -- based on the current Neovim window height.
    max_height = math.ceil(vim.o.lines - 4), -- Leaves 4 lines for cmdline, statusline, etc.
    -- Sets the maximum width of the floating window, calculated as 75% of the current Neovim window width.
    max_width = math.ceil(vim.o.columns * 0.75),
    -- Sets the border style for the floating window to "single".
    border = "single",
    -- Additional options passed to `nvim_open_win` when creating the floating window.
    win_options = {
      -- Sets the transparency level of the floating window. 0 is fully opaque.
      winblend = 0,
    },
    -- A function to override the final floating window configuration.
    -- By default, it returns the configuration unmodified.
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the file preview window within oil.nvim.
  preview = {
    -- Sets the border style for the preview window to "rounded".
    border = "single",
    -- max_width = 0.4, -- Example: Preview window takes 40% of oil window width.
    -- min_width = 30,  -- Example: Minimum width for preview.
  },
  -- Defines custom keymappings for actions within oil.nvim buffers.
  -- The values are strings representing built-in oil.nvim actions.
  keymaps = {
    ["g?"] = "actions.show_help", -- Show help/available actions.
    ["<Tab>"] = "actions.select", -- Select/open the item under the cursor.
    ["<C-v>"] = "actions.select_vsplit", -- Open in a new vertical split.
    ["<C-h>"] = "actions.select_split", -- Open in a new horizontal split. (Note: <C-s> is save, <C-h> often left)
    ["<C-t>"] = "actions.select_tab", -- Open in a new tab.
    ["<C-p>"] = "actions.preview", -- Toggle file preview.
    ["q"] = "actions.close", -- Close the oil.nvim window.
    ["<C-r>"] = "actions.refresh", -- Refresh the current directory listing.
    ["-"] = "actions.parent", -- Navigate to the parent directory.
    ["_"] = "actions.open_cwd", -- Open oil.nvim in the current working directory of Neovim.
    ["`"] = "actions.cd", -- Change Neovim's current working directory to the selected directory.
    ["~"] = "actions.tcd", -- Change Neovim's tab-local current working directory.
    ["gs"] = "actions.change_sort", -- Cycle through sorting options.
    ["gx"] = "actions.open_external", -- Open the selected file/directory with the system's default application.
    ["g."] = "actions.toggle_hidden", -- Toggle visibility of hidden files.
    ["g\\"] = "actions.toggle_trash", -- Toggle whether delete operations move to trash (if supported).
  },
  -- Disables oil.nvim's default keymappings, ensuring that only the custom keymaps
  -- defined above (or any remaining defaults not overridden) are active.
  use_default_keymaps = false,
}

return options
