local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup {
  autopairs = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  ensure_installed = 'maintained', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
  ignore_install = { '' }, -- List of parsers to ignore installing
  indent = { enable = false },
  highlight = {
    additional_vim_regex_highlighting = true,
    disable = { '' }, -- list of language that will be disabled
    enable = true, -- false will disable the whole extension
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
}
