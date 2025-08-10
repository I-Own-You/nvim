local options =  {
	preview = {
		winblend = 0,
	},
}
return {
    
        "kevinhwang91/nvim-bqf",
        enabled = true,
        event = "BufReadPost",
        opts = options,
}
