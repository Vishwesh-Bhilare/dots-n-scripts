require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "lua_ls", "clangd" },
})

local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
