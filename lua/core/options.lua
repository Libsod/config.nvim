-- Shorthand local variables for accessing Neovim options and global variables.
local o = vim.o -- Global options
local wo = vim.wo -- Window-local options
local g = vim.g -- Global variables

-- Import and apply NVChad's default options.
-- This line executes the NvChad options file, setting its recommended defaults.
-- Any options set after this line will override or supplement NvChad's defaults.
require "nvchad.options"

-- Window-local options
-- These options are set per window and can have different values in different windows.

-- Purpose: Enables relative line numbers in each window.
-- The current line shows its absolute number, while other lines show their relative distance from the current line.
wo.relativenumber = true

-- Purpose: Controls how concealed text is displayed (e.g., for Markdown syntax, font ligatures).
-- Level 3: Text is fully concealed and replaced by the 'conceal' character (if set) or completely hidden.
wo.conceallevel = 3

-- Purpose: Specifies what part of the cursor line is highlighted when 'cursorline' is active.
-- "both": Highlights both the screen line number and the text line itself.
wo.cursorlineopt = "both"

-- Global options
-- These options apply globally to the Neovim instance.

-- Purpose: Configures the cursor shape in different modes for GUI versions of Vim/Neovim.
-- Setting it to an empty string typically means Neovim will use a block cursor in all modes,
-- or it might defer to terminal-controlled cursor shapes if not in a GUI.
o.guicursor = ""

-- Purpose: Sets the minimal number of screen lines to keep visible above and below the cursor.
-- This ensures context around the cursor when scrolling near the top or bottom of the window.
o.scrolloff = 4

-- Purpose: Sets the minimal number of screen columns to keep visible to the left and right of the cursor
-- when 'wrap' is off and horizontal scrolling occurs.
o.sidescrolloff = 4

-- Purpose: Disables the creation of swap files (.swp).
-- Swap files are used for recovery in case of a crash, but some users prefer to disable them
-- to avoid clutter or for specific workflows.
o.swapfile = false

-- Purpose: Sets the time in milliseconds that Neovim waits for a mapped sequence to complete.
-- A shorter value (default is 1000ms, NvChad might set it to 400ms) makes multi-key mappings feel more responsive.
o.timeoutlen = 300

-- Purpose: Sets the time in milliseconds that Neovim waits for a key code sequence (e.g., escape sequences from terminal).
-- Setting to 0 means no timeout specifically for key codes, which can be useful if `timeoutlen` is very short,
-- to avoid issues with interpreting escape keys.
o.ttimeoutlen = 0

-- Purpose: Sets the time in milliseconds after which Neovim writes the swap file (if enabled)
-- and triggers the CursorHold and CursorHoldI autocommand events.
-- A lower value means more frequent updates and faster triggering of CursorHold events.
o.updatetime = 200

-- Purpose: Automatically writes the contents of a changed buffer before executing certain commands
-- like :next, :make, shell commands, etc., if the buffer has a filename.
o.autowrite = true

-- Purpose: Disables the creation of backup files before overwriting an existing file.
-- By default, Vim creates a backup (e.g., file~), then overwrites the original.
o.writebackup = false

-- Purpose: A comma-separated list of patterns. Files matching these patterns will not have backup files created
-- even if 'writebackup' or 'backup' is enabled. This is often used for temporary or sensitive directories.
o.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"

-- Purpose: Disables the display of partially typed commands in the last line of the screen.
-- NvChad often handles this display in its statusline, so the default Vim behavior might be redundant.
o.showcmd = false

-- Purpose: Enables smooth scrolling when using commands like <C-e>, <C-y>, <C-d>, <C-u>, etc.
-- Instead of jumping by full lines/pages, the scrolling is done per screen line, which can look smoother.
o.smoothscroll = true

-- Preserve custom Vim script settings / Global Variables
-- These are typically global variables used by Vim's default scripts or older plugins
-- to control their behavior or indicate that certain initializations have occurred.

-- Purpose: Informs Vim's runtime scripts that default GUI menus have been (or should be considered) installed.
-- Often set to prevent re-installation if custom menu logic is in place.
g.did_install_default_menus = 1

-- Purpose: Similar to above, but specifically for the syntax menu in GUI versions.
g.did_install_syntax_menu = 1

-- Purpose: Indicates that filetype detection scripts (filetype.vim) have been loaded.
-- Can prevent them from being sourced again unnecessarily.
g.did_load_filetypes = 1

-- Purpose: Configures the listing style for the netrw file explorer plugin (Vim's built-in file explorer).
-- Style 3 usually means a "tree" listing style.
g.netrw_liststyle = 3
