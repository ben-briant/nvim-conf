-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Make double-Esc clear highlights
map("n", "<Esc><Esc>", "<Esc>:noh<CR><Esc>")

-- Map shift-tab to unindent
map("i", "<S-Tab>", "<C-d>")
