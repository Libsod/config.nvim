local options = {
  filetypes = {
    "html",
    "astro",
    "svelte",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "xml",
  },
}

return require("nvim-ts-autotag").setup(options)
