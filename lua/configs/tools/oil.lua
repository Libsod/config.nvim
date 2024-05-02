local options = {
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)j
  delete_to_trash = false,

  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = true,

  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "name",

  -- Set to true to watch the filesystem for changes and reload oil
  experimental_watch_for_changes = true,

  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_height = math.ceil(vim.o.lines - 4),
    max_width = math.ceil(vim.o.columns * 0.75),
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  preview = {
    border = "rounded",
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<Tab>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["q"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
}

return require("oil").setup(options)
