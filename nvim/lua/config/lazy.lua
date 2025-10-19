-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
  		lazy = false,
  		dependencies = { "nvim-tree/nvim-web-devicons" },
  		config = function()
    		require("nvim-tree").setup({})
  		end,
	},
	{	
		'akinsho/toggleterm.nvim', 
		version = "*", 
		config = true
	},
	{
		'simeji/winresizer'
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
    		require("lualine").setup({})
  		end,
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	-- {
	-- 	"mason-org/mason.nvim",
	-- 	build = ":MasonUpdate",
	-- 	cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
	-- 	config = true,
	-- },
	-- {
	-- 	"mason-org/mason-lspconfig.nvim",
	-- 	dependencies = {
	-- 	{ "mason-org/mason.nvim" },
	-- 	{ "neovim/nvim-lspconfig" },
	-- 	},
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	config = true,
	-- 	keys = {
	-- 	{ "<C-space>", "<cmd>lua vim.lsp.completion.get()  <CR>", mode = "i" },
	-- 	{ "gh",        "<cmd>lua vim.lsp.buf.hover()       <CR>" },
	-- 	{ "gd",        "<cmd>lua vim.lsp.buf.definition()  <CR>" },
	-- 	{ "gD",        "<cmd>lua vim.lsp.buf.declaration() <CR>" },
	-- 	},
	-- },
	-- {
	-- 	'nvim-treesitter/nvim-treesitter',
	-- 	lazy = false,
	-- 	branch = 'main',
	-- 	build = ':TSUpdate',
	-- 	dependencies = {
	-- 		-- "nvim-treesitter/nvim-treesitter-textobjects",
	-- 		-- "nvim-treesitter/nvim-treesitter-cli",
	-- 	},
	-- 	-- main = 'nvim-treesitter.configs', 
	-- 	-- opts = {
	-- 	-- 	highlight = { enable = true },
	-- 	-- },
	-- },
	{
		"neovim/nvim-lspconfig",
		-- config = function()
		-- 	-- ref: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/lspconfig.lua
		-- 	local M = {}
		-- 	local map = vim.keymap.set

		-- 	-- export on_attach & capabilities
		-- 	M.on_attach = function(_, bufnr)
		-- 	local function opts(desc)
		-- 		return { buffer = bufnr, desc = "LSP " .. desc }
		-- 	end

		-- 	map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
		-- 	map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
		-- 	map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
		-- 	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
		-- 	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
		-- 	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

		-- 	map("n", "<leader>wl", function()
		-- 		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- 	end, opts "List workspace folders")

		-- 	map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
		-- 	-- map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

		-- 	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
		-- 	map("n", "gr", vim.lsp.buf.references, opts "Show references")
		-- 	end

		-- 	-- disable semanticTokens
		-- 	M.on_init = function(client, _)
		-- 	if client.supports_method "textDocument/semanticTokens" then
		-- 		client.server_capabilities.semanticTokensProvider = nil
		-- 	end
		-- 	end

		-- 	M.capabilities = vim.lsp.protocol.make_client_capabilities()

		-- 	M.capabilities.textDocument.completion.completionItem = {
		-- 	documentationFormat = { "markdown", "plaintext" },
		-- 	snippetSupport = true,
		-- 	preselectSupport = true,
		-- 	insertReplaceSupport = true,
		-- 	labelDetailsSupport = true,
		-- 	deprecatedSupport = true,
		-- 	commitCharactersSupport = true,
		-- 	tagSupport = { valueSet = { 1 } },
		-- 	resolveSupport = {
		-- 		properties = {
		-- 		"documentation",
		-- 		"detail",
		-- 		"additionalTextEdits",
		-- 		},
		-- 	},
		-- 	}

		-- 	M.defaults = function()
			-- dofile(vim.g.base46_cache .. "lsp")
			-- require("nvchad.lsp").diagnostic_config()

			-- require("lspconfig").lua_ls.setup {
			-- 	on_attach = M.on_attach,
			-- 	capabilities = M.capabilities,
			-- 	on_init = M.on_init,

			-- 	settings = {
			-- 	Lua = {
			-- 		diagnostics = {
			-- 		globals = { "vim" },
			-- 		},
			-- 		workspace = {
			-- 		library = {
			-- 			vim.fn.expand "$VIMRUNTIME/lua",
			-- 			vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
			-- 			vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
			-- 			vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
			-- 			"${3rd}/luv/library",
			-- 		},
			-- 		maxPreload = 100000,
			-- 		preloadFileSize = 10000,
			-- 		},
			-- 	},
			-- 	},
			-- }

			-- require("lspconfig").ts_ls.setup({})
			-- require("lspconfig").gopls.setup({})
			-- require("lspconfig").ruby_lsp.setup({})
			-- require("lspconfig").ziggy.setup({})
			-- require("lspconfig").bashls.setup({})
		-- 	end

		-- 	M.defaults()
		-- end
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
		config = function()
			require('mason').setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local ok, err = xpcall(function()
				-- ensure mason is configured if available (safe to call multiple times)
				pcall(function() require('mason').setup() end)
				local ok2, mason_lspconfig = pcall(require, 'mason-lspconfig')
				if not ok2 then error("mason-lspconfig not available") end
				mason_lspconfig.setup({ ensure_installed = { 'clangd' } })
				-- prepare capabilities and on_attach (compatible with new vim.lsp framework or lspconfig)
				local capabilities = vim.lsp and vim.lsp.protocol and vim.lsp.protocol.make_client_capabilities and vim.lsp.protocol.make_client_capabilities() or {}
				local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
				if ok_cmp and cmp_nvim_lsp then
					capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
				end
				local on_attach = function(client, bufnr)
					local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
					local opts = { noremap = true, silent = true }
					buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
					buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
					buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
				end
				-- Handler to setup servers with capabilities/on_attach
				
			end, debug.traceback)
			if not ok then
				vim.schedule(function()
					vim.notify("Error in mason-lspconfig config: " .. tostring(err), vim.log.levels.ERROR)
				end)
			end
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = { 'hrsh7th/nvim-cmp' },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function() 
			require('nvim-treesitter.configs').setup({
			ensure_installed = {
				"cpp",
				"python",
				"bash",
				"json",
				"lua",
				"vim",
				"markdown",
				"yaml"
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			})
		end
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lua',
		},
		config = function()
			local cmp = require('cmp')
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
			if ok and cmp_nvim_lsp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
			cmp.setup({
			completion = { autocomplete = { cmp.TriggerEvent.TextChanged } },
			-- snippet = {
			--   -- REQUIRED - you must specify a snippet engine
			--   expand = function(args)
			--     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			--     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			--     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			--     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			--     -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
			--   end,
			-- },
			-- window = {
			--   -- completion = cmp.config.window.bordered(),
			--   -- documentation = cmp.config.window.bordered(),
			-- },
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				-- { name = 'vsnip' }, -- For vsnip users.
				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = 'buffer' },
			})
			})

			-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
			-- Set configuration for specific filetype.
			--[[ cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' },
			}, {
				{ name = 'buffer' },
			})
			})
			require("cmp_git").setup() ]]-- 

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			}),
			matching = { disallow_symbol_nonprefix_matching = false }
			})


		end
		}
})

