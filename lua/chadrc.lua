---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "mountain",

  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "diagnostics", "git", "%=", "lsp_msg", "%=", "lsp", "cwd" },
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },

  hl_add = {
    NoiceCmdlinePopupBorder = { fg = "#AB8AAC" },
    NoiceCmdlineIcon = { fg = "#AB8AAC" },
    NoicePopupmenuMatch = { fg = "#AB8AAC" },
    NoiceCmdlinePopupTitle = { fg = "#ac8a8c" },
    NoiceCmdlinePopup = { fg = "#AB8AAC" },
    NoiceFormatConfirm = { fg = "#AB8AAC" },
    NoiceCmdline = { fg = "#b1ae8f" },
    NoiceLspProgressTitle = { fg = "#ac8a8c" },
    NoiceMini = { fg = "#AB8AAC" },
    CurSearch = { fg = "#0F0F0F", bg = "#AB8AAC" },
    LspInlayhint = { fg = "#414141" },
  },

  hl_override = {
    Error = { fg = "NONE" },
    Search = { fg = "NONE", bg = "#212121" },
    Visual = { bg = "#212121" },
    IncSearch = { fg = "#0F0F0F", bg = "#AB8AAC" },
    NormalFloat = { bg = "#0F0F0F" },
    WhichKeyFloat = { bg = "#0F0F0F" },
    Pmenu = { bg = "#0F0F0F" },
    PmenuSel = { fg = "NONE", bg = "#181818" },
    Comment = { italic = true },
    CmpDoc = { bg = "#0F0F0F" },
    CmpDocBorder = { bg = "#9691b3" },
    ["@comment"] = { italic = true },
    ["TelescopeMatching"] = { bg = "NONE" },
  },
}

return M
