local vimp = require('vimp')
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- TODO: https://github.com/phaazon/hop.nvim

-- >>> Editing
vimp.inoremap({'override'}, '<C-u>', '<C-g>u<C-u>')
vimp.inoremap({'override'}, '<C-w>', '<C-g>u<C-w>')
vimp.inoremap('<C-f>', '<C-x><C-f>')
vimp.inoremap('<C-l>', '<Right><C-x><C-f>')
-- move lines in visual mode
vimp.vnoremap({'silent'}, 'J', [[:m '>+1<CR>gv=gv]])
vimp.vnoremap({'silent'}, 'K', [[:m '<-2<CR>gv=gv]])

-- >>> File Navigation
vimp.nnoremap({'silent'}, '<leader>,', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vimp.nnoremap({'silent'}, '<leader><lt>', [[<cmd>lua require('telescope').extensions.file_browser.file_browser{depth=10}<CR>]])
vimp.nnoremap({'silent'}, '<leader>.', [[<cmd>lua require('telescope').extensions.file_browser.file_browser{cwd=require('telescope.utils').buffer_dir()}<CR>]])
vimp.nnoremap({'silent'}, '<leader>>', [[<cmd>lua require('telescope.builtin').find_files{cwd=require('telescope.utils').buffer_dir()}<CR>]])
vimp.nnoremap({'silent'}, '<leader>/', [[<cmd>lua require('telescope.builtin').grep_string{cwd=require('telescope.utils').buffer_dir()}<CR>]])
vimp.nnoremap({'silent'}, '<leader>?', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
vimp.nnoremap({'silent'}, '<leader><tab>', [[<cmd>NvimTreeToggle<cr>]])
vimp.nnoremap('<leader><leader>', function()
  local opts = {}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end)
vimp.nnoremap('<leader>`', '<C-^>')
-- <<< File Navigation

-- >>> Seek
vimp.nnoremap({'silent'}, '<leader>ss', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
vimp.nnoremap({'silent'}, '<leader>sS', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
vimp.nnoremap({'silent'}, '<leader>sr', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]])
vimp.nnoremap({'silent'}, '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
vimp.nnoremap({'silent'}, '<leader>st', [[<cmd>TodoTelescope<CR>]])
vimp.nnoremap({'silent'}, '<leader>sT', [[<cmd>lua require('telescope.builtin').tags()<CR>]])
--vimp.nnoremap({'silent'}, '<leader>sT', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
--vimp.nnoremap({'silent'}, '<leader>sl', [[<cmd>lua require('telescope.builtin').loclist()<CR>]])
vimp.nnoremap({'silent'}, '<leader>sl', [[<cmd>TroubleToggle<CR>]])
vimp.nnoremap({'silent'}, '<leader>sg', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
vimp.nnoremap({'silent'}, '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep{cwd=require('telescope.utils').buffer_dir()}<CR>]])
vimp.nnoremap({'silent'}, '<leader>sP', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
-- <<< Seek

-- >>> File Operations
-- Recent files
vimp.nnoremap({'silent'}, '<leader>fr', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
-- Rename file
vimp.nnoremap('<leader>fR', function ()
   local dest = vim.fn.input('Rename to: ', vim.api.nvim_buf_get_name(0))
   vim.cmd("Move " ..  dest)
end)
-- Find files
vimp.nnoremap({'silent'}, '<leader>fd', [[<cmd>lua require('telescope.builtin').fd()<CR>]])
-- Delete file
local function isfile(name)
  local f = io.open(name,"r")
  if f ~= nil then
    io.close(f)
    return true
  else return false
  end
end
vimp.nnoremap('<leader>fD', function()
  if isfile(vim.api.nvim_buf_get_name(0)) then
    local ans = vim.fn.input('Really delete the buffer & file? [y/N] ')
    if ans == 'y' then
      vim.cmd 'Delete'
    end
  else
    print('Related file not found')
  end
end)
-- Copy filename
vimp.nnoremap('<leader>fy', function ()
  vim.fn.setreg('+', vim.api.nvim_buf_get_name(0))
  print('Filename copied!')
end)
-- Edit configs
vimp.nnoremap({'silent'}, '<leader>fp',
  [[<cmd>lua require('telescope').extensions.file_browser.file_browser{cwd = vim.fn.stdpath('config') .. '/lua/config'}<CR>]])
-- Write all buffers
vimp.nnoremap({'silent'}, '<leader>fw', [[<cmd>wa<cr>]])

vimp.nnoremap({'silent'}, '<leader>f<tab>', [[<cmd>NvimTreeFocus<cr>]])
vimp.nnoremap({'silent'}, '<leader>ff', [[<cmd>NvimTreeFindFile<cr>]])
-- <<< File Operations

-- >>> Buffers
vimp.nnoremap({'silent'}, '<leader>bk', [[<C-^>:bd#<cr>]]) -- kill current buffer
vimp.nnoremap({'silent'}, '<leader>bK', [[<cmd>bufdo bdelete<cr>]]) -- kill all buffers
vimp.nnoremap({'silent'}, '<leader>bO', [[<cmd>%bd|e#<cr>]]) -- kill all other buffers
-- <<< Buffers

-- >>> Git
vimp.nnoremap({'silent'}, '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]])
vimp.nnoremap({'silent'}, '<leader>gC', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
vimp.nnoremap({'silent'}, '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
vimp.nnoremap({'silent'}, '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
vimp.nnoremap({'silent'}, '<leader>gS', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]])
-- <<< Git

-- >>> Meta
vimp.nnoremap({'silent'}, '<leader>hk', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
vimp.nnoremap({'silent'}, '<leader>ho', [[<cmd>lua require('telescope.builtin').vim_options()<CR>]])
vimp.nnoremap({'silent'}, '<leader>hc', [[<cmd>lua require('telescope.builtin').commands()<CR>]])
vimp.nnoremap({'silent'}, '<M-x>', [[<cmd>lua require('telescope.builtin').commands()<CR>]])
vimp.nnoremap({'silent'}, '<leader>ht', [[<cmd>Telescope<CR>]])
-- <<< Meta

-- >>> Project/Session Management
vimp.nnoremap({'silent'}, '<leader>pp', [[<cmd>Telescope projects<CR>]])
vimp.nnoremap({'silent'}, '<leader>pc', [[<cmd>cd %:h<CR>]])
-- <<< Project/Session Management

-- >>> LSP
-- Refer to plugins.lua
-- <<< LSP
--

-- >>> Miscellaneous

-- Commenting
vimp.nnoremap({'silent'}, '<leader>c/', [[<cmd>Commentary<cr>]])
vimp.vnoremap({'silent'}, '<leader>c/', [[<cmd>'<,'>Commentary<cr>]])

-- Creating splits
vimp.nnoremap('<leader>wv', [[<cmd>vs<cr>]])
vimp.nnoremap('<leader>ws', [[<cmd>sp<cr>]])

-- Window navigation
vimp.nnoremap('<leader>wh', '<C-w>h')
vimp.nnoremap('<leader>wj', '<C-w>j')
vimp.nnoremap('<leader>wk', '<C-w>k')
vimp.nnoremap('<leader>wl', '<C-w>l')
vimp.nnoremap('<leader>wH', '<C-w>H')
vimp.nnoremap('<leader>wJ', '<C-w>J')
vimp.nnoremap('<leader>wK', '<C-w>K')
vimp.nnoremap('<leader>wL', '<C-w>L')
vimp.nnoremap('<leader>wt', [[<cmd>tabnew<cr>]])
vimp.nnoremap({'silent'}, '<leader>wq', [[<cmd>x<cr>]])
vimp.nnoremap({'silent'}, '<leader>Q', [[<cmd>xa<cr>]])

-- Move visual lines instead of real lines
vimp.nnoremap({'expr', 'silent'}, 'k', "v:count == 0 ? 'gk' : 'k'")
vimp.nnoremap({'expr', 'silent'}, 'j', "v:count == 0 ? 'gj' : 'j'")

-- Escape shuold reset search highlight
vimp.nnoremap({'silent'}, '<esc>', ':noh<cr><esc>')

-- Reload config
vimp.nnoremap('<leader>R', function()
  vimp.unmap_all()
  require("config.util").unload_lua_namespace('config')
  vim.cmd('silent wa')
  dofile(vim.fn.stdpath('config') .. '/init.lua')

  print("Reloaded config!")
end)

-- Undotree
vimp.nnoremap({'silent'}, '<leader>u', [[<cmd>UndotreeToggle<cr>]])

-- <<< Miscellaneous

-- >>> nvim-autopairs
local npairs = require('nvim-autopairs')
-- these mappings are coq recommended mappings unrelated to nvim-autopairs
vimp.inoremap({'expr'}, '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]])
vimp.inoremap({'expr'}, '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]])
vimp.inoremap({'expr'}, '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]])
vimp.inoremap({'expr'}, '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]])

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
vimp.inoremap({'expr'}, '<cr>', 'v:lua.MUtils.CR()')

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
vimp.inoremap({'expr'}, '<bs>', 'v:lua.MUtils.BS()')
-- <<< nvim-autopairs

-- >>> Trouble.nvim
vimp.nnoremap({'silent'}, '<leader>tt', [[<cmd>TroubleToggle<cr>]])
vimp.nnoremap({'silent'}, '<leader>td', [[<cmd>TodoTrouble<cr>]])
vimp.nnoremap({'silent'}, '<leader>tw', [[<cmd>TroubleToggle lsp_workspace_diagnostics<cr>]])
vimp.nnoremap({'silent'}, '<leader>tf', [[<cmd>TroubleToggle lsp_document_diagnostics<cr>]])
vimp.nnoremap({'silent'}, '<leader>tq', [[<cmd>TroubleToggle quickfix<cr>]])
vimp.nnoremap({'silent'}, '<leader>tl', [[<cmd>TroubleToggle loclist<cr>]])
vimp.nnoremap({'silent'}, 'gr', [[<cmd>TroubleToggle lsp_references<cr>]])
-- <<< Trouble.nvim

-- >>> org mode
vimp.nnoremap({'silent'}, '<leader>rj', [[<cmd>edit ~/org/todo.org<cr>]])
vimp.nnoremap({'silent'}, '<leader>r/', [[<cmd>lua require('telescope.builtin').find_files{cwd='~/org/'}<cr>]])
-- <<< org mode

-- <<< IDE actions
-- vimp.nnoremap({'silent'}, '<leader>ir', [[<cmd>RunCode<cr>]])
-- vimp.nnoremap({'silent'}, '<leader>iR', [[<cmd>RunFile<cr>]])
vimp.nnoremap({'silent'}, '<leader>ir', [[<cmd>RunCode<cr>]])
vimp.nnoremap({'silent'}, '<leader>iR', [[<cmd>RunFile<cr>]])
-- >>> IDE actions

