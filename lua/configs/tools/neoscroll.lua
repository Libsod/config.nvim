local options = {
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = {
    "<C-u>",
    "<C-d>",
    "<C-b>",
    "<C-f>",
    "zt",
    "zz",
    "zb",
  },
  hide_cursor = false, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = "sine", -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
  performance_mode = true,
}

require("neoscroll").setup(options)
