local conform = require "conform"

local options = {
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },

  formatters_by_ft = {
    asm = { "asmfmt" },
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    astro = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    yaml = { "prettier" },
    json = { "prettier" },
    nix = { "nixpkgs_fmt" },
  },
}

conform.setup(options)
