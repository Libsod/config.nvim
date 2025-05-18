---@class ChadrcConfig
local M = {}

-- LSP specific configurations.
M.lsp = {
  -- Disables NvChad's default lsp_signature plugin integration,
  -- which would otherwise automatically display function signature help during typing.
  signature = false,
}

-- Configurations for Mason, a Neovim plugin to manage LSP servers, linters, and formatters.
M.mason = {
  -- Specifies a list of packages that Mason should ensure are installed
  -- beyond those managed by NvChad's default LSP setup or other specific plugin configurations.
  -- This ensures "asmfmt" (an assembly language formatter) is available.
  pkgs = { "asmfmt" },
}

-- UI specific configurations for the NvChad setup.
M.ui = {
  -- Sets the active NvChad colorscheme.
  theme = "catppuccin",

  -- Configuration for the statusline.
  statusline = {
    -- Sets the visual theme for the statusline.
    theme = "vscode_colored", -- Or your preferred statusline theme

    -- Custom modules to be displayed in the statusline.
    modules = {
      -- Custom module to display active LSP clients for the current buffer.
      lsp_clients = function()
        -- Get the buffer number for the window where the statusline is being rendered.
        -- vim.g.statusline_winid is expected to be set by NvChad's statusline engine.
        -- Defaults to the current window (0) if not set.
        local current_bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)

        -- Check if LSP is available and if we have a valid buffer number.
        if not rawget(vim, "lsp") or not current_bufnr then
          return "" -- Return empty if LSP is not loaded or no buffer.
        end

        -- Get all LSP clients attached to this specific buffer.
        local active_clients = vim.lsp.get_clients { bufnr = current_bufnr }
        local num_clients = #active_clients

        -- If no active clients for this buffer, display nothing.
        if num_clients == 0 then
          return ""
        end

        local lsp_icon = " " -- Icon for LSP.
        local client_names_list = {}

        -- Collect names of up to the first 3 clients.
        for i = 1, math.min(num_clients, 3) do
          table.insert(client_names_list, active_clients[i].name)
        end
        local names_str = table.concat(client_names_list, ", ")

        local result_text
        -- Conditionally format the output string based on available column width.
        if vim.o.columns > 110 then -- Plenty of space
          -- Show icon, "LSP ~", and up to 3 client names.
          result_text = string.format(" %sLSP ~ %s ", lsp_icon, names_str)
        elseif vim.o.columns > 70 then -- Medium space
          if num_clients == 1 then
            -- Show icon, "LSP ~", and the single client's name.
            result_text = string.format(" %sLSP ~ %s ", lsp_icon, active_clients[1].name)
          else
            -- Show icon, "LSP", and the count of active clients.
            result_text = string.format(" %sLSP (%d) ", lsp_icon, num_clients)
          end
        else -- Limited space
          -- Show only icon and "LSP".
          result_text = string.format(" %sLSP ", lsp_icon)
        end

        -- Applies the 'St_lsp' highlight group (expected to be defined by NvChad's statusline theme)
        -- and resets highlighting afterwards with '%*'.
        return "%#St_lsp#" .. result_text .. "%*"
      end,
    },

    -- Purpose: Defines the order and components displayed in the statusline.
    -- "mode": Current Neovim mode (Normal, Insert, etc.).
    -- "file": Current filename and related info.
    -- "git": Git branch and status information.
    -- "%=": Flexible spacer for alignment.
    -- "lsp_msg": Messages from the LSP server (e.g., progress).
    -- "diagnostics": Summary of code diagnostics (errors, warnings).
    -- "lsp_clients": Custom LSP clients module.
    -- "cwd": Current working directory.
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp_clients", "cwd" },
  },

  -- Tabufline configuration (a line that shows buffers/tabs, often at the top)
  tabufline = {
    -- Purpose: Defines the order of components in the tabufline.
    -- "treeOffset": Likely an offset for NvimTree or a similar file explorer.
    -- "buffers": List of open buffers.
    -- "tabs": List of Neovim tabs.
    order = { "treeOffset", "buffers", "tabs" },
  },

  -- Cmp (nvim-cmp, completion plugin) specific UI configurations
  cmp = {
    -- Purpose: Sets the visual style for the nvim-cmp completion menu.
    -- "default" is one of the NvChad predefined styles.
    style = "default",
    -- Purpose: If true, completion item icons (e.g., for functions, variables) are displayed
    -- to the left of the completion text.
    icons_left = true,
  },
}

-- Configurations for Base46, NvChad's theming system.
M.base46 = {
  -- Sets the active color scheme for Neovim, using the "catppuccin" theme.
  theme = "catppuccin",

  -- Defines additional custom highlight groups or modifies existing ones from the theme.
  -- These highlights are layered on top of the base theme.
  hl_add = {
    -- Customizes foreground color for the Noice plugin's command line icon.
    NoiceCmdlineIcon = { fg = "pink" },
    -- Inherits styling for Noice plugin's command line popup border from NoiceCmdlineIcon.
    NoiceCmdlinePopupBorder = { link = "NoiceCmdlineIcon" },
    -- Inherits styling for matches in Noice's popup menu from NoiceCmdlineIcon.
    NoicePopupmenuMatch = { link = "NoiceCmdlineIcon" },
    -- Inherits styling for Noice's mini view from NoiceCmdlineIcon.
    NoiceMini = { link = "NoiceCmdlineIcon" },
    -- Inherits styling for Noice's command line popup from NoiceCmdlineIcon.
    NoiceCmdlinePopup = { link = "NoiceCmdlineIcon" },
    -- Inherits styling for Noice's format confirmation prompt from NoiceCmdlineIcon.
    NoiceFormatConfirm = { link = "NoiceCmdlineIcon" },
    -- Customizes foreground color for Noice plugin's command line popup title.
    NoiceCmdlinePopupTitle = { fg = "red" },
    -- Inherits styling for Noice's LSP progress title from NoiceCmdlinePopupTitle.
    NoiceLspProgressTitle = { link = "NoiceCmdlinePopupTitle" },
    -- Customizes foreground color for the Noice plugin's command line area.
    NoiceCmdline = { fg = "sun" },
    -- Defines the highlighting for the currently active search match.
    CurSearch = { fg = "black2", bg = "cyan" },
    -- Defines the highlighting for the region of text that has been yanked (copied).
    Yank = { fg = "black2", bg = "cyan" },
  },

  -- Overrides existing highlight groups defined by the theme or Neovim defaults.
  hl_override = {
    -- Modifies the 'Error' highlight, potentially to make errors less visually distracting by removing explicit foreground color.
    Error = { fg = "NONE" },
    -- Customizes the default search highlight, using a specific background color.
    Search = { fg = "NONE", bg = "one_bg2" },
    -- Makes the visual selection highlight the same as the 'Search' highlight.
    Visual = { link = "Search" },
    -- Makes the incremental search highlight the same as the 'CurSearch' highlight.
    IncSearch = { link = "CurSearch" },
    -- Ensures floating windows use the 'Normal' text highlighting.
    NormalFloat = { link = "Normal" },
    -- Ensures the WhichKey plugin's floating window uses 'Normal' text highlighting.
    WhichKeyFloat = { link = "Normal" },
    -- Styles the general popup menu (e.g., completion menu) like 'Normal' text.
    Pmenu = { link = "Normal" },
    -- Styles the selected item in a popup menu like the 'CursorLine' highlight.
    PmenuSel = { link = "CursorLine" },
    -- Renders comments in an italic font style.
    Comment = { italic = true },
    -- Styles nvim-cmp's documentation window like 'Normal' text.
    CmpDoc = { link = "Normal" },
    -- Styles the border of nvim-cmp's documentation window to match the 'Normal' text background.
    CmpDocBorder = { bg = "Normal" },
    -- Defines a distinct foreground and background color for LSP inlay hints.
    LspInlayHint = { fg = "#B9C2DE", bg = "#1A1A27" },
    -- Specifically targets Tree-sitter's comment highlight group to render comments in italic.
    ["@comment"] = { italic = true },
    -- Modifies Telescope's matching text highlight, potentially for transparency or to rely on foreground color.
    ["TelescopeMatching"] = { bg = "NONE" },
  },
}

return M
