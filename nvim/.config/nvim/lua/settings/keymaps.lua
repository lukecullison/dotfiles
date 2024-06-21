-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Use jj instead of Esc
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Remap yy to copy to the system clipboard as well
vim.api.nvim_set_keymap('n', 'yy', ':let @+=@0<CR>yy', { noremap = true, silent = true })

-- Function to replace variable names with confirmation
function ReplaceVar()
  local old_var = vim.fn.input("Old variable: ")
  local new_var = vim.fn.input("New variable: ")
  vim.cmd("%s/\\<" .. old_var .. "\\>/" .. new_var .. "/gc")
end

-- Keybinding to toggle the undo tree
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Add a keybinding for replace with confirmation
vim.api.nvim_set_keymap('n', '<leader>sr', ':lua ReplaceVar()<CR>', { noremap = true, silent = false })

-- Keybinding to toggle the undo tree
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })

-- Keybindings for Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })

-- Key binding to search the home directory
vim.api.nvim_set_keymap('n', '<leader>sh', ':Telescope find_files search_dirs={"~"}<CR>', { noremap = true, silent = true })

-- Key mapping for showing command history
vim.api.nvim_set_keymap('n', '<leader>ch', "<cmd>Telescope command_history<CR>", { noremap = true, silent = true })

-- Key mapping for showing file history
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>Telescope oldfiles<CR>", { noremap = true, silent = true })
