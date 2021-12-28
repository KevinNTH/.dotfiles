local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.formatting.stylua.with({
    args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
  }),
  null_ls.builtins.formatting.codespell,

  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.code_actions.gitsigns,
}

require("null-ls").config({
  sources = sources,
})

lsp_handlers = require("knth.lsp.handlers")

require("lspconfig")["null-ls"].setup({
  on_attach = lsp_handlers.on_attach,
  capabilities = lsp_handlers.capabilities,
})

-- the duration in there is to stop timeouts on massive files
-- vim.cmd("autocmd BufWritePost * lua vim.lsp.buf.formatting_seq_sync(nil, 7500)")
