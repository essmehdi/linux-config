local telescope = require("telescope")
telescope.setup({
	pickers = {
		find_files = {
			theme = "dropdown",
			hidden = true
		}
	}
})
telescope.load_extension("frecency")
