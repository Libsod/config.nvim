-- This file defines a list of Tree-sitter parsers that nvim-treesitter
-- should ensure are installed and kept up-to-date.
-- Tree-sitter parsers provide enhanced syntax highlighting, code analysis,
-- and structural understanding for various programming languages.

local ensure_installed = {
  -- Shell scripting languages
  "bash",
  "fish",

  -- Low-level programming languages
  "c",
  "cpp",
  "zig",
  "odin",
  "rust",
  "nasm", -- Netwide Assembler

  -- Web development languages and formats
  "html",
  "css",
  "scss", -- Sassy CSS (CSS preprocessor)
  "javascript",
  "typescript",
  "tsx", -- TypeScript XML (JSX for TypeScript)
  "astro", -- Astro framework files

  -- Python programming language
  "python",

  -- Lua programming language and documentation format
  "lua",
  "luadoc",

  -- Golang (Go) programming language and related file formats
  "go",
  "gomod", -- Go modules file
  "gosum", -- Go checksum file
  "gowork", -- Go workspace file

  -- Markdown and its inline elements
  "markdown",
  "markdown_inline",

  -- LaTeX document preparation system
  "latex",

  -- Markup and data serialization languages
  "xml",
  "json",
  "yaml",
  "toml",

  -- Vim script and documentation
  "vim",
  "vimdoc",

  -- Nix package manager and language
  "nix",

  -- Nim programming language
  "nim",

  -- Gleam programming language
  "gleam",

  -- Norg, a plain-text file format for note-taking and organization
  "norg",

  -- C# programming language
  "c_sharp",

  -- Dockerfile syntax
  "dockerfile",

  -- SQL (Structured Query Language)
  "sql",

  -- Build system languages
  "make", -- Makefile syntax
  "cmake", -- CMake build system files

  -- Git related file formats
  "git_config", -- Git configuration files
  "git_rebase", -- Git rebase interactive sequence files
  "gitattributes", -- Git attributes files
  "gitcommit", -- Git commit message syntax
  "gitignore", -- Git ignore files
  "diff", -- Diff/patch file format

  -- Miscellaneous or query-specific languages
  "query", -- Tree-sitter's own query language
  "regex", -- Regular expression syntax
}

-- Returns the list of parsers to be ensure installed by nvim-treesitter.
return ensure_installed
