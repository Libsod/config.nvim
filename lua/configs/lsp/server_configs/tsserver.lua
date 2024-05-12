local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").tsserver_on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

-- Remap todo-comments
local map = vim.keymap.set
map("n", "<leader>t", "")
map("n", "<leader>tt", ":TodoTrouble<CR>", { silent = true, noremap = true })

-- TS commands
map(
  "n",
  "<leader>to",
  ":TSToolsOrganizeImports<CR>",
  { silent = true, noremap = true, desc = "Sort and remove unused imports" }
)
map("n", "<leader>ts", ":TSToolsSortImports<CR>", { silent = true, noremap = true, desc = "Sort imports" })
map(
  "n",
  "<leader>tri",
  ":TSToolsRemoveUnusedImports<CR>",
  { silent = true, noremap = true, desc = "Remove unused imports" }
)
map(
  "n",
  "<leader>tru",
  ":TSToolsRemoveUnused<CR>",
  { silent = true, noremap = true, desc = "Remove all unused statements" }
)
map(
  "n",
  "<leader>ta",
  ":TSToolsAddMissingImports<CR>",
  { silent = true, noremap = true, desc = "Add imports for all statements that lack one and can be imported" }
)
map("n", "<leader>tff", ":TSToolsFixAll<CR>", { silent = true, noremap = true, desc = "Fix all fixable errors" })
map(
  "n",
  "<leader>tg",
  ":TSToolsGoToSourceDefinition<CR>",
  { silent = true, noremap = true, desc = "Go to source definition" }
)
map(
  "n",
  "<leader>tfc",
  ":TSToolsRenameFile<CR>",
  { silent = true, noremap = true, desc = "Allow to rename current file and apply changes to connected files" }
)
map(
  "n",
  "<leader>tfr",
  ":TSToolsFileReferences<CR>",
  { silent = true, noremap = true, desc = "Find files that reference the current file" }
)

local options = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    expose_as_code_action = "all",

    complete_function_calls = true,

    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
    },

    tsserver_plugins = {
      "@styled/typescript-styled-plugin",
    },
  },
}

return require("typescript-tools").setup(options)
