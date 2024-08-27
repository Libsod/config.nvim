local options = {
  views = {
    hover = {
      scrollbar = false,
      size = {
        width = "auto",
        height = "auto",
        max_width = 115,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
    },
    cmdline_popup = {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = 80,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = "75%",
        col = "50%",
      },
      size = {
        width = 80,
        height = 8,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
      },
    },
  },

  cmdline = {
    enabled = true, -- enables the Noice cmdline UI
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = {}, -- global options for the cmdline. See section on views
    ---@type table<string, CmdlineFormat>
    format = {
      cmdline = { pattern = "^:", icon = " ", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      input = {}, -- Used by input()
    },
  },

  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = true, -- enables the Noice messages UI
    view = "notify", -- default view for messages
    view_error = "notify", -- view for errors
    view_warn = "notify", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },

  popupmenu = {
    enabled = true, -- enables the Noice popupmenu UI
    ---@type 'nui'|'cmp'
    backend = "nui", -- backend to use to show regular cmdline completions
    ---@type NoicePopupmenuItemKind|false
    -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
    kind_icons = {}, -- set to `false` to disable icons
  },

  -- default options for require('noice').redirect
  -- see the section on Command Redirection
  ---@type NoiceRouteConfig
  redirect = {
    view = "popup",
    filter = { event = "msg_show" },
  },

  lsp = {
    progress = {
      enabled = true,
      --- @type NoiceFormat|string
      format = {
        { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
        { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
        { "%{data.progress.percentage} ", hl_group = "NoiceCmdlinePopup" },
        { "{spinner} ", hl_group = "NoiceCmdlinePopup" },
      },
      --- @type NoiceFormat|string
      format_done = {
        { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
        { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
        { " ", hl_group = "NoiceLspProgressSpinner" },
      },
      view = "mini",
    },

    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },

    hover = {
      enabled = false,
      silent = true, -- set to true to not show a message if hover is not available
      view = nil, -- when nil, use defaults from documentation
      ---@type NoiceViewOptions
      opts = {}, -- merged with defaults from documentation
    },

    signature = {
      enabled = false,
    },

    message = {
      -- Messages shown by lsp servers
      enabled = true,
      view = "notify",
      opts = {},
    },

    -- defaults for hover and signature help
    documentation = {
      view = "hover",
      ---@type NoiceViewOptions
      opts = {
        lang = "markdown",
        replace = true,
        render = "markdown",
        format = { "{message}" },
        win_options = { concealcursor = "n", conceallevel = 3 },
      },
    },
  },

  markdown = {
    hover = {
      ["|(%S-)|"] = vim.cmd.help, -- vim help links
      ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
    },

    highlights = {
      ["|%S-|"] = "@text.reference",
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
    },
  },

  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
}

return require("noice").setup(options)
