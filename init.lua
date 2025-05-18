-- Defines the cache directory for the base46 theming system, used by NvChad.
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
-- Sets the leader key to a space, a common convention for custom mappings.
vim.g.mapleader = " "

-- Ensures lazy.nvim, the plugin manager, is installed and available.
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  -- Clones the lazy.nvim repository if it's not found at the specified path.
  -- Uses a shallow clone (--filter=blob:none) and the stable branch for efficiency and stability.
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
-- Adds lazy.nvim's path to Neovim's runtime path, allowing it to be loaded.
vim.opt.rtp:prepend(lazypath)

-- Loads the main configuration options for lazy.nvim itself from a dedicated file.
-- These options control lazy.nvim's behavior (e.g., UI, performance settings).
local lazy_config = require "configs.lazy"

-- Initializes lazy.nvim with plugin specifications.
require("lazy").setup({
  {
    -- The core NvChad framework plugin.
    "NvChad/NvChad",
    -- Ensures NvChad is loaded immediately at startup, not lazily.
    lazy = false,
    -- Specifies the v2.5 branch of NvChad to be used.
    branch = "v2.5",
    -- Imports NvChad's default set of plugins, which form the base of its functionality.
    import = "nvchad.plugins",
  },

  -- Imports user-defined plugin specifications from the 'plugins' directory.
  -- This is where custom plugins and overrides for NvChad plugins are typically placed.
  { import = "plugins" },
}, lazy_config) -- Passes the loaded lazy_config table to lazy.nvim's setup.

-- Applies theme defaults and statusline styles managed by NvChad's base46 theming system.
-- These commands directly source cached theme files.
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Loads custom autocommands and editor options.
require "core.autocmds"
require "core.options"

-- Defines and applies Neovide-specific GUI settings if using the Neovide frontend.
local function neovide_config()
  -- Sets the font family, size, and rendering options for Neovide.
  vim.o.guifont = "Iosevka Nerd Font:h19:#e-antialias:#h-none"
  -- Adjusts the spacing between lines.
  vim.opt.linespace = 6
  -- Configures Neovide to remember its window size across sessions.
  vim.g.neovide_remember_window_size = true
  -- Hides the mouse cursor when typing in Neovide.
  vim.g.neovide_hide_mouse_when_typing = true
  -- Sets the target refresh rate for Neovide's display.
  vim.g.neovide_refresh_rate = 120
  -- Disables scroll animation for distant lines, potentially improving performance.
  vim.g.neovide_scroll_animation_far_lines = 0
  -- Configures the length of the cursor trail effect.
  vim.g.neovide_cursor_trail_size = 0.55
  -- Allows Neovide to enter an idle state with a lower refresh rate when inactive.
  vim.g.neovide_no_idle = false
  -- Sets a lower refresh rate for when Neovide is idle.
  vim.g.neovide_refresh_rate_idle = 30
  -- Disables Neovide's built-in profiler.
  vim.g.neovide_profiler = false
  -- Configures how the macOS Option key is treated (as Meta or Alt).
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  -- Disables anti-aliasing specifically for the cursor, potentially for a sharper look.
  vim.g.neovide_cursor_antialiasing = false
  -- Enables cursor animation when on the command line.
  vim.g.neovide_cursor_animate_command_line = true
  -- Sets a visual effect mode for the cursor, like "pixiedust".
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- Adjusts the density of particles for the cursor visual effect.
  vim.g.neovide_cursor_vfx_particle_density = 2.0
  -- Potentially decouples border highlights from main window highlights for custom theming.
  vim.g.neovide_unlink_border_highlights = true
  -- Enables cursor animations specifically while in insert mode.
  vim.g.neovide_cursor_animate_in_insert_mode = true

  -- Sets up macOS-style Cmd-key shortcuts for common actions within Neovide.
  vim.keymap.set("n", "<D-s>", ":w<cr>") -- Cmd-S to save.
  vim.keymap.set("v", "<D-c>", '"+y') -- Cmd-C to copy to system clipboard.
  vim.keymap.set("n", "<D-v>", '"+P') -- Cmd-V to paste from system clipboard in normal mode.
  vim.keymap.set("v", "<D-v>", '"+P') -- Cmd-V to paste from system clipboard in visual mode.
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Cmd-V to paste into command-line mode.
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Cmd-V to paste in insert mode.
end

-- Configures system clipboard integration, specifically tailored for macOS using pbcopy/pbpaste.
local function clipboard_config()
  vim.g.clipboard = {
    name = "macOS-clipboard", -- A descriptive name for the clipboard configuration.
    -- Specifies the system commands for copying to the '+' (system) and '*' (selection) registers.
    copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    -- Specifies the system commands for pasting from the '+' and '*' registers.
    paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 0, -- Disables Neovim's internal clipboard caching.
  }
end

-- Apply Neovide and clipboard configurations if Neovide is detected.
-- The clipboard_config might be useful even outside Neovide if on macOS.
if vim.g.neovide then
  neovide_config()
end

-- Call clipboard_config() conditionally based on OS, or always if it's safe.
-- For now it's macOS specific
if vim.fn.has "macunix" then -- Check if on macOS
  clipboard_config()
end

-- Schedules the loading of custom keymappings.
-- Using vim.schedule ensures that mappings are loaded after plugins and other initial setup,
-- preventing potential issues with mappings being defined before their target commands exist.
vim.schedule(function()
  require "core.mappings"
end)
