vim.cmd [[
  highlight ExtraWhitespace ctermbg=LightRed guibg=LightRed
  match ExtraWhitespace /\s\+$/
  au BufWinEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au BufWinLeave * call clearmatches()
]]
