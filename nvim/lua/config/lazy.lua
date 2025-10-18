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
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
  		lazy = false,
  		dependencies = {
    			"nvim-tree/nvim-web-devicons",
  		},
  		config = function()
    		require("nvim-tree").setup {}
  		end,
	},
	{'akinsho/toggleterm.nvim', version = "*", config = true},
	{'simeji/winresizer'},
	{
    		'nvim-lualine/lualine.nvim',
    		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
})

