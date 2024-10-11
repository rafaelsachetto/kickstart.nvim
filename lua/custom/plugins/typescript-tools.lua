return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    require('typescript-tools').setup {
      server = {
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true }
          local buf_set_keymap = function(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end

          -- Keymap
          buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

          -- Format on save
          if client.server_capatibilies.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
        settings = {
          tsserver = {
            logVerbosity = 'verbose',
            experimentalDecorators = true,
          },
        },
      },
    }
  end,
}
