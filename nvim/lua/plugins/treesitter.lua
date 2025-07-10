require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "lua", "bash", "c", "cpp" },
  highlight = { enable = true },
}
