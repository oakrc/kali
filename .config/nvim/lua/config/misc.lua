-- Unfold all folds on start
vim.api.nvim_exec([[au BufWinEnter * normal zR]], false)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)
