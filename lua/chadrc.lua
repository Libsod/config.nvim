---@type ChadrcConfig
local M = {}

M.lsp = {
  signature = false,
}

M.ui = {
  theme = "catppuccin",

  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "diagnostics", "git", "%=", "lsp", "cwd" },
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },

  hl_add = {
    NoiceCmdlineIcon = { fg = "pink" },
    NoiceCmdlinePopupBorder = { link = "NoiceCmdlineIcon" },
    NoicePopupmenuMatch = { link = "NoiceCmdlineIcon" },
    NoiceMini = { link = "NoiceCmdlineIcon" },
    NoiceCmdlinePopup = { link = "NoiceCmdlineIcon" },
    NoiceFormatConfirm = { link = "NoiceCmdlineIcon" },
    NoiceCmdlinePopupTitle = { fg = "red" },
    NoiceLspProgressTitle = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdline = { fg = "sun" },
    CurSearch = { fg = "black2", bg = "cyan" },
    LspInlayhint = { link = "@comment" },
    Yank = { fg = "black2", bg = "cyan" },
  },

  hl_override = {
    Error = { fg = "NONE" },
    Search = { fg = "NONE", bg = "one_bg2" },
    Visual = { link = "Search" },
    IncSearch = { link = "CurSearch" },
    NormalFloat = { link = "Normal" },
    WhichKeyFloat = { link = "Normal" },
    Pmenu = { link = "Normal" },
    PmenuSel = { link = "CursorLine" },
    Comment = { italic = true },
    CmpDoc = { link = "Normal" },
    CmpDocBorder = { bg = "blue" },
    ["@comment"] = { italic = true },
    ["TelescopeMatching"] = { bg = "NONE" },
  },
}

return M
