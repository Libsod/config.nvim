local ftdetect = {
  name = "ftdetect",
  opts = { defer = true },
  disable = function()
    vim.api.nvim_set_option_value("filetype", "big_file_disabled_ft", { scope = "local" })
  end,
}

local cmp = {
  name = "nvim-cmp",
  opts = { defer = true },
  disable = function()
    require("cmp").setup.buffer { enabled = false }
  end,
}

local options = {
  filesize = 1,      -- size of the file in MiB
  pattern = { "*" }, -- autocmd pattern
  features = {       -- features to disable
    "indent_blankline",
    "lsp",
    "treesitter",
    "syntax",
    "vimopts",
    ftdetect,
    cmp,
  },
}

return require("bigfile").setup(options)
