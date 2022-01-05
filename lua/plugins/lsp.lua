local lsp_installer_status_ok, lsp_installer = pcall(require,
                                                     'nvim-lsp-installer')
if not lsp_installer_status_ok then
  return
end

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name,
                     { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = { active = signs },
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.diagnostic.config(config)

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local function keymap(key, map)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, map, opts)
  end
  keymap('gl', '<Cmd>lua vim.diagnostic.open_float()<CR>')
  keymap('[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>')
  keymap(']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>')
  keymap('<Leader>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>')

  keymap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  keymap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  keymap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  keymap('gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
  keymap('gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
  keymap('<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
  keymap('<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition<CR>')
  keymap('<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  keymap('<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  keymap('<Leader>wl',
         '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  keymap('<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
  keymap('<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
  keymap('<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
end

lsp_installer.on_server_ready(function(server)
  local opts = { on_attach = on_attach }

  local names = { 'jsonls', 'sumneko_lua', 'jdtls', 'pyright' }
  for _, name in ipairs(names) do
    if server.name == name then
      local settings = require('configs.lsp.' .. name)
      opts = vim.tbl_deep_extend('force', settings, opts)
      break
    end
  end

  server:setup(opts)
end)
