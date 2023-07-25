local lsp = require('lsp-zero')

local rt = require('rust-tools')
local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

-- see :help lsp-zero.build_options()
local rust_lsp = lsp.build_options('rust_analyzer', {
  single_file_support = false,

  on_attach = function(_, bufnr)
    vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    vim.keymap.set("n", "J", rt.join_lines.join_lines, { buffer = bufnr })
  end,

  settings = {
    ["rust-analyzer"] = {
      lens = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- hardcode port because of this following error: Couldn't connect to 127.0.0.1:${port}: ECONNREFUSED
local rt_codelldb_adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
rt_codelldb_adapter.port = 13000
-- then i got: Couldn't connect to 127.0.0.1:13000: ECONNREFUSED lol

return {
  server = rust_lsp,

  -- rust-tools options
  tools = {
    hover_actions = {
      auto_focus = true
    },
    inlay_hints = {
      -- prefix for parameter hints
      parameter_hints_prefix = " ",
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = " ",
    },
  },

  dap = {
    adapter = rt_codelldb_adapter
  },
}
