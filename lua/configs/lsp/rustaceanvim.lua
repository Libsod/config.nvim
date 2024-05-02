local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").rust_analyzer_on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

vim.g.rustaceanvim = {
  tools = {
    hover_actions = {
      replace_builtin_hover = false,
    },
  },

  server = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    default_settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
          extraArgs = { "--profile", "rust-analyzer" },
          features = "all",
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
        assist = {
          expressionFillDefault = "default",
        },
        inlayHints = {
          typeHints = { enable = true },
          bindingModeHints = { enable = true },
          closingBraceHints = {
            minLines = 11,
          },
          closureCaptureHints = { enable = true },
          closureReturnTypeHints = {
            enable = "with_block",
          },
          closureStyle = "rust_analyzer",
          discriminantHints = {
            enable = "fieldless",
          },
          parameterHints = {
            enable = true,
          },
          rangeExclusiveHints = {
            enable = true,
          },
          renderColons = false,
          expressionAdjustmentHints = {
            mode = "prefer_postfix",
            enable = "reborrow",
          },
          lifetimeElisionHints = {
            enable = "skip_trivial",
          },
        },
        lens = {
          run = { enable = false },
        },
        completion = {
          fullFunctionSignatures = { enable = true },
        },
        procMacro = { enable = true },
        typing = {
          autoClosingAngleBrackets = { enable = true },
        },
        semanticHighlighting = {
          operator = {
            specialization = { enable = true },
          },
          punctuation = {
            separate = {
              macro = {
                bang = true,
              },
            },
            enable = true,
          },
        },
        workspace = {
          symbol = {
            search = {
              kind = "all_symbols",
            },
          },
        },
        signatureInfo = {
          documentation = {
            enable = false,
          },
        },
      },
    },
  },
}
