return {
	-- Git commands in nvim
	"tpope/vim-fugitive",
	config = function()
		-- vim.keymap.set("n", "<leader>gs", [[:tab G<cr>]])
		-- vim.keymap.set("n", "<leader>gh", [[:diffget //2<cr>]])
		-- vim.keymap.set("n", "<leader>gl", [[:diffget //3<cr>]])

		-- NOTE: used snacks.nvim instead
		-- vim.keymap.set("n", "<leader>gB", [[:G blame<cr>]])
	end,
}
