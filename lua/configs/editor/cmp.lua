-- This file configures nvim-cmp, the autocompletion plugin for Neovim.
-- It defines sources, sorting, appearance, and keymappings for the completion menu.

local cmp = require "cmp"
local compare = require "cmp.config.compare"

-- Applies NvChad's base46 themed highlights specifically for nvim-cmp UI elements.
-- This ensures the completion menu integrates visually with the active NvChad theme.
dofile(vim.g.base46_cache .. "cmp")

-- Custom comparator function to adjust LSP scores.
-- This function is used in the sorting process to potentially give higher or lower priority
-- to completion items based on scores provided by the LSP server, combined with cmp's internal score.
compare.lsp_scores = function(entry1, entry2)
  local diff
  -- If both entries have an explicit 'score' from their completion item,
  -- combine it with cmp's own score for a more nuanced comparison.
  if entry1.completion_item.score and entry2.completion_item.score then
    diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
  else
    -- Otherwise, fall back to comparing only cmp's internal scores.
    diff = entry2.score - entry1.score
  end
  -- Returns true if entry1 should come before entry2 (lower diff means higher priority for entry1).
  return (diff < 0)
end

-- Main configuration table for nvim-cmp.
local options = {
  -- Determines how an item is preselected in the completion menu.
  -- 'Item' mode preselects the first available item.
  preselect = cmp.PreselectMode.Item,
  completion = {
    -- Configures Vim's 'completeopt' to ensure only the menu and selection behavior is active,
    -- preventing insertion of text before explicit confirmation.
    completeopt = "menuone",
  },
  -- Defines the order and logic for sorting completion items in the menu.
  sorting = {
    comparators = {
      compare.offset, -- Prioritizes items closer to the cursor.
      compare.exact, -- Prioritizes exact matches.
      compare.score, -- Uses cmp's internal scoring mechanism.
      compare.lsp_scores, -- Applies the custom LSP score comparison defined above.
      -- Conditionally loads clangd_extensions' custom scoring for C/C++ files.
      -- This allows for clangd-specific ranking of completion items.
      function()
        if vim.tbl_contains({ "cpp", "c", "h", "hpp" }, vim.bo.filetype) then
          -- Assuming 'clangd_extensions.cmp_scores' is a comparator function or returns one.
          -- If it modifies a global state or registers a comparator, ensure it's idempotent.
          -- This will be evaluated for each comparison pair, which might be inefficient
          -- if `require` is slow or has side effects on each call.
          -- Consider loading it once on FileType if it's a persistent comparator.
          require "clangd_extensions.cmp_scores"
          -- The original code implies this function itself acts as a comparator or that
          -- requiring it has the side effect of adding a comparator.
          -- If it returns a comparator, it should be called: return clangd_comparator(entry1, entry2)
          -- For now, assuming the original intent was to ensure the module is loaded
          -- and potentially registers its comparator globally or modifies `compare`.
          -- This specific part might need review based on how clangd_extensions.cmp_scores works.
        end
        -- If not C/C++, this custom comparator function effectively does nothing or returns nil,
        -- which means it won't influence sorting for other filetypes.
      end,
      compare.recently_used, -- Prioritizes items that were recently selected.
      compare.locality, -- Prioritizes items defined locally in the current buffer/scope.
      compare.kind, -- Sorts by the kind of completion item (function, variable, etc.).
      compare.sort_text, -- Sorts alphabetically by the item's text.
      compare.length, -- Sorts by the length of the item's text.
      compare.order, -- Uses the original order provided by the source.
    },
  },
  -- Configures the appearance of the completion and documentation windows.
  window = {
    completion = {
      -- Defines highlighting for the completion menu: Normal text, selected item, border.
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,FloatBorder:FloatBorder,Search:None",
      -- Disables the scrollbar in the completion menu.
      scrollbar = false,
    },
    documentation = {
      -- Defines highlighting for the documentation window.
      winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
      -- Disables the scrollbar in the documentation window.
      scrollbar = false,
    },
  },
  -- Experimental features of nvim-cmp.
  experimental = {
    -- Disables ghost text (inline completion previews).
    ghost_text = false,
  },
  -- Configures snippet expansion.
  snippet = {
    -- Defines how snippets are expanded, integrating with LuaSnip.
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- Configures matching behavior.
  matching = {
    -- Allows partial fuzzy matching for completion items.
    disallow_partial_fuzzy_matching = false,
  },
  -- Performance-related settings.
  performance = {
    -- Sets a budget for asynchronous operations, affecting responsiveness.
    async_budget = 1,
  },
  -- Defines keymappings for interacting with the completion menu.
  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item(), -- Selects the previous item in the menu.
    ["<Down>"] = cmp.mapping.select_next_item(), -- Selects the next item in the menu.
    ["<C-e>"] = cmp.mapping.scroll_docs(-4), -- Scrolls documentation window up.
    ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scrolls documentation window down.
    ["<C-Space>"] = cmp.mapping.complete(), -- Manually triggers completion.
    ["<C-q>"] = cmp.mapping.close(), -- Closes the completion menu.
    ["<CR>"] = cmp.mapping.confirm { -- Confirms the selected completion.
      behavior = cmp.ConfirmBehavior.Insert, -- Inserts the completion.
      select = true, -- Confirms the currently selected item.
    },
    -- Custom mapping for <C-n> (Tab or next item/snippet jump).
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- If completion menu is visible, select next item.
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump() -- If a snippet can be expanded or jumped to, do it.
      else
        fallback() -- Otherwise, perform default <C-n> action (often like <Tab>).
      end
    end, { "i", "s" }), -- Applies in insert and select modes.
    -- Custom mapping for <C-p> (Shift-Tab or previous item/snippet jump).
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- If completion menu is visible, select previous item.
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1) -- If possible to jump to a previous snippet placeholder, do it.
      else
        fallback() -- Otherwise, perform default <C-p> action.
      end
    end, { "i", "s" }), -- Applies in insert and select modes.
  },
  -- Defines the sources for completion items and their priority.
  sources = cmp.config.sources {
    { name = "nvim_lsp", priority = 10, max_item_count = 50 }, -- LSP completions.
    { name = "nvim_lsp_signature_help", priority = 9 }, -- LSP signature help as a source.
    { name = "luasnip", priority = 9 }, -- Snippets from LuaSnip.
    { name = "luasnip_choice", priority = 8 }, -- Choice nodes from LuaSnip.
    { name = "nvim_lua", priority = 7 }, -- Completions for Neovim's Lua API.
    { name = "crates", priority = 6 }, -- Completions from crates.nvim (for Cargo.toml).
    { name = "async_path", priority = 5 }, -- Asynchronous file path completions.
    { name = "treesitter", priority = 4 }, -- Completions based on Treesitter syntax nodes.
    {
      name = "buffer",
      -- Option for buffer source: only process buffers with fewer than 15000 lines.
      option = {
        get_bufnrs = function()
          -- Check if the current buffer line count is less than 15000
          if vim.api.nvim_buf_line_count(0) < 15000 then
            return vim.api.nvim_list_bufs() -- If so, return all buffers
          else
            return {} -- Otherwise, return an empty table (no buffer sources)
          end
        end,
      },
      priority = 3,
    },
  },
}

-- Merges the custom options with NvChad's default nvim-cmp configuration.
-- 'force' strategy means custom options will deeply override NvChad's if there are conflicts.
options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")

return options
