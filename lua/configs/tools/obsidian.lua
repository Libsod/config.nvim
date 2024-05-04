local map = vim.keymap.set

local options = {
  workspaces = {
    {
      name = "notes",
      path = "~/notes",
    },
  },

  wiki_link_func = function(opts)
    if opts.id == nil then
      return string.format("[[%s]]", opts.label)
    elseif opts.label ~= opts.id then
      return string.format("[[%s|%s]]", opts.id, opts.label)
    else
      return string.format("[[%s]]", opts.id)
    end
  end,

  disable_frontmatter = true,

  note_frontmatter_func = function(note)
    -- This is equivalent to the default frontmatter function.
    local out = { id = note.id, aliases = note.aliases, tags = note.tags }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,

  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,

  daily_notes = {
    folder = "dailies",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    template = nil,
  },

  notes_subdir = "",
  new_notes_location = "current_dir",

  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },

  picker = {
    name = "telescope.nvim",
    mappings = {
      -- Create a new note from your query.
      new = "<C-s>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
  },

  mappings = {
    -- Oil remap (only for obsidian files)
    map("n", "<leader>o", ""),
    map("n", "<leader>oo", ":Oil --float<CR>", { silent = true, remap = true }),
    map("n", "<leader>op", ":ObsidianOpen<CR>", { silent = true, desc = "Obsidian open in app" }),
    map("n", "<leader>on", ":ObsidianNew ", { silent = true, desc = "Create a new note" }),

    map(
      "n",
      "<leader>oq",
      ":ObsidianQuickSwitch<CR>",
      { silent = true, desc = "Quickly switch to another note in vault" }
    ),

    map(
      "n",
      "<leader>of",
      ":ObsidianFollowLink<CR>",
      { silent = true, desc = "Follow a note reference under the cursor," }
    ),

    map(
      "n",
      "<leader>ob",
      ":ObsidianBacklinks<CR>",
      { silent = true, desc = "Open up a picker list of references to the current buffer" }
    ),

    map(
      "n",
      "<leader>otg",
      ":ObsidianTags<CR>",
      { silent = true, desc = "Open up a picker list of all occurrences of the given tags" }
    ),

    map("n", "<leader>otd", ":ObsidianToday<CR>", { silent = true, desc = "Open/create a new daily note" }),

    map(
      "n",
      "<leader>oy",
      ":ObsidianYesterday<CR>",
      { silent = true, desc = "Open/create the daily note for yesterday" }
    ),

    map(
      "n",
      "<leader>otm",
      ":ObsidianTomorrow<CR>",
      { silent = true, desc = "Open/create the daily note for tomorrow" }
    ),

    map("n", "<leader>od", ":ObsidianDailies ", { silent = true, desc = "Open up a picker list of daily notes" }),

    map(
      "n",
      "<leader>ott",
      ":ObsidianTemplate<CR>",
      { silent = true, desc = "Insert a template from the templates folder" }
    ),

    map(
      "n",
      "<leader>os",
      ":ObsidianSearch<CR>",
      { silent = true, desc = "Search for (or create) notes in vault using rg" }
    ),

    map(
      "n",
      "<leader>oll",
      ":ObsidianLink ",
      { silent = true, desc = "Link an inline visual selection of text to a note" }
    ),

    map("n", "<leader>oln", ":ObsidianLinkNew ", {
      silent = true,
      desc = "Create a new note and link it to an inline visual selection of text",
    }),

    map("n", "<leader>ola", ":ObsidianLinks<CR>", {
      silent = true,
      desc = "Collect all links within the current buffer into a picker window",
    }),

    map("n", "<leader>oe", ":ObsidianExtractNote ", {
      silent = true,
      desc = "Extract the visually selected text into a new note and link to it",
    }),

    map("n", "<leader>ow", ":ObsidianWorkspace ", {
      silent = true,
      desc = "Switch to another workspace",
    }),

    map("n", "<leader>oi", ":ObsidianPasteImg ", {
      silent = true,
      desc = "Paste an image from the clipboard into the note at the cursor position",
    }),

    map("n", "<leader>or", ":ObsidianRename ", {
      silent = true,
      desc = "Rename the note of the current buffer or reference under the cursor",
    }),

    map("n", "<leader>otc", ":ObsidianToggleCheckbox<CR>", {
      silent = true,
      desc = "Toggle checkbox options",
    }),
  },
}

return require("obsidian").setup(options)
