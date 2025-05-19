-- This file defines configuration options for crates.nvim,
-- a plugin that helps manage Rust crate (dependency) versions in Cargo.toml files.

-- Defines a table of icons used throughout the crates.nvim UI for visual cues.
local icons = {
  diagnostics = {
    Error = " ", -- General error icon.
    Error_alt = "󰅚 ", -- Alternative error icon.
    Warning_alt = "󰀪 ", -- Alternative warning icon.
    Information_alt = " ", -- Alternative information icon.
    Question = " ", -- Question mark icon.
    Question_alt = " ", -- Alternative question mark icon.
    Hint_alt = "󰌶", -- Alternative hint icon.
  },
  git = {
    Repo = " ", -- Repository icon.
  },
  misc = {
    Campass = "󰀹 ", -- Compass icon (e.g., for homepage).
    Gavel = " ", -- Gavel icon (e.g., for build dependencies).
    Glass = "󰂖 ", -- Glass/martini icon (e.g., for dev dependencies).
    Watch = " ", -- Watch icon (e.g., for loading states).
    Added = " ", -- Plus/added icon.
    ManUp = " ", -- Person/updated icon.
  },
  ui = {
    BigUnfilledCircle = " ", -- Large unfilled circle (e.g., for optional dependencies).
    Check = "󰄳 ", -- Checkmark icon.
    CloudDownload = " ", -- Cloud download icon.
    List = " ", -- List/cut icon (e.g., for transitive dependencies).
    Package = " ", -- Package/box icon.
    Play = " ", -- Play icon (e.g., for enabled features).
  },
  kind = {
    Class = "󰠱 ", -- Class/category icon.
    Interface = " ", -- Interface/dependency icon.
    Keyword = "󰌋 ", -- Keyword/tag icon.
  },
}

-- Main configuration table for crates.nvim.
local options = {
  -- Enables "smart" insertion of crate declarations, potentially formatting them nicely.
  smart_insert = true,
  -- Automatically inserts the closing quote when typing crate versions or features.
  insert_closing_quote = true,
  -- Automatically loads crate data when a Cargo.toml file is opened.
  autoload = true,
  -- Automatically checks for updates to crate data when a Cargo.toml file is modified.
  autoupdate = true,
  -- Throttles the frequency of autoupdate checks to avoid excessive requests (in milliseconds).
  autoupdate_throttle = 250,
  -- Shows a loading indicator when fetching crate data.
  loading_indicator = true,
  -- Format for displaying dates (e.g., crate version release dates).
  date_format = "%Y-%m-%d",
  -- Character used as a thousands separator for download counts.
  thousands_separator = ",",
  -- Title used for notifications sent by crates.nvim.
  notification_title = "Crates",
  -- Additional arguments to pass to the curl command when fetching crate data.
  -- '-sL' for silent and follow redirects, '--retry 1' for one retry attempt.
  curl_args = { "-sL", "--retry", "1" },
  -- Text labels and prefixes used in various parts of the UI (e.g., version display).
  text = {
    loading = " " .. icons.misc.Watch .. "Loading", -- Text shown while loading.
    version = " " .. icons.ui.Check .. "%s", -- Prefix for stable versions.
    prerelease = " " .. icons.diagnostics.Warning_alt .. "%s", -- Prefix for pre-release versions.
    yanked = " " .. icons.diagnostics.Error .. "%s", -- Prefix for yanked (removed) versions.
    nomatch = " " .. icons.diagnostics.Question .. "No match", -- Text for no matching crate.
    upgrade = " " .. icons.diagnostics.Hint_alt .. "%s", -- Prefix for available upgrades.
    error = " " .. icons.diagnostics.Error .. "Error fetching crate", -- Text for fetch errors.
  },
  -- Configuration for the popup window that displays crate details.
  popup = {
    -- If true, the popup window will automatically gain focus when opened.
    autofocus = false,
    -- If true, the popup window will automatically close after an action (e.g., selecting a version).
    hide_on_select = true,
    -- Specifies the register used for copying information from the popup.
    copy_register = '"', -- Uses the default unnamed register.
    -- Visual style of the popup window.
    style = "minimal",
    -- Border style for the popup window.
    border = "single",
    -- If true, shows the release date next to crate versions in the popup.
    show_version_date = true,
    -- If true, shows the version of dependencies listed in the popup.
    show_dependency_version = true,
    -- Maximum height of the popup window in lines.
    max_height = 30,
    -- Minimum width of the popup window in columns.
    min_width = 20,
    -- Padding (in cells) inside the popup window border.
    padding = 1,
    -- Text labels and formats used within the crate details popup.
    text = {
      title = icons.ui.Package .. "%s",
      description = "%s",
      created_label = icons.misc.Added .. "created" .. "        ",
      created = "%s",
      updated_label = icons.misc.ManUp .. "updated" .. "        ",
      updated = "%s",
      downloads_label = icons.ui.CloudDownload .. "downloads      ",
      downloads = "%s",
      homepage_label = icons.misc.Campass .. "homepage       ",
      homepage = "%s",
      repository_label = icons.git.Repo .. "repository     ",
      repository = "%s",
      documentation_label = icons.diagnostics.Information_alt .. "documentation  ",
      documentation = "%s",
      crates_io_label = icons.ui.Package .. "crates.io      ",
      crates_io = "%s",
      categories_label = icons.kind.Class .. "categories     ",
      keywords_label = icons.kind.Keyword .. "keywords       ",
      version = "  %s", -- Format for displaying a version.
      prerelease = icons.diagnostics.Warning_alt .. "%s prerelease", -- Format for pre-release versions.
      yanked = icons.diagnostics.Error .. "%s yanked", -- Format for yanked versions.
      version_date = "  %s", -- Format for version dates.
      feature = "  %s", -- Format for displaying a feature.
      enabled = icons.ui.Play .. "%s", -- Prefix for enabled features.
      transitive = icons.ui.List .. "%s", -- Prefix for transitive dependencies.
      normal_dependencies_title = icons.kind.Interface .. "Dependencies", -- Title for normal dependencies.
      build_dependencies_title = icons.misc.Gavel .. "Build dependencies", -- Title for build dependencies.
      dev_dependencies_title = icons.misc.Glass .. "Dev dependencies", -- Title for dev dependencies.
      dependency = "  %s", -- Format for displaying a dependency.
      optional = icons.ui.BigUnfilledCircle .. "%s", -- Prefix for optional dependencies.
      dependency_version = "  %s", -- Format for dependency versions.
      loading = " " .. icons.misc.Watch, -- Text/icon for loading state within the popup.
    },
  },
  -- Configuration related to completion features provided by crates.nvim.
  completion = {
    -- Automatically inserts the closing quote when completing versions or features.
    insert_closing_quote = true,
    -- Text labels for completion items.
    text = {
      prerelease = " " .. icons.diagnostics.Warning_alt .. "pre-release ", -- Label for pre-release versions in completion.
      yanked = " " .. icons.diagnostics.Error_alt .. "yanked ", -- Label for yanked versions in completion.
    },
  },
}

return options
