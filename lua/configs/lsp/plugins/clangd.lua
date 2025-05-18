-- This file defines specific configuration options for the clangd_extensions.nvim plugin,
-- which enhances the capabilities of the clangd LSP server for C/C++ development.

-- Defines a custom border style using box-drawing characters.
-- This border style can be reused for various UI elements within the plugin.
local border = {
  "╭", -- top-left
  "─", -- top
  "╮", -- top-right
  "│", -- right
  "╯", -- bottom-right
  "─", -- bottom
  "╰", -- bottom-left
  "│", -- left
}

-- Main configuration table for clangd_extensions.nvim.
local options = {
  -- Configuration for the Abstract Syntax Tree (AST) viewer feature.
  ast = {
    -- Defines icons used to represent different roles of AST nodes.
    role_icons = {
      type = "", -- Icon for type nodes.
      declaration = "", -- Icon for declaration nodes.
      expression = "", -- Icon for expression nodes.
      specifier = "", -- Icon for specifier nodes (e.g., static, const).
      statement = "", -- Icon for statement nodes.
      ["template argument"] = "", -- Icon for template argument nodes.
    },

    -- Defines icons used to represent different kinds of AST nodes.
    -- These often correspond to specific Clang AST node types.
    kind_icons = {
      Compound = "", -- Icon for compound statements or similar constructs.
      Recovery = "", -- Icon for recovery expressions (error handling in AST).
      TranslationUnit = "", -- Icon for the root of the AST (translation unit).
      PackExpansion = "", -- Icon for pack expansions (variadic templates).
      TemplateTypeParm = "", -- Icon for template type parameters.
      TemplateTemplateParm = "", -- Icon for template template parameters.
      TemplateParamObject = "", -- Icon for template parameter objects.
    },

    -- Configuration for highlighting within the AST viewer.
    highlights = {
      -- Specifies the highlight group to be used for detailed information or selected elements.
      -- Links to "PmenuSel", which is typically the highlight for selected items in a popup menu.
      detail = "PmenuSel",
    },
  },

  -- Configuration for the memory usage display feature.
  memory_usage = {
    -- Applies the custom defined border style to the memory usage window.
    border = border,
  },

  -- Configuration for the symbol information display feature.
  symbol_info = {
    -- Applies the custom defined border style to the symbol information window.
    border = border,
  },
}

return options
