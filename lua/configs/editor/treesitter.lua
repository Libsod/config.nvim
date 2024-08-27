local options = {
  ensure_installed = {
    -- Shell
    "bash",
    "fish",

    -- Low-level
    "c",
    "cpp",
    "zig",
    "odin",
    "rust",
    "nasm",

    -- Web
    "html",
    "css",
    "scss",
    "javascript",
    "typescript",
    "tsx",
    "astro",

    -- Python
    "python",

    -- Lua
    "lua",
    "luadoc",

    -- Golang
    "go",
    "gomod",
    "gosum",
    "gowork",

    -- Markdown
    "markdown",
    "markdown_inline",

    -- LaTeX
    "latex",

    -- Markup langs
    "xml",
    "json",
    "yaml",
    "toml",

    -- Vim
    "vim",
    "vimdoc",

    -- Nix
    "nix",

    -- Nim
    "nim",

    -- Gleam
    "gleam",

    -- Norg
    "norg",

    -- Docker
    "dockerfile",

    -- Sql
    "sql",

    -- Build system's langs
    "make",
    "cmake",

    -- Git
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "diff",

    -- Misc
    "query",
    "regex",
  },

  highlight = {
    enable = true,
    disable = function(ft, bufnr)
      if vim.tbl_contains({ "vim" }, ft) then
        return true
      end

      local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
      return ok and is_large_file
    end,
    additional_vim_regex_highlighting = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
