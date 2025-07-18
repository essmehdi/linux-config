require("rose-pine").setup({
	highlight_groups = {
		StatusLine = { fg = "love", bg = "love", blend = 10 },
		StatusLineNC = { fg = "subtle", bg = "surface" },
	},
	-- styles = {
	-- 	transparency = true
	-- }
})

vim.cmd('colorscheme rose-pine')
