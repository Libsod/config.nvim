-- This file defines configuration options for obsidian.nvim, a plugin that
-- integrates Neovim with Obsidian note-taking features, including workspaces,
-- linking, daily notes, and templates.

-- Local shortcut for vim.keymap.set for brevity in the mappings section.
local map = vim.keymap.set

-- Main configuration table for obsidian.nvim.
local options = {
  -- Defines a list of Obsidian workspaces (vaults) that the plugin can manage.
  workspaces = {
    {
      name = "notes", -- A user-defined name for this workspace.
      path = "~/notes", -- The file system path to the root of this Obsidian vault.
    },
  },

  -- A function that determines how wiki-style links are formatted.
  -- `opts` table contains `id` (target note ID/filename without extension) and `label` (display text).
  wiki_link_func = function(opts)
    if opts.id == nil then
      -- If no specific ID, create a link with just the label (e.g., for new notes).
      return string.format("[[%s]]", opts.label)
    elseif opts.label ~= opts.id then
      -- If label and ID differ, create a piped link: [[id|label]].
      return string.format("[[%s|%s]]", opts.id, opts.label)
    else
      -- If label and ID are the same, create a simple link: [[id]].
      return string.format("[[%s]]", opts.id)
    end
  end,

  -- If true, disables the automatic handling or generation of YAML frontmatter in notes.
  disable_frontmatter = true,

  -- A function that generates a unique ID for new notes.
  -- This function is used to create filenames for new notes.
  note_id_func = function(title)
    -- Creates note IDs in a Zettelkasten-like format: YYYYMMDDHHMM-kebab-case-title.
    local suffix = ""
    if title ~= nil and title ~= "" then
      -- If a title is provided, convert it to kebab-case for the filename suffix.
      -- Replaces spaces with hyphens, removes non-alphanumeric characters (except hyphens), and converts to lowercase.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If no title is given, generate a random 4-character suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90)) -- Random uppercase A-Z
      end
    end
    return os.date "%Y%m%d%H%M" .. "-" .. suffix
  end,

  -- Configuration for daily notes.
  daily_notes = {
    -- The subfolder within the vault where daily notes are stored.
    folder = "dailies",
    -- The date format used for filenames of daily notes (e.g., "2023-10-27.md").
    date_format = "%Y-%m-%d",
    -- The format for aliases automatically added to daily notes (e.g., "October 27, 2023").
    alias_format = "%B %-d, %Y",
    -- Path to a template file to use for new daily notes. Nil means no template.
    template = nil,
  },

  -- A default sub-directory within the vault where new notes (not daily notes) are created.
  -- An empty string means new notes are created in the vault root or current directory based on `new_notes_location`.
  notes_subdir = "",
  -- Determines where new notes are created: "current_dir" (relative to the current open note)
  -- or "vault_root".
  new_notes_location = "current_dir",

  -- Configuration for note templates.
  templates = {
    -- The subfolder within the vault where note templates are stored.
    folder = "templates",
    -- Date format used for template variable substitution (e.g., {{date}}).
    date_format = "%Y-%m-%d",
    -- Time format used for template variable substitution (e.g., {{time}}).
    time_format = "%H:%M",
    -- A map for custom template variable substitutions.
    -- Keys are variable names (e.g., "{{my_var}}"), values are functions that return the substitution string.
    substitutions = {},
  },

  -- Configures the picker UI used for features like quick switching or searching notes.
  picker = {
    -- Specifies "telescope.nvim" as the picker. Other options might include "fzf-lua".
    name = "telescope.nvim",
    -- Custom mappings within the Telescope picker when used by Obsidian.nvim.
    mappings = {
      -- In the picker, <C-s> will create a new note based on the current query.
      new = "<C-s>",
      -- In the picker, <C-l> will insert a link to the selected note into the original buffer.
      insert_link = "<C-l>",
    },
  },

  -- Defines custom keymappings for Obsidian.nvim commands.
  mappings = {
    -- Remap Oil's default <leader>o if it conflicts, specifically for Obsidian files.
    -- The empty RHS for <leader>o effectively unmaps it or makes it a prefix if other <leader>oX maps exist.
    map("n", "<leader>o", "", { desc = "obsidian: prefix (see <leader>oo, <leader>op etc)" }),
    map(
      "n",
      "<leader>oo",
      ":Oil --float<cr>",
      { silent = true, remap = true, desc = "oil: float window (Obsidian context)" }
    ),
    map("n", "<leader>op", ":ObsidianOpen<cr>", { silent = true, desc = "obsidian: open in app" }),
    map("n", "<leader>on", ":ObsidianNew<cr>", { silent = true, desc = "obsidian: create new note" }),
    map("n", "<leader>oq", ":ObsidianQuickSwitch<cr>", { silent = true, desc = "obsidian: quick switch note" }),
    map("n", "<leader>of", ":ObsidianFollowLink<cr>", { silent = true, desc = "obsidian: follow link" }),
    map("n", "<leader>ob", ":ObsidianBacklinks<cr>", { silent = true, desc = "obsidian: show backlinks" }),
    map("n", "<leader>otg", ":ObsidianTags<cr>", { silent = true, desc = "obsidian: find by tags" }),
    map("n", "<leader>otd", ":ObsidianToday<cr>", { silent = true, desc = "obsidian: open/new daily note (today)" }),
    map(
      "n",
      "<leader>oy",
      ":ObsidianYesterday<cr>",
      { silent = true, desc = "obsidian: open/new daily note (yesterday)" }
    ),
    map(
      "n",
      "<leader>otm",
      ":ObsidianTomorrow<cr>",
      { silent = true, desc = "obsidian: open/new daily note (tomorrow)" }
    ),
    map("n", "<leader>od", ":ObsidianDailies<cr>", { silent = true, desc = "obsidian: list daily notes" }),
    map("n", "<leader>ott", ":ObsidianTemplate<cr>", { silent = true, desc = "obsidian: insert template" }),
    map("n", "<leader>os", ":ObsidianSearch<cr>", { silent = true, desc = "obsidian: search notes" }),
    map("v", "<leader>oll", ":ObsidianLink<cr>", { silent = true, desc = "obsidian: link selected text" }),
    map("v", "<leader>oln", ":ObsidianLinkNew<cr>", { silent = true, desc = "obsidian: link selection to new note" }),
    map("n", "<leader>ola", ":ObsidianLinks<cr>", { silent = true, desc = "obsidian: list links in buffer" }),
    map(
      "v",
      "<leader>oe",
      ":ObsidianExtractNote<cr>",
      { silent = true, desc = "obsidian: extract selection to new note" }
    ),
    map("n", "<leader>ow", ":ObsidianWorkspace<cr>", { silent = true, desc = "obsidian: switch workspace" }),
    map("n", "<leader>oi", ":ObsidianPasteImg ", { silent = true, desc = "obsidian: paste image" }), -- Note: Space at end for path input.
    map("n", "<leader>or", ":ObsidianRename<cr>", { silent = true, desc = "obsidian: rename note/reference" }),
    map("n", "<leader>otc", ":ObsidianToggleCheckbox<cr>", { silent = true, desc = "obsidian: toggle checkbox" }),
  },
}

return options
