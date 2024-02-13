return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
	  require("conform").setup({
		formatters_by_ft = {
			["*"] = { "trim_whitespace", "trim_newline" },
			lua = { "stylua" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			python = { "ruff", "black" },
		  },
		format_on_save = function(bufnr)
		  -- Disable with a global or buffer-local variable
		  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		  end
		  return { timeout_ms = 500, lsp_fallback = "always" }
		end,
	  })
	  vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
		  -- FormatDisable! will disable formatting just for this buffer
		  vim.b.disable_autoformat = true
		else
		  vim.g.disable_autoformat = true
		end
	  end, {
		desc = "Disable autoformat-on-save",
		bang = true,
	  })
	  vim.keymap.set("", "<leader>cf", function()
		require("conform").format({ async = true, lsp_fallback = "always" })
	  end, { desc = "[C]ode [F]ormat" })
	  vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	  end, {
		desc = "Re-enable autoformat-on-save",
	  })
	  vim.keymap.set("n", "<leader>cF", function()
		if vim.b.disable_autoformat or vim.g.disable_autoformat then
		  require("notify")("conform.nvim - autoformat enabled for current buffer")
		  vim.cmd("FormatEnable")
		else
		  require("notify")("conform.nvim - autoformat disabled for current buffer")
		  vim.cmd("FormatDisable")
		end
	  end, { desc = "[C]ode Toggle [F]ormat" })
	end,
  }