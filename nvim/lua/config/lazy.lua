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
	{
		"neovim/nvim-lspconfig",
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
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
			}, {
				{ name = 'buffer' },
			})
			})

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

