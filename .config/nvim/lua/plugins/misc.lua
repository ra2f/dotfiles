return {
	-- UI Component Library for Neovim.
	{ "MunifTanjim/nui.nvim" },
	{ "onsails/lspkind.nvim" },

	-- Replace vim filetype detection
	{
		"nathom/filetype.nvim",
		opts = {
			overrides = {
				extensions = {
					plt = "gnuplot",
				},
			},
		},
	},

	{
		lazy = false,
		config = true,
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Detect tabstop and shiftwidth automatically
	{ "tpope/vim-sleuth" },

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },

	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		config = true,
	},

	{
		"junegunn/vim-easy-align",
		cmd = "EasyAlign",
	},

	-- Ledger-cli
	{ "ledger/vim-ledger" },

	-- justfile
	{ "NoahTheDuke/vim-just" }
}
