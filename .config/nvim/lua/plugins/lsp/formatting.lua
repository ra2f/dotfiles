return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
	init = function() -- Specifies code to run before this plugin is loaded.
	end,

	config = function() -- Specifies code to run after this plugin is loaded
    require("conform").setup({
      formatters_by_ft = {
        python = { "isort", "black" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = function(bufnr)
				-- Disable autoformat on certain filetypes
				local ignore_filetypes = { "sql" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable autoformat for files in a certain path
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				-- ...additional logic...
				return { timeout_ms = 500, lsp_fallback = true }
			end,
    })
  end,
}