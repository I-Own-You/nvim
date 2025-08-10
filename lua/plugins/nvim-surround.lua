local opts = {
	move_cursor = false,
}

return {
	"kylechui/nvim-surround",
	enabled = true,
	tag = "*",
	event = "BufReadPost",
	opts = opts,
}
