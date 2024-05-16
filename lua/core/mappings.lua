local map = vim.keymap.set

-- Faster opening of vim-cli mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Navigation in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move End of line" })

-- Allow moving the cursor through wrapped lines with <Up> and <Down>
map({ "n", "v", "x" }, "<Down>", "v:count == 1 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "v", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines up/down
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Clear highlights
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

-- Window management
map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })

-- File maps
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })
map("n", "<C-p>", "G$vgg0", { desc = "Select whole file" })

-- Replace visually selected text
map("v", "<leader>sc", '"hy:%s/<C-r>h//g<Left><Left>')

-- Formatting
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

-- Global lsp mappings
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Lsp floating diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })

-- Tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer New" })
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })
map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

-- Comment
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment Toggle" })
map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment Toggle" }
)

-- NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus window" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { silent = true, desc = "Terminal Escape terminal mode" })
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp", size = 0.45 }
end, { silent = true, desc = "Terminal New horizontal term" })
map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp", size = 0.7 }
end, { silent = true, desc = "Terminal New vertical window" })
map({ "n", "t" }, "<M-v>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4, id = "vtoggleTerm" }
end, { silent = true, desc = "Terminal Toggleable vertical term" })
map({ "n", "t" }, "<M-h>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4, id = "htoggleTerm" }
end, { silent = true, desc = "Terminal New horizontal term" })
map({ "n", "t" }, "<M-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { silent = true, desc = "Terminal Toggle Floating term" })
map("t", "<ESC>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { silent = true, desc = "Terminal Close term in terminal mode" })

-- Which-key
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey all keymaps" })
map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "Whichkey query lookup" })

-- Spider
map({ "n", "o", "x" }, "w", function()
  require("spider").motion "w"
end, { noremap = true })
map({ "n", "o", "x" }, "e", function()
  require("spider").motion "e"
end, { noremap = true })
map({ "n", "o", "x" }, "b", function()
  require("spider").motion "b"
end, { noremap = true })
map({ "n", "o", "x" }, "ge", function()
  require("spider").motion "ge"
end, { noremap = true })
map("n", "cw", "c<CMD>lua require('spider').motion('e')<CR>")

-- Hop
map("n", "gw", ":HopWordMW<CR>", { silent = true, noremap = true })
map("n", "<leader>k", ":HopLineMW<CR>", { silent = true, noremap = true })
map("n", "gc", ":HopChar1MW<CR>", { silent = true, noremap = true })
map("n", "<leader>g2c", ":HopChar2MW<CR>", { silent = true, noremap = true })

-- Trouble
map("n", "<leader>q", ":TroubleToggle<CR>", { silent = true, noremap = true })

-- TodoTrouble
map("n", "<leader>t", ":TodoTrouble<CR>", { silent = true, noremap = true })

-- Todo-jumping
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { silent = true, noremap = true, desc = "Next todo comment" })

map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { silent = true, noremap = true, desc = "Previous todo comment" })

-- Neogit
map("n", "<leader>gn", ":Neogit<CR>", { silent = true, noremap = true })

-- Telescope
map(
  "n",
  "<leader>ff",
  ":Telescope find_files follow=true no_ignore=false hidden=true <CR>",
  { silent = true, noremap = true, desc = "Find files" }
)
map("n", "<leader>ft", ":TodoTelescope<CR>", { silent = true, noremap = true })
map("n", "<leader>fg", ":Telescope grep_string<CR>", { silent = true, noremap = true })
map("n", "<leader>fr", ":Telescope treesitter<CR>", { silent = true, noremap = true })
map("n", "<leader>fd", ":Telescope lsp_document_symbols<CR>", { silent = true, noremap = true })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope Find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
map("n", "<leader>gm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Telescope Pick hidden term" })
map("n", "<leader>fc", "<cmd>Telescope themes<CR>", { desc = "Telescope Nvchad themes" })

-- Oil
map("n", "<leader>o", ":Oil --float<CR>", { silent = true, noremap = true })

-- Bufdelete
map("n", "<leader>dd", ":BufDel<CR>", { silent = true, noremap = true })

-- Toggle Inlay Hints
map(
  "n",
  "gh",
  ":lua require('configs.lsp.lspconfig').toggle_inlay_hints()<CR>",
  { silent = true, noremap = true, desc = "Toggle Inlay Hints" }
)

-- Auto-session
map("n", "<leader>sr", ":SessionRestore<CR>", { silent = true, noremap = true, desc = "Session restore" })
map("n", "<leader>ss", ":SessionSave<CR>", { silent = true, noremap = true, desc = "Session save" })
map(
  "n",
  "<leader>fss",
  ":lua require('auto-session.session-lens').search_session()<CR>",
  { silent = true, noremap = true, desc = "Session search" }
)

-- Substitute
map("n", "s", function()
  require("substitute").operator()
end, { noremap = true })
map("n", "ss", function()
  require("substitute").line()
end, { noremap = true })
map("n", "S", function()
  require("substitute").eol()
end, { noremap = true })
map("x", "s", function()
  require("substitute").visual()
end, { noremap = true })

-- Spectre
map("n", "<leader>S", ':lua require("spectre").toggle()<CR>', { silent = true, desc = "Toggle Spectre" })
map(
  "v",
  "<leader>sw",
  '<esc>:lua require("spectre").open_visual()<CR>',
  { silent = true, desc = "Search current word" }
)
map(
  "n",
  "<leader>sw",
  ':lua require("spectre").open_visual({select_word=true})<CR>',
  { silent = true, desc = "Search current word" }
)
map(
  "n",
  "<leader>sf",
  ':lua require("spectre").open_file_search()<CR>',
  { silent = true, desc = "Search on current file" }
)
map(
  "n",
  "<leader>sp",
  ':lua require("spectre").open_file_search({select_word=true})<CR>',
  { silent = true, desc = "Search current word on current file" }
)

-- Noice
map("n", "<leader>dn", ":NoiceDismiss<CR>", { silent = true, noremap = true })

-- Tabout
map("i", "<C-f>", "<Tab>", { silent = true, noremap = true })

-- Neotest
map(
  "n",
  "<leader>nrr",
  ":lua require('neotest').run.run()<CR>",
  { silent = true, noremap = true, desc = "Run the nearest test" }
)
map(
  "n",
  "<leader>nrf",
  ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { silent = true, noremap = true, desc = "Run the current file" }
)
map(
  "n",
  "<leader>nrl",
  ":lua require('neotest').run.run_last()<CR>",
  { silent = true, noremap = true, desc = "Run the last test that was run with the same arguments and strategy" }
)
map(
  "n",
  "<leader>nrs",
  ":lua require('neotest').run.stop()<CR>",
  { silent = true, noremap = true, desc = "Stop a running test" }
)
map(
  "n",
  "<leader>nra",
  ":lua require('neotest').run.attach()<CR>",
  { silent = true, noremap = true, desc = "Attach to a running test" }
)
map(
  "n",
  "<leader>nwt",
  ":lua require('neotest').watch.toggle()<CR>",
  { silent = true, noremap = true, desc = "Toggle watching a pos and run it whenever related files are changed" }
)
map(
  "n",
  "<leader>nws",
  ":lua require('neotest').watch.stop()<CR>",
  { silent = true, noremap = true, desc = "Stop watching a position" }
)
map(
  "n",
  "<leader>noo",
  ":lua require('neotest').output.open({enter = true})<CR>",
  { silent = true, noremap = true, desc = "Open the output of a test result" }
)
map(
  "n",
  "<leader>not",
  ":lua require('neotest').output_panel.toggle()<CR>",
  { silent = true, noremap = true, desc = "Toggle the output panel" }
)
map(
  "n",
  "<leader>noc",
  ":lua require('neotest').output_panel.clear()<CR>",
  { silent = true, noremap = true, desc = "Clears the output panel" }
)
map(
  "n",
  "<leader>ns",
  ":lua require('neotest').summary.toggle()<CR>",
  { silent = true, noremap = true, desc = "Toggle the summary window" }
)
map(
  "n",
  "<leader>njn",
  ":lua require('neotest').jump.next()<CR>",
  { silent = true, noremap = true, desc = "Jump to the next test" }
)
map(
  "n",
  "<leader>njp",
  ":lua require('neotest').jump.prev()<CR>",
  { silent = true, noremap = true, desc = "Jump to the prev test" }
)

-- Neoconf
map("n", "<leader>ncf", ":Neoconf<CR>", { silent = true, desc = "Select one of the config files to edit" })
map("n", "<leader>ncl", ":Neoconf local<CR>", { silent = true, desc = "Select one of the local config files to edit" })
map(
  "n",
  "<leader>ncg",
  ":Neoconf global<CR>",
  { silent = true, desc = "Select one of the global config files to edit" }
)
map("n", "<leader>ncs", ":Neoconf show<CR>", { silent = true, desc = "Opens a floating window with the merged config" })
map(
  "n",
  "<leader>ncp",
  ":Neoconf lsp<CR>",
  { silent = true, desc = "Opens a floating window with your merged lsp config" }
)

-- Treesj
map("n", "gm", ":TSJToggle<CR>", { silent = true, desc = "Toggle node under cursor" })
map("n", "gS", ":TSJSplit<CR>", { silent = true, desc = "Split node under cursor" })
map("n", "gJ", ":TSJJoin<CR>", { silent = true, desc = "Join node under cursor" })

-- Markdown-preview
map("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown-preview toggle" })

-- Nvim-colorizer
map("n", "<leader>cc", function()
  require("colorizer").attach_to_buffer(0)
end, { silent = true, noremap = true })
