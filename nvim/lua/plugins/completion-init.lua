vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

require("mason").setup({})
require("mason-lspconfig").setup({})

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	sources = {
		-- { name = 'path' },
		{ name = 'nvim_lsp',               keyword_length = 1 },
		{ name = 'buffer',                 keyword_length = 3 },
		{ name = 'luasnip',                keyword_length = 2 },
		{ name = 'nvim_lsp_signature_help' }
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	formatting = {
		fields = { 'abbr', 'kind' },
		format = function(entry, item)
			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			}

			local kind = item.kind
			item.kind = " " .. (kind_icons[kind] or "?") .. " " .. ( kind or "")

			return item
		end,
	},
	mapping = {
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),

		['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
		['<C-n>'] = cmp.mapping.select_next_item(select_opts),

		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),

		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		['<C-f>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<C-b>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				cmp.complete()
			end
		end, { 'i', 's' }),

		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
})

-- Null LS

local null_ls = require("null-ls")
null_ls.setup({
	debug = true,
	sources = {
		-- require("none-ls.code_actions.eslint_d"),
		-- require("none-ls.diagnostics.eslint_d"),
		-- null_ls.builtins.formatting.prettierd,
		-- null_ls.builtins.formatting.biome,
		null_ls.builtins.formatting.phpcsfixer
	}
})

-- Lua

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.lua_ls.setup({
	capabilities = lsp_capabilities
})

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

		-- Jump to the definition
		bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

		-- Jump to declaration
		bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

		-- Lists all the implementations for the symbol under the cursor
		bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

		-- Jumps to the definition of the type symbol
		bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

		-- Lists all the references
		bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

		-- Displays a function's signature information
		bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

		-- Renames all references to the symbol under the cursor
		bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

		-- Selects a code action available at the current cursor position
		bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

		-- Show diagnostics in a floating window
		bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

		-- Move to the previous diagnostic
		bufmap('n', '(d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

		-- Move to the next diagnostic
		bufmap('n', ')d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
	end
})

-- TypeScript / TSX

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = ""
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup {
	capabilities = lsp_capabilities,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize imports"
		}
	},
	filetypes = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript",
		"javascriptreact",
		"javascript.tsx"
	}
}

-- CSS

lspconfig.cssls.setup({
	capabilities = lsp_capabilities,
})

-- TailwindCSS

lspconfig.tailwindcss.setup({})

-- ESLint (Although ESLint is setup using null_ls, this is for fix all shortcut)

-- lspconfig.eslint.setup({
-- 	capabilities = lsp_capabilities,
-- })

-- Biome

lspconfig.biome.setup({
	capabilities = lsp_capabilities
})

-- Rust

lspconfig.rust_analyzer.setup({
	capabilities = lsp_capabilities
})

-- Python

lspconfig.pyright.setup({
	capabilities = lsp_capabilities
})

-- PHP

lspconfig.phpactor.setup({})
