-- Set leader key to <Space>
vim.g.mapleader = " "

-- Load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Theme & UI
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim" },
  { "echasnovski/mini.starter", version = "*" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "petertriho/nvim-scrollbar" },
  { "windwp/nvim-autopairs" },
  { "folke/which-key.nvim" },

  -- Treesitter & Syntax
  { "nvim-treesitter/nvim-treesitter" },

  -- LSP & Completion
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  { "nvimtools/none-ls.nvim" },

  -- Extras
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvimdev/lspsaga.nvim", config = true },
  { "Vimjas/vim-python-pep8-indent" },
  { "michaeljsmith/vim-indent-object" },
})

-- Telescope
require("telescope").setup()

-- NvimTree
require("nvim-tree").setup()

-- Scrollbar
require("scrollbar").setup()

-- NvimTree setup
require("nvim-tree").setup()

-- Theme
vim.cmd.colorscheme "catppuccin-mocha"

-- Starter
require("mini.starter").setup({
  evaluate_single = true,
  header = table.concat({
    "╔════════════════════════════╗",
    "║        🧠 NVim Vishy       ║",
    "╚════════════════════════════╝",
    "",
  }, "\n"),
  items = {
    { name = "📝 New file",       action = "enew",                   section = "Files" },
    { name = "🔍 Find file",      action = "Telescope find_files",   section = "Files" },
    { name = "📂 File browser",   action = "NvimTreeToggle",         section = "Files" },
    { name = "🕑 Recent files",   action = "Telescope oldfiles",     section = "Recent" },
    { name = "🔎 Live grep",      action = "Telescope live_grep",    section = "Search" },
    { name = "📖 Help",           action = "Telescope help_tags",    section = "Search" },
    { name = "⚙️  Edit config",   action = "edit ~/.config/nvim/init.lua", section = "Config" },
    { name = "❌ Quit",           action = "qa",                     section = "Session" },
  },
  footer = "🚀 Ready to code! - LazyVim IDE Setup",
})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "pyright", "lua_ls", "clangd" } })

-- LSP
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})

-- CMP
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "lua", "bash", "c", "cpp" },
  highlight = { enable = true },
}

-- none-ls
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.clang_format,
  },
})

-- Lualine
require("lualine").setup({
  options = {
    theme = "catppuccin",
    section_separators = '',
    component_separators = '',
  }
})

-- Telescope
require("telescope").setup()

-- Scrollbar
require("scrollbar").setup()

-- Autopairs
require("nvim-autopairs").setup()

-- Which-key
require("which-key").setup()

-- Keymaps
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

vim.keymap.set('n', '<leader>r', function()
  local ft = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local cmd = ""
  if ft == "python" then
    cmd = "python " .. filename
  elseif ft == "cpp" then
    local output = vim.fn.expand("%:r")
    cmd = string.format("g++ %s -o %s && ./%s", filename, output, output)
  elseif ft == "c" then
    local output = vim.fn.expand("%:r")
    cmd = string.format("gcc %s -o %s && ./%s", filename, output, output)
  else
    print("Unsupported filetype: " .. ft)
    return
  end
  vim.cmd("split | terminal " .. cmd)
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<leader>q', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
vim.opt.clipboard:append("unnamedplus")
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, desc = 'Paste from clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, desc = 'Copy to clipboard' })

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
