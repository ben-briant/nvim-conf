-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return {
	-- Nicer statusline
	"nvim-lualine/lualine.nvim",

	-- File tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			map("n", "<C-b>", "<cmd>:Neotree toggle<cr>")
		end,
	},

	-- Theme
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
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	-- indentation based on current file
	"tpope/vim-sleuth",

	-- LSP stuff
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"simrat39/rust-tools.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			local cmp = require("cmp")
			cmp.setup({
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({})
			-- lspconfig.rust_analyzer.setup({})

			-- configure rust separately, with fanciness
			local rt = require("rust-tools")
			rt.setup({
				server = {
					-- TODO: there's gotta be a way to make this automatic
					on_attach = function(_, bufnr)
						lsp_zero.default_keymaps({ buffer = bufnr })
					end,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					c = { "clang_format" },
					cpp = { "clang_format" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = true,
					-- timeout_ms = 500,
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Activate telescope, and set :q to close it
			local actions = require("telescope.actions")
			local telescope = require("telescope")

			local opts = {
				defaults = {
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "insert",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					winblend = 0,
					-- border = {},
					-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					mappings = {
						n = {
							["q"] = actions.close,
						},
					},
				},
			}

			telescope.setup(opts)

			-- Map keys for telescope
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},

	-- tmux integration
	"christoomey/vim-tmux-navigator",

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
