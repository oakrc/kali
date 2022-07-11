-- Match pairs
table.insert(vim.opt.matchpairs, '<:>')

-- Folds
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend))]]
-- vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars = "fold: "
vim.opt.fillchars:append { eob = " " }

-- Session
vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,resize,winpos,terminal"

-- Autowrite
vim.opt.autowrite = true

-- Filetype Settings

-- No mode indicator
vim.opt.showmode = false

-- Better indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Better formatting
vim.opt.formatoptions = 'tcqrn1'

-- Paste into system clipboard
vim.o.clipboard = 'unnamedplus'

-- Split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

-- Set highlight on search
vim.o.hlsearch = true

-- Relative line numbers
vim.wo.number = true
vim.opt.relativenumber = true

-- Show matching cursor
vim.opt.showmatch = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 1
vim.cmd [[colorscheme onedark]]

--// Completion
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

