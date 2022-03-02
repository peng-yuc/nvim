local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>ca',
                        '<Cmd>lua require(\'jdtls\').code_action()<CR>', opts)
