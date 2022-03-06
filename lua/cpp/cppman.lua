vim.cmd [[
  function! s:MyCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Cppman ' . str
    echo str
  endfunction
  command! MyCppMan :call s:MyCppMan()

  au FileType cpp nnoremap <buffer>K :MyCppMan<CR>
]]
