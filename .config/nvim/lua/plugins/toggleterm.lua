return {
	"akinsho/nvim-toggleterm.lua",
	config = function()
		require("toggleterm").setup({
			size = 20,
			hide_numbers = true,
			-- open_mapping = [[c-t]], defined in the config/keymaps.lua 
			shade_filetypes = {},
			shade_terminals = false,
			shading_factor = 0.1,
			start_in_insert = true,
			persist_size = false,
			direction = "float",
			close_on_exit = true,
			float_opts = {
				border = "double",
				width = vim.o.columns - 8,
				height = vim.o.lines - 8,
			},
		})
	end,
}
