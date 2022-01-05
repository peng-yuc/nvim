local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local function select_null_ls_client()
  local clients = vim.tbl_values(vim.lsp.buf_get_clients())
  for _, client in ipairs(clients) do
    if client.name == 'null-ls' then
      return client
    end
  end
  return nil
end

-- ref: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/buf.lua#L177
_G.formatting = function(bufnr, options, timeout_ms)
  local client = select_null_ls_client()
  if client == nil then
    vim.notify('failed selecting null-ls client', vim.log.levels.WARN)
    return
  end

  bufnr = tonumber(bufnr) or vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_formatting_params(options)
  local result, err = client.request_sync('textDocument/formatting', params,
                                          timeout_ms, bufnr)
  if result and result.result then
    vim.lsp.util.apply_text_edits(result.result, bufnr)
  elseif err then
    vim.notify('vim.lsp.buf.formatting_sync: ' .. err, vim.log.levels.WARN)
  end
end

local formatting = null_ls.builtins.formatting

null_ls.setup {
  debug = false,
  sources = {
    formatting.autopep8.with {
      filetypes = { 'python' },
      extra_args = { '--indent-size=2' },
    },
    formatting.clang_format.with { filetypes = { 'cpp', 'java' } },
    formatting.lua_format.with { filetypes = { 'lua' } },
    formatting.prettier.with {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'html',
        'css',
        'json',
        'markdown',
      },
    },
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua formatting()
      augroup END
      ]])
    end
  end,
}
