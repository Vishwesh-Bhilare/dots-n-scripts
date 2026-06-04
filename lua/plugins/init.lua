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
