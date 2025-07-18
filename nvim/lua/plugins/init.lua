local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'--branch=stable',       -- latest stable release
			'https://github.com/folke/lazy.nvim.git',
			path,
		})
		print("Finished installation")
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	vim.print(lazy.path)

	require("lazy").setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {}

lazy.setup({
	{ 'nvim-lualine/lualine.nvim' },
	{
		"jellydn/hurl.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Optional, for markdown rendering with render-markdown.nvim
			{
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown" },
				},
				ft = { "markdown" },
			},
		},
		ft = "hurl",
		opts = {
			-- Show debugging info
			debug = false,
			-- Show notification on run
			show_notification = false,
			-- Show response in popup or split
			mode = "split",
			-- Default formatter
			formatters = {
				json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
				html = {
					'prettier',  -- Make sure you have install prettier in your system, e.g: npm install -g prettier
					'--parser',
					'html',
				},
				xml = {
					'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
					'-xml',
					'-i',
					'-q',
				},
			},
			-- Default mappings for the response popup or split views
			mappings = {
				close = 'q',        -- Close the response popup or split view
				next_panel = '<C-n>', -- Move to the next response popup window
				prev_panel = '<C-p>', -- Move to the previous response popup window
			},
		},
		keys = {
			-- Run API request
			{ "<leader>A",  "<cmd>HurlRunner<CR>",        desc = "Run All requests" },
			{ "<leader>a",  "<cmd>HurlRunnerAt<CR>",      desc = "Run Api request" },
			{ "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
			{ "<leader>tE", "<cmd>HurlRunnerToEnd<CR>",   desc = "Run Api request from current entry to end" },
			{ "<leader>tm", "<cmd>HurlToggleMode<CR>",    desc = "Hurl Toggle Mode" },
			{ "<leader>tv", "<cmd>HurlVerbose<CR>",       desc = "Run Api in verbose mode" },
			{ "<leader>tV", "<cmd>HurlVeryVerbose<CR>",   desc = "Run Api in very verbose mode" },
			-- Run Hurl request in visual mode
			{ "<leader>h",  ":HurlRunner<CR>",            desc = "Hurl Runner",                              mode = "v" },
		},
	},
	-- {
	-- 	'stevearc/oil.nvim',
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		}
	},
	-- { 'akinsho/bufferline.nvim',  version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-telescope/telescope-frecency.nvim"
	},
	{ 'rose-pine/neovim',         name = 'rose-pine' },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "m4xshen/autoclose.nvim" },
	{
		'stevearc/dressing.nvim',
		opts = {},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim"
		}
	},
	-- { "karb94/neoscroll.nvim" },
	{
		'kaarmu/typst.vim',
		ft = 'typst',
		lazy = false,
	},
	{
		"pocco81/auto-save.nvim"
	},
	{
		"windwp/nvim-ts-autotag"
	},
	{
		"kylechui/nvim-surround",
		version = "*",     -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		'goolord/alpha-nvim',
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.buttons.val = {}
			require('alpha').setup(dashboard.config)
		end
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {}
	},
	{
		'numToStr/Comment.nvim',
		opts = {
		}
	},
	-- {
	-- 	'fgheng/winbar.nvim'
	-- },
	-- {
	-- 	'xiyaowong/transparent.nvim',
	-- 	config = function()
	-- 		require("transparent").setup()
	-- 	end
	-- },
	-- {
	-- 	"EdenEast/nightfox.nvim"
	-- },
	-- {
	-- 	"navarasu/onedark.nvim"
	-- },
	-- { "nuvic/flexoki-nvim", name = "flexoki" },
	{
		"windwp/nvim-ts-autotag"
	},
	{ "lewis6991/gitsigns.nvim" },
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
	-- 	opts = {
	-- 		provider = "copilot",
	-- 		copilot = {
	-- 			model = "claude-3.5-sonnet"
	-- 		}
	-- 	},
	-- -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- -- build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
	-- dependencies = {
	-- 	"stevearc/dressing.nvim",
	-- 	"nvim-lua/plenary.nvim",
	-- 	"MunifTanjim/nui.nvim",
	-- 	--- The below dependencies are optional,
	-- 	"hrsh7th/nvim-cmp",         -- autocompletion for avante commands and mentions
	-- 	"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 	"zbirenbaum/copilot.lua",   -- for providers='copilot'
	-- 	{
	-- 		-- support for image pasting
	-- 		"HakonHarnes/img-clip.nvim",
	-- 		event = "VeryLazy",
	-- 		opts = {
	-- 			-- recommended settings
	-- 			default = {
	-- 				embed_image_as_base64 = false,
	-- 				prompt_for_file_name = false,
	-- 				drag_and_drop = {
	-- 					insert_mode = true,
	-- 				},
	-- 				-- required for Windows users
	-- 				use_absolute_path = true,
	-- 			},
	-- 		},
	-- 	},
	-- 	{
	-- 		-- Make sure to set this up properly if you have lazy=true
	-- 		'MeanderingProgrammer/render-markdown.nvim',
	-- 		opts = {
	-- 			file_types = { "markdown", "Avante" },
	-- 		},
	-- 		ft = { "markdown", "Avante" },
	-- 	},
	-- },
	-- },
})

require("plugins.lualine-init")
require("plugins.neotree-init")
-- require("plugins.bufferline-init")
-- require("plugins.oil-init")
require("plugins.telescope-init")
require("plugins.rosepine-init")
-- require("plugins.nightfox-init")
-- require("plugins.onedark-init")
-- require("plugins.flexoki-init")
require("plugins.treesitter-init")
require("plugins.completion-init")
require("plugins.autoclose-init")
require("plugins.dressing-init")
-- require("plugins.neoscroll-init")
require("plugins.autosave-init")
require("plugins.nvim-ts-autotag-init")
require("plugins.comment")
require("plugins.autotag-init")
require("plugins.gitsigns-init")
-- require("plugins.copilot")
