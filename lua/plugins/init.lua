return {
	-- Nicer statusline, filebrowser, and icons
	"nvim-lualine/lualine.nvim",
	"preservim/nerdtree",
	"kyazdani42/nvim-web-devicons",
	-- colour scheme
	{
		"navarasu/onedark.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme onedark]])
		end,
	},

	-- bracket closer
	"windwp/nvim-autopairs",
	-- tmux integration
	"christoomey/vim-tmux-navigator",

	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim'
		}
	}

}
