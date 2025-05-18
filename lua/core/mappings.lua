-- Import NVChad's default keymappings.
-- This establishes a base set of mappings provided by the NvChad configuration.
require "nvchad.mappings"

-- Local shortcut for vim.keymap.set and vim.keymap.del for brevity.
local map = vim.keymap.set
local del = vim.keymap.del

-- Remove NvChad's default mappings for toggling line numbers,
-- possibly to avoid conflicts or because custom ones are preferred.
del("n", "<leader>n")
del("n", "<leader>rn")

-- Remap ';' to ':' for quicker access to the command-line mode in normal mode.
map("n", ";", ":", { desc = "cmd enter command mode" })

-- Enhanced scrolling: Scroll half a page down/up (<C-d>/<C-u>)
-- and then center the cursor line on the screen ('zz').
map({ "n", "o", "x" }, "<C-d>", "12jzz", {}) -- Scrolls 12 lines down and centers.
map({ "n", "o", "x" }, "<C-u>", "12kzz", {}) -- Scrolls 12 lines up and centers.

-- Improved cursor movement for wrapped lines:
-- When moving down, if it's a single count (just <Down>), use 'gj' to move visually down a wrapped line.
-- Otherwise (e.g., 5<Down>), use 'j' to move by actual lines.
map({ "n", "v", "x" }, "<Down>", "v:count == 1 ? 'gj' : 'j'", { expr = true })

-- Move selected lines up or down in visual mode.
-- ':m '<-2<CR>' moves the visual selection (lines between '< and '>) up by one line (to position -2 relative to start).
-- 'gv=gv' reselects the previously selected visual area and re-indents it.
map("v", "K", ":m '<-2<cr>gv=gv", { silent = true }) -- Move visual selection up.
map("v", "J", ":m '>+1<cr>gv=gv", { silent = true }) -- Move visual selection down.

-- Formatting using the 'conform.nvim' plugin.
-- This mapping calls conform to format the current buffer,
-- with LSP formatting as a fallback if conform doesn't have a specific formatter.
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "conform: format file" })

-- Toggle the display of function signature help provided by 'lsp_signature.nvim'.
map("n", "<leader>sh", function()
  require("lsp_signature").toggle_float_win()
end, { desc = "LSP show signature help" })

-- Custom mappings for NvChad's tabufline (buffer/tab line).
map("n", "<leader>b", "<cmd>enew<cr>", { desc = "new buffer" }) -- Create a new empty buffer.
map("n", "<Tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "next buffer" }) -- Go to the next buffer in the tabufline.
map("n", "<S-Tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "previous buffer" }) -- Go to the previous buffer in the tabufline.
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "close buffer" }) -- Close the current buffer.

-- Terminal management using NvChad's terminal module.
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp", size = 0.45 } -- Open new horizontal terminal (split).
end, { desc = "new horizontal terminal" })
map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp", size = 0.7 } -- Open new vertical terminal (vertical split).
end, { desc = "new vertical terminal" })
map({ "n", "t" }, "<M-v>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4, id = "vtoggleTerm" } -- Toggle vertical terminal.
end, { desc = "toggle vertical terminal" })
map({ "n", "t" }, "<M-h>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4, id = "htoggleTerm" } -- Toggle horizontal terminal.
end, { desc = "toggle horizontal terminal" })
map({ "n", "t" }, "<M-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" } -- Toggle floating terminal.
end, { desc = "toggle floating terminal" })
map("t", "<ESC>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true) -- Close the current terminal window when <ESC> is pressed in terminal mode.
end, { desc = "close terminal" })

-- Mappings for 'Trouble.nvim' plugin (diagnostics and TODOs viewer).
map("n", "<leader>q", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "trouble: buffer diagnostics" }) -- Toggle Trouble for current buffer diagnostics.
map("n", "<leader>lt", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>", { desc = "trouble: lsp" }) -- Toggle Trouble for LSP-related items.
map("n", "<leader>t", "<cmd>TodoTrouble<cr>", { desc = "trouble: show TODOs" }) -- Open TodoTrouble to list TODO comments.

-- Mappings for jumping between TODO comments using 'todo-comments.nvim'.
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "trouble: next TODO" }) -- Jump to the next TODO comment.
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "trouble: prev TODO" }) -- Jump to the previous TODO comment.

-- Mapping for 'Neogit', a Git porcelain for Neovim.
map("n", "<leader>gn", "<cmd>Neogit<cr>", { desc = "neogit" }) -- Open the Neogit interface.

-- Mappings for 'Telescope.nvim' (fuzzy finder).
map(
  "n",
  "<leader>ff",
  "<cmd>Telescope find_files follow=true hidden=true no_ignore=false<cr>",
  { desc = "telescope: find files" }
) -- Find files (shows hidden, respects .gitignore).
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "telescope: find TODOs" }) -- Find TODO comments using Telescope.
map({ "n", "v" }, "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "telescope: grep string" }) -- Grep for a string in project files.
map("n", "<leader>fr", "<cmd>Telescope treesitter<cr>", { desc = "telescope: ts symbols" }) -- List and jump to Treesitter symbols in the current buffer.
map("n", "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "telescope: lsp symbols" }) -- List and jump to LSP document symbols.
map("n", "<leader>gm", "<cmd>Telescope git_commits<cr>", { desc = "telescope: git commits" }) -- Browse Git commits.

-- Mapping for 'oil.nvim', a file explorer.
map("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "oil: float window" }) -- Open Oil in a floating window.

-- Toggle LSP inlay hints using a custom utility function.
map("n", "gh", function()
  require("core.utils").toggle_inlay_hints()
end, { desc = "toggle inlay hints" })

-- Mappings for 'Neotest', a test runner framework for Neovim.
map("n", "<leader>nrr", function()
  require("neotest").run.run()
end, { desc = "neotest: run the nearest test" }) -- Run the test nearest to the cursor.
map("n", "<leader>nrf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "neotest: run the current file" }) -- Run all tests in the current file.
map("n", "<leader>nrl", function()
  require("neotest").run.run_last()
end, { desc = "neotest: run the last test with same specs" }) -- Re-run the last executed test.
map("n", "<leader>nrs", function()
  require("neotest").run.stop()
end, { desc = "neotest: stop running test" }) -- Stop any currently running test.
map("n", "<leader>nra", function()
  require("neotest").run.attach()
end, { desc = "neotest: attach to running test" }) -- Attach to a running test process (e.g., for debugging).
map("n", "<leader>nwt", function()
  require("neotest").watch.toggle()
end, { desc = "neotest: toggle watching position" }) -- Toggle watch mode for tests near the cursor.
map("n", "<leader>nws", function()
  require("neotest").watch.stop()
end, { desc = "neotest: stop watching position" }) -- Stop all watch modes.
map("n", "<leader>noo", function()
  require("neotest").output.open { enter = true }
end, { desc = "neotest: open output of test result" }) -- Open the output of a test result.
map("n", "<leader>not", function()
  require("neotest").output_panel.toggle()
end, { desc = "neotest: toggle output panel" }) -- Toggle the Neotest output panel.
map("n", "<leader>noc", function()
  require("neotest").output_panel.clear()
end, { desc = "neotest: clear output panel" }) -- Clear the Neotest output panel.
map("n", "<leader>ns", function()
  require("neotest").summary.toggle()
end, { desc = "neotest: toggle summary window" }) -- Toggle the Neotest summary window.
map("n", "<leader>njn", function()
  require("neotest").jump.next()
end, { desc = "neotest: jump next test" }) -- Jump to the next test definition.
map("n", "<leader>njp", function()
  require("neotest").jump.prev()
end, { desc = "neotest: jump previous test" }) -- Jump to the previous test definition.

-- Mappings for 'Neoconf.nvim', a configuration manager.
map("n", "<leader>ncf", "<cmd>Neoconf<cr>", { desc = "neoconf: edit settings" }) -- Open Neoconf to edit settings.
map("n", "<leader>ncl", "<cmd>Neoconf local<cr>", { desc = "neoconf: edit local config" }) -- Edit local project configuration with Neoconf.
map("n", "<leader>ncg", "<cmd>Neoconf global<cr>", { desc = "neoconf: edit global config" }) -- Edit global configuration with Neoconf.
map("n", "<leader>ncs", "<cmd>Neoconf show<cr>", { desc = "neoconf: show merged config" }) -- Show the merged Neoconf configuration.
map("n", "<leader>ncp", "<cmd>Neoconf lsp<cr>", { desc = "neoconf: show merged LSP config" }) -- Show the merged LSP configuration managed by Neoconf.
