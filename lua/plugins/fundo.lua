local options = {
	-- archives_dir = vim.fn.stdpath("cache") .. path.separator .. "fundo", -- default
	limit_archives_size = 64, --defualt was 512
	-- fdssfsd
}

return {
	"kevinhwang91/nvim-fundo",
	enabled = true,
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufReadPost",
	init = function()
		vim.o.undofile = true
	end,
	build = function()
		require("fundo").install()
	end,
	opts = options,
}
