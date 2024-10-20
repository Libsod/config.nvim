local cmp = require "cmp"

dofile(vim.g.base46_cache .. "cmp")

local compare = require "cmp.config.compare"
compare.lsp_scores = function(entry1, entry2)
  local diff
  if entry1.completion_item.score and entry2.completion_item.score then
    diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
  else
    diff = entry2.score - entry1.score
  end
  return (diff < 0)
end

-- local formatting_style = {
--   fields = { "abbr", "kind" },
--
--   format = function(_, item)
--     local icons = require "nvchad.icons.lspkind"
--     local icon = icons[item.kind]
--
--     icon = "" .. icon .. "  "
--     item.kind = (icon .. item.kind) or ""
--     item.menu = ""
--
--     return item
--   end,
-- }

local options = {

  preselect = cmp.PreselectMode.Item,

  completion = {
    completeopt = "menuone",
  },

  sorting = {
    priority_weight = 2,
    comparators = {
      compare.offset, -- Items closer to cursor will have lower priority
      compare.exact,
      compare.lsp_scores,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      function()
        local filetype = vim.bo.filetype
        if vim.tbl_contains({ "python" }, filetype) then
          require "cmp-under-comparator.under"
        end
      end,
      function()
        local filetype = vim.bo.filetype
        if vim.tbl_contains({ "cpp", "c", "h", "hpp" }, filetype) then
          require "clangd_extensions.cmp_scores"
        end
      end,
      compare.sort_text,
      compare.kind,
      compare.length,
      compare.order,
    },
  },

  window = {
    completion = {
      -- border = "rounded",
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,FloatBorder:FloatBorder,Search:None",
      scrollbar = false,
      col_offset = -3,
      side_padding = 1,
      behavior = {
        insert = "always",
      },
    },
    documentation = {
      -- border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
      scrollbar = false,
    },
  },

  experimental = {
    ghost_text = false,
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  -- formatting = formatting_style,

  matching = {
    disallow_partial_fuzzy_matching = false,
  },

  performance = {
    async_budget = 1,
  },

  mapping = {
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-q>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<C-n>"] = cmp.mapping(function(fallback)
      require("luasnip").expand_or_jumpable()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    end, {
      "i",
      "s",
    }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      require("luasnip").jumpable(-1)
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    end, {
      "i",
      "s",
    }),
  },

  sources = {
    { name = "nvim_lsp", max_item_count = 100 },
    { name = "luasnip" },
    { name = "luasnip_choice" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
    { name = "crates" },
    { name = "treesitter" },
    -- { name = "orgmode" },
    { name = "nvim_lsp_signature_help" },
    -- { name = "latex_symbols" },
  },
}

options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")

return options
