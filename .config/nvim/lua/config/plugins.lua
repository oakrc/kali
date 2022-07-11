-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
  ]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  -- I probably should have put all the config in the use() calls but it's too much effort
  --// Essentials
  use 'wbthomason/packer.nvim' -- Package manager
  use 'svermeulen/vimpeccable'

  --// Git
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  --// Editing & Navigation
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'windwp/nvim-autopairs'
  use 'justinmk/vim-sneak'
  use 'mbbill/undotree'
  use 'tpope/vim-surround'

  --// UI
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-tree'.setup {
        disable_netrw = false,
        hijack_netrw = false,
        view = {
          auto_resize = true,
          width = 25
        },
        update_cwd = true,
      }
    end
  }
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  use 'pierreglaser/folding-nvim'

  --// Code Completion
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'arkav/lualine-lsp-progress'

  -- coq / autocomplete
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  --// File types
  use 'mboughaba/i3config.vim'
  use 'nvim-orgmode/orgmode'
  use 'akinsho/org-bullets.nvim'
  -- TODO: enable and configured headlines.nvim
  use { 'lukas-reineke/headlines.nvim', disabled = true }
  -- TODO: enable and configured sniprun
  use { 'michaelb/sniprun', run = 'bash ./install.sh', disabled = true }

  --// Session Management
  use { 'rmagatti/session-lens', disable = true, requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' } }
  use 'ahmedkhalf/project.nvim'

  --// Miscellaneous / QoL
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-eunuch'
  use 'chrisbra/Colorizer'
  use 'ericcurtin/CurtineIncSw.vim'
  use 'lambdalisue/suda.vim'
  use 'jamessan/vim-gnupg'
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim', disabled = true }
  -- use { 'andweeb/presence.nvim', disabled = true }
end)

-- GitSigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '' },
    change = { hl = 'GitGutterChange', text = '' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '' },
  },
  yadm = {
    enable = true
  }
}

-- Telescope
local trouble_tele = require('trouble.providers.telescope')
local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<c-t>"] = trouble_tele.open_with_trouble,
        ['<esc>'] = actions.close,
        ['<M-p>'] = actions_layout.toggle_preview,
      },
      n = {
        ["<c-t>"] = trouble_tele.open_with_trouble,
        ['<M-p>'] = actions_layout.toggle_preview
      },
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
require("telescope").load_extension('file_browser')

-- indent_blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
}

-- Treesitter
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
require('orgmode').setup_ts_grammar()
require('nvim-treesitter.configs').setup {
  ensure_installed = {'org','c','cpp','bash','fish','html','php','python','regex','css','javascript','cmake'},
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {'org', 'markdown'},
    additional_vim_regex_highlighting = {'org', 'markdown'},
    ensure_installed = {'org'}
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
        [']a'] = '@parameter.inner',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
        [']A'] = '@parameter.inner',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
        ['[a'] = '@parameter.inner',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
        ['[A'] = '@parameter.inner',
      },
    },
  },
}

-- COQ
vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
      recommended = false
  },
  display = {
    pum = {
      fast_close = false
    }
  }
}
require('coq')
require('coq_3p') {
  { src = 'nvimlua', short_name = 'nLUA' }
}


-- LSP
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local vimp = require('vimp')
  vimp.add_buffer_maps(bufnr, function ()
    vimp.nnoremap({'silent'}, 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    vimp.nnoremap({'silent'}, 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    vimp.nnoremap({'silent'}, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- vimp.nnoremap({'silent'}, 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vimp.nnoremap({'silent'}, 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    vimp.nnoremap({'silent'}, '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vimp.nnoremap({'silent'}, '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    vimp.nnoremap({'silent'}, '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    vimp.nnoremap({'silent'}, '<leader>wf', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    vimp.nnoremap({'silent'}, '<leader>cd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vimp.nnoremap({'silent'}, '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vimp.nnoremap({'silent'}, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vimp.vnoremap({'silent'}, '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
    vimp.nnoremap({'silent'}, '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    vimp.nnoremap({'silent'}, '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    vimp.nnoremap({'silent'}, ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    vimp.nnoremap({'silent'}, '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    vimp.nnoremap({'silent'}, '<leader>si', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
    vimp.nnoremap({'silent'}, '<leader>sw', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]])
  end)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- Plugin: folding-nvim
  require('folding').on_attach()

end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
--local nvim_capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Set up LSPs
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup{
  automatic_installation = true
}

local opts = {
  on_attach = on_attach,
  capabilities = capabilities
}
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = on_attach,
  capabilities = capabilities
}))
lspconfig.clangd.setup(coq.lsp_ensure_capabilities(opts))
lspconfig.pyright.setup(coq.lsp_ensure_capabilities(opts))
lspconfig.bashls.setup(coq.lsp_ensure_capabilities(opts))
lspconfig.powershell_es.setup(coq.lsp_ensure_capabilities({
  filetypes = {"ps1","powershell"},
  on_attach = on_attach,
  capabilities = capabilities
}))


-- Set up Sumneko
local sumneko_binary = '/usr/bin/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
  -- cmd = { sumneko_binary, '-E', '/usr/share/lua-language-server/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Autopairs
local autopairs = require('nvim-autopairs')
autopairs.setup({ check_ts = true, map_bs = false, map_cr = false })
autopairs.enable()

-- Projects
require("project_nvim").setup {
  detection_methods = { "lsp", "pattern" }
}

-- Todo Comments

require("todo-comments").setup {

    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    keywords = {
        FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        TEST = { icon = " ", color = "warning" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
}

-- Session
-- require('auto-session').setup({
--   log_level = 'info',
--   auto_session_enable_last_session = false,
--   auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
--   auto_session_enabled = true,
--   auto_save_enabled = nil,
--   auto_restore_enabled = nil,
--   auto_session_suppress_dirs = nil
-- })
-- require('session-lens').setup{}
-- require("telescope").load_extension("session-lens")
vim.g.nvim_tree_respect_buf_cwd = 1

-- Org Mode
require('orgmode').setup{
  org_agenda_files = {"~/org/todo.org", "~/org/cal.org", "~/org/gcal.org", "~/org/habits.org"},
  org_default_notes_file = '~/org/inbox.org',
}

-- code runner
-- require('code_runner').setup{
--     filetype = {
--         python = "python",
--         java = "cd $dir && javac $file && java $fileNameWithoutExt",
--         cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
--         rust = "cd $dir && cargo run",
--         [''] = ""
--     }
-- }

-- presence.nvim
-- require('presence'):setup {
--     -- General options
--     auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
--     neovim_image_text   = "Neovim",                   -- Text displayed when hovered over the Neovim image
--     main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
--     client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
--     log_level           = 'warn',                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
--     debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
--     enable_line_number  = false,                      -- Displays the current line number instead of the current project
--     blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
--     buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

--     -- Rich Presence text options
--     editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
--     file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
--     git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
--     plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
--     reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
--     workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
--     line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
-- }
