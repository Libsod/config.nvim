---@type ChadrcConfig
local M = {}

M.lsp = {
  signature = false,
}

M.ui = {
  theme = "catppuccin",

  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd" },
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
    LspInlayHint = { fg = "#B9C2DE", bg = "#1A1A27" },
    ["@comment"] = { italic = true },
    ["TelescopeMatching"] = { bg = "NONE" },
  },
}

return M
