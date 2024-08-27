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
    cpp = { "clang-format" },
    c = { "clang-format" },
    rust = { "rustfmt" },
    yaml = { "prettier" },
    json = { "prettier" },
    nix = { "nixpkgs_fmt" },
    go = { "gofumpt", "goimports-reviser" },
    gomod = { "gofumpt", "goimports-reviser" },
    gowork = { "gofumpt", "goimports-reviser" },
    gotmpl = { "gofumpt", "goimports-reviser" },
  },

  formatters = {
    -- C/C++
    ["clang-format"] = {
      prepend_args = {
        "-style={ \
        IndentWidth: 2, \
        TabWidth: 2, \
        UseTab: Never, \
        AccessModifierOffset: 0, \
        IndentAccessModifiers: true, \
        PackConstructorInitializers: Never}",
      },
    },

    -- Golang
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused" },
    },
  },
}

conform.setup(options)
