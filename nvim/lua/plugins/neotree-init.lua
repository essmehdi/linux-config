require("neo-tree").setup({
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
