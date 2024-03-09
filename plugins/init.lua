-- bracket_wrap.lua

local M = {}

-- Function to wrap text in curly braces
local function wrap_in_brackets(lines)
	local wrapped_lines = {}
	for _, line in ipairs(lines) do
		table.insert(wrapped_lines, "{ " .. line .. " },")
	end
	return wrapped_lines
end

-- Command to wrap selected lines in curly braces
function M.wrap_lines()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local wrapped_lines = wrap_in_brackets(lines)
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, wrapped_lines)
end

-- Mapping to trigger wrapping
function M.setup()
	vim.cmd([[command! -range=% WrapLines lua require('bracket_wrap').wrap_lines()]])
	vim.api.nvim_set_keymap("n", "<leader>W", ":WrapLines<CR>", { noremap = true, silent = true })
end

return M
