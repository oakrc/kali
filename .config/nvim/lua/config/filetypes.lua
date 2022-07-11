local exec = function(s)
  vim.api.nvim_exec(s, false)
end
-- Lua
exec(
  [[
    augroup lua
      au!
      au FileType lua setlocal ts=2 sw=2 sts=2
    augroup end
  ]]
)

-- Help
exec(
  [[
    augroup help
      au!
      au FileType help noremap <buffer><silent> q :q!<cr>
    augroup end
  ]]
)

-- i3 Configuration
exec(
  [[
    aug i3config_ft_detection
      au!
      au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
    aug end
  ]]
)

-- GnuPG
exec(
  [[
    augroup encrypted
      au!
      au BufReadPre,FileReadPre *.gpg,*.gpg.wiki,*.asc,*.asc.wiki setl noswapfile noundofile nobackup viminfo=
    augroup END 
  ]]
)
