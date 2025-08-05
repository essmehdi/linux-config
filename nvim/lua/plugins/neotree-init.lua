require("neo-tree").setup({
	window = {
		width = 30
	},
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		hijack_netrw_behavior = "open_default",
		follow_current_file = {
			enabled = true
		}
	},
})
