local opt = vim.opt
local g = vim.g
local o = vim.o

opt.relativenumber = true
opt.guicursor = ""
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.swapfile = false
opt.timeout = true
opt.timeoutlen = 300
opt.ttimeout = true
opt.ttimeoutlen = 0
opt.updatetime = 200
opt.termguicolors = true
opt.autoindent = true
opt.autoread = true
opt.autowrite = true
opt.backup = false
opt.conceallevel = 2
opt.writebackup = false
opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
opt.swapfile = false
opt.showcmd = false
opt.showmode = false
opt.fillchars = { eob = " " }
opt.shortmess:append "sI"
opt.whichwrap:append "<>[]hl"

o.cursorlineopt = "both"
o.laststatus = 3
o.clipboard = "unnamedplus"
o.cursorline = true
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.number = true
o.numberwidth = 2
o.ruler = false
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.undofile = true

g.did_install_default_menus = 1
g.did_install_syntax_menu = 1
g.did_load_filetypes = 1
g.netrw_liststyle = 3

vim.cmd.syntax "manual"

if vim.fn.has "nvim-0.10" == 1 then
  vim.opt.smoothscroll = true
end

-- For auto-session plugin
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Disable some default providers
g["loaded_node_provider"] = 0
g["loaded_python3_provider"] = 0
g["loaded_perl_provider"] = 0
g["loaded_ruby_provider"] = 0

-- Add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. ":" .. vim.env.PATH
