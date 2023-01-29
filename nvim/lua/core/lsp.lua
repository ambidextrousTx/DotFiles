local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  cmd = {
    'rustup', 'run', 'stable', 'rust-analyzer'
  }
}
