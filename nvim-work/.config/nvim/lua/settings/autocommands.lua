-- Basic settings
vim.cmd('syntax enable')
vim.cmd('set background=dark')

-- Optionally, you can add specific settings for reStructuredText files
vim.cmd [[
  augroup rst
    autocmd!
    autocmd FileType rst setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
  augroup END
]]

-- Highlight the current line number
vim.cmd [[
  augroup LineNumberHighlight
    autocmd!
    autocmd WinEnter,BufEnter * setlocal cursorline
    autocmd WinLeave,BufLeave * setlocal nocursorline
    highlight CursorLineNr ctermfg=Yellow guifg=Yellow
  augroup END
]]

-- Autocommand to reload Neovim whenever you save the init.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])
