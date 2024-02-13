return {
	"mfussenegger/nvim-lint",
	config = function()
	  	local lint = require("lint")
		lint.linters_by_ft = {
			python = { "ruff" },
			markdown = { "markdownlint" },
			sh = { "shellcheck" },
		}

		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
			callback = function()
			lint.try_lint()
			end,
		})
	end,
}
