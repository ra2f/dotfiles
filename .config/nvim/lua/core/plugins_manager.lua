-------------------------------------------------------------------------------
-- Plugins manager installation (https://github.com/folke/lazy.nvim)
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins installation
-------------------------------------------------------------------------------
require("lazy").setup(
	-- plugins
	{
		{
			import = "plugins",
		},
		{
			import = "plugins.lsp",
		},
	},

	-- opts
	{
		defaults = {
			lazy = false,
			version = false, -- always use the latest git commit
		},
		checker = { 
			enabled = true,
			notify = false
		},
		change_detection = { -- automatically check for plugin updates
			enabled = false,
		},
		performance = {
			rtp = {
				-- disable some rtp plugins
				disabled_plugins = {
					"gzip",
					-- "matchit",
					-- "matchparen",
					-- "netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	}
)
