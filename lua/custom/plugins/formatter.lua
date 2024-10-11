return {
  'mhartington/formatter.nvim',
  config = function()
    require('formatter').setup {
      filetype = {
        typescript = {
          function()
            return {
              exe = 'prettierd', -- ou "prettier"
              args = { vim.api.nvim_buf_get_name(0) },
              stdin = true,
            }
          end,
        },
        typescriptreact = {
          function()
            return {
              exe = 'prettierd', -- ou "prettier"
              args = { vim.api.nvim_buf_get_name(0) },
              stdin = true,
            }
          end,
        },
      },
    }

    -- Formatar automaticamente ao salvar
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.ts', '*.tsx' },
      command = 'FormatWrite',
    })
  end,
}
