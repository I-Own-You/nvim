return {
    	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    	enabled = false,
    	event = "InsertEnter",
    	config = function()
    		-- virtual_text is disabled in handlers.lua
    		-- vim.diagnostic.config({ virtual_text = false })
    		-- vim.diagnostic.config({ virtual_lines = true })
    		-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    		vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false } })
    		vim.diagnostic.config({ virtual_text = false })
    		require("lsp_lines").setup({})
    	end,
    }
