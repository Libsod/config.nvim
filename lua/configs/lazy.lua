return {
  -- Default settings applied to all plugins unless overridden.
  defaults = {
    -- Enables lazy-loading for all plugins by default.
    lazy = true,
  },
  -- Configuration for the installation process of plugins.
  install = {
    -- Specifies that the "nvchad" colorscheme (or a theme named "nvchad" if it's a base46 theme)
    -- should be applied after plugins are installed or updated.
    colorscheme = { "nvchad" },
  },
  -- Sets the maximum number of concurrent tasks lazy.nvim can run (e.g., for cloning or building plugins).
  -- A higher number can speed up operations on multi-core systems.
  concurrency = 20,

  -- Configuration for lazy.nvim's user interface (e.g., the status window shown with :Lazy).
  ui = {
    -- Enables line wrapping within lazy.nvim's UI elements for better readability of long lines.
    wrap = true,
    -- Sets the border style for UI elements to "single".
    border = "single",
    -- Defines custom icons used in lazy.nvim's UI to represent different states or elements.
    icons = {
      ft = "", -- Icon for filetype indicators.
      lazy = "󰂠 ", -- Icon for plugins managed by lazy.nvim.
      loaded = "", -- Icon for successfully loaded plugins.
      not_loaded = "", -- Icon for plugins that are not yet loaded.
    },
  },

  -- Performance-related configurations for lazy.nvim.
  performance = {
    -- Configuration for caching Lua modules to speed up Neovim's startup time.
    cache = {
      -- Enables the module caching feature.
      enabled = true,
      -- Specifies the file system path where the cache will be stored.
      path = vim.fn.stdpath "cache" .. "/lazy/cache",
      -- Defines events that, upon triggering, will temporarily disable caching.
      -- This is to prevent issues with modules that might not behave correctly when cached
      -- during certain operations like initial UI setup or before reading a buffer.
      disable_events = { "UIEnter", "BufReadPre" }, -- Note: "BufRebdPre" might be a typo for "BufReadPre".
      -- Sets the time-to-live (TTL) for unused cached modules, in seconds.
      -- Unused modules will be kept in the cache for up to 2 days (3600s * 24h * 2d).
      ttl = 3600 * 24 * 2,
    },

    -- Configuration for manipulating Neovim's runtime path (rtp).
    rtp = {
      -- A list of built-in Vim/Neovim plugins that will be disabled.
      -- Disabling unused standard plugins can slightly improve startup time and reduce clutter.
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "sql_completion",
        "remote_plugins",
        "rplugin",
        "syntax", -- NOTE: Disabling "syntax" might have broad effects if not using Tree-sitter for all highlighting.
        "syntax_completion",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin", -- NOTE: Disabling "ftplugin" might prevent filetype-specific settings from loading unless handled elsewhere.
      },
    },
  },
}
