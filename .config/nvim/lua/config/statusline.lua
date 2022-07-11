local lualine = require 'lualine'

-- nord colors
local nord0 = '#2E3440'
local nord1 = '#3B4252'
local nord2 = '#434C5E'
local nord3 = '#4C566A'
local nord4 = '#D8DEE9'
local nord5 = '#E5E9F0'
local nord6 = '#ECEFF4'
local nord7 = '#8FBCBB'
local nord8 = '#88C0D0'
local nord9 = '#81A1C1'
local nord10 = '#5E81AC'
local nord11 = '#BF616A'
local nord12 = '#D08770'
local nord13 = '#EBCB8B'
local nord14 = '#A3BE8C'
local nord15 = '#B48EAD'

local colors = {
  bg       = nord0,
  fg       = nord4,
  yellow   = '#ccb078',
  cyan     = '#61b2bf',
  darkblue = '#2b4f82',
  green    = nord14,
  orange   = nord12,
  violet   = nord15,
  magenta  = '#ac78dd',
  frost    = nord8,
  blue     = nord10,
  bluegreen= nord7,
  bluegray = nord9,
  red      = nord11,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    disabled_filetypes = {'NvimTree', 'help', 'Trouble', 'qf'},
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks of statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local function ins_left_inactive(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

local function ins_right_inactive(component)
  table.insert(config.inactive_sections.lualine_x, component)
end

local mode = {
  function()
    -- auto change color according to neovim mode
    local mode_color = {
      n = colors.green,
      i = colors.blue,
      v = colors.magenta,
      [''] = colors.magenta,
      V = colors.magenta,
      c = colors.red,
      no = colors.bluegreen,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    -- return ''
    -- return mode_name[vim.fn.mode()]
    return '▊'
  end,
  color = 'LualineMode',
  padding = { left = 0, right = 0 },
}

local branch = {
  'branch',
  icon = '',
  color = { fg = colors.orange },
}

local inactive_branch = {
  'branch',
  icon = '',
  color = { fg = colors.frost },
  padding = { left = 2, right = 0 }
}


local filename = {
  'filename',
  file_status = false,
  cond = conditions.buffer_not_empty,
  path = 1,
  color = { fg = colors.violet, gui = 'bold,italic' },
}

local inactive_filename = {
  'filename',
  file_status = false,
  cond = conditions.buffer_not_empty,
  path = 1,
  color = { fg = colors.bluegray, gui = 'italic' },
  padding = { left = 2, right = 1 }
}

local file_status = {
  function ()
    if vim.bo.modified then
      return ''
    elseif vim.bo.modifiable == false then
      return 'ﰸ'
    elseif vim.bo.readonly == true then
      return ''
    end
    return ' '
  end,
  padding = { left = 0, right = 1 }
}

local lsp_diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
local align = {
  function()
    return '%='
  end,
}

local function get_buf_lsp()
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, filetype) ~= -1 then
      return client.name
    end
  end
  return ''
end

local lsp_name = {
  -- LSP server name
  function()
    return get_buf_lsp()
  end,
  icon = '',
  cond = function ()
    return get_buf_lsp() ~= ''
  end,
  color = { fg = colors.frost, gui = 'bold' },
}

-- Add components to right sections
local diff = {
  -- TODO: use gitsigns?
  'diff',
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  -- cond = conditions.hide_in_width,
}

local file_type = {
  function ()
    local type = vim.bo.filetype
    if type ~= vim.fn.expand('%:e') then
      return type
    else
      return ''
    end
  end,
  color = { fg = colors.green },
}

local encoding = {
  function ()
    local encoding = vim.bo.fileencoding
    if #encoding > 0 and encoding ~= 'utf-8' then
      return encoding
    else
      return ''
    end
  end,
  cond = conditions.hide_in_width,
  color = { fg = colors.green },
}

local file_format = {
  function ()
    local format = vim.bo.fileformat
    if format ~= 'unix' then
      return format
    else
      return ''
    end
  end,
  icons_enabled = true,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
}

local location = {
  'location',
  icon = '',
  cond = conditions.hide_in_width,
}

local right_bar = {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

local lsp_progress = {
  'lsp_progress',
  spinner_symbols = {'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'},
  display_components = { 'spinner', { 'title', 'percentage', 'message' } },
  timer = { progress_enddelay = 200, spinner = 100, lsp_client_name_enddelay = 1000 },
}

ins_left(mode)
ins_left(branch)
ins_left(filename)
ins_left(file_status)
ins_left(lsp_name)
ins_left(lsp_progress)
ins_left(lsp_diagnostics)

ins_right(diff)
ins_right(file_type)
ins_right(encoding)
ins_right(file_format)
ins_right(location)

ins_left_inactive(inactive_branch)
ins_left_inactive(inactive_filename)
ins_left_inactive(file_status)

-- Now don't forget to initialize lualine
lualine.setup(config)
