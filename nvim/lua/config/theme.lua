-- Use pywal16 colors generated from the terminal pywal theme

_G.load_theme = function()
	vim.cmd("colorscheme pywal16")

	require("lualine").setup({
		options = {
			theme = "pywal16-nvim",
		},
	})
end

_G.switch_theme = function()
	-- Only one theme is used
	load_theme()
end
