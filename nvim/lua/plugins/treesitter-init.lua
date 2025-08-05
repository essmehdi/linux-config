-- Small fix for Laravel Blade files

vim.filetype.add({
	pattern = {
		['.*%.blade%.php'] = "blade"
	}
})

local parsers = require("nvim-treesitter.parsers").get_parser_configs()
parsers.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade"
}

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua", "php", "blade", "typescript", "javascript", "python", "html", "css", "java", "markdown", "toml", "json",
		"yaml", "rust", "tsx", "hyprlang", "nu"
	},
	highlight = {
		enable = true
	}
})
