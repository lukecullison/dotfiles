-- Load settings
require('settings.options')
require('settings.keymaps')
require('settings.autocommands')

-- Load plugins
require('plugins')

-- Load plugin configurations
-- require('plugins.telescope')
-- require('plugins.treesitter')
-- require('plugins.lsp')

-- Basic settings
vim.cmd('syntax enable')
vim.cmd('set background=dark')

-- Tab settings
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.shiftwidth = 4     -- Size of an indent
vim.o.tabstop = 4        -- Number of spaces tabs count for
vim.o.softtabstop = 4    -- Number of spaces tabs count for while editing

-- Search settings
vim.o.ignorecase = true  -- Case insensitive searching
vim.o.smartcase = true   -- Case sensitive if search contains uppercase

-- Enable line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Use jj instead of Esc
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Clipboard to copy out of neovim 
vim.opt.clipboard = "unnamedplus"

-- Remap yy to copy to the system clipboard as well
vim.api.nvim_set_keymap('n', 'yy', ':let @+=@0<CR>yy', { noremap = true, silent = true })

-- Enable reStructuredText formatting settings
vim.g.rst_style = 1

-- Enable dynamic 'formatexpr' for R and reStructuredText
vim.g.rrst_dynamic_comments = 1

-- Enable syntax highlighting
-- vim.cmd('syntax on')

-- Add filetype detection for .conf files
vim.api.nvim_exec([[
  autocmd BufRead,BufNewFile *.conf set filetype=conf
]], false)

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

-- Install packer.nvim if not installed
-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--   vim.cmd 'packadd packer.nvim'
-- end

-- Ensure packer.nvim is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- Autocommand to reload Neovim whenever you save the init.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Run macro on all files in the current directory
vim.api.nvim_set_keymap('n', '<leader>m', ':args *.py | argdo normal @b | update<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>me', ':args * | argdo if line(".") == line("$") | break | else | normal @b | endif | update<CR>', { noremap = true, silent = true })

-- Ensure Packer
local packer_bootstrap = ensure_packer()

-- Plugin management using packer.nvim
require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'
  
  -- Colorschemes
  use 'folke/tokyonight.nvim'
  use 'morhetz/gruvbox'
  use 'dracula/vim'
  use 'arcticicestudio/nord-vim'
  use 'ayu-theme/ayu-vim'
  use 'mhartington/oceanic-next'
  use 'sainnhe/everforest'
  use 'drewtempelmeyer/palenight.vim'
  use 'sickill/vim-monokai'
  use 'kaicataldo/material.vim'
  use 'tomasiser/vim-code-dark'
  use 'haishanh/night-owl.vim'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- LSP and autocompletion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-buffer'
  use 'nvim-treesitter/nvim-treesitter'

  -- Golang
  use 'fatih/vim-go'

  -- Other useful plugins
  use 'nvim-lua/plenary.nvim'
--  use 'nvim-telescope/telescope.nvim'
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'
  use 'windwp/nvim-autopairs'
  use 'nvim-lualine/lualine.nvim' -- Status line plugin

  -- Install telescope.nvim
  use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Install telescope-fzf-native for improved sorting performance (optional)
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Commenting plugin
  use 'terrortylor/nvim-comment'

  -- Undo changes across file close
  use 'mbbill/undotree'

  -- Bash highlighting
  use 'sheerun/vim-polyglot'

  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }

  use 'ThePrimeagen/vim-be-good'

    -- Rust tools
  use 'simrat39/rust-tools.nvim'

  use {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require('nvim-tmux-navigation').setup({})
      vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
      vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
      vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
      vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
    end,
  }

  -- nvim-tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      
      require'nvim-tree'.setup {
        -- Add your config here
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_tab         = false,
        hijack_cursor       = false,
        update_cwd          = false,
        git = {
            enable = true,
            ignore = false,
        },
        filters = {
            dotfiles = false,
            custom = {},
        },
        update_focused_file = {
          enable      = true,
          update_cwd  = true,
          ignore_list = {}
        },
        system_open = {
          cmd  = nil,
          args = {}
        },
        view = {
          width = 30,
          side = 'left',
        }
      }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end

end)

-- Colorscheme setup
vim.g.gruvbox_contrast_dark = 'hard'  -- Options: 'soft', 'medium', 'hard'
vim.g.gruvbox_contrast_light = 'medium' -- Options: 'soft', 'medium', 'hard'
vim.g.gruvbox_invert_selection = '0'
-- vim.cmd('colorscheme gruvbox') -- Set your default colorscheme here
-- vim.g.tokyonight_contrast_dark = 'hard'  -- Options: 'soft', 'medium', 'hard'
-- vim.g.tokyonight_contrast_light = 'soft' -- Options: 'soft', 'medium', 'hard'
-- vim.g.tokyonight_invert_selection = '0'
-- vim.cmd('colorscheme tokyonight') -- Set your default colorscheme here

-- Set the color scheme
vim.cmd('colorscheme catppuccin')

-- Set space as the leader key
vim.g.mapleader = ' '

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

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '/undo'

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

-- LSP settings
local lspconfig = require('lspconfig')

-- Configure pyright for Python LSP
lspconfig.pyright.setup{}

-- Configure diagnostic-languageserver to use pylint
lspconfig.diagnosticls.setup {
  filetypes = { 'python' },
  init_options = {
    linters = {
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        args = {
          '--output-format', 'text',
          '--score', 'no',
          '--msg-template', '[{line},{column}] {msg_id} {msg} ({symbol})',
          '%file'
        },
        formatPattern = {
          '^\\[(\\d+),(\\d+)\\] ([a-zA-Z0-9]+) (.*) \\(([a-zA-Z0-9\\-_]+)\\)$',
          { line = 1, column = 2, message = { 4 }, security = 3 }
        },
        securities = {
          informational = 'hint',
          refactor = 'info',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error'
        }
      }
    }
  }
}

-- Go language server
lspconfig.gopls.setup{}

-- LSP for Clangd
-- lspconfig.clangd.setup{}

-- C/C++ language server
lspconfig.clangd.setup{
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- Hover
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- Go to definition
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- Show references
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Rename symbol
    buf_set_keymap('n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- Code actions
    buf_set_keymap('n', 'ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  end
}

-- Rust
require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

-- Autocompletion settings
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- require('luasnip').lsp_expand(args.body) -- Remove LuaSnip
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
})

-- Configuration for vim-tmux-navigator
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<C-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true })

-- Harpoon configuration
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)

-- Rust tools keybindings
vim.api.nvim_set_keymap('n', '<leader>rr', ':RustRun<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rd', ':RustDebuggables<CR>', { noremap = true, silent = true })

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "go", "lua", "python", "javascript", "html", "css", "rust" },
  highlight = {
    enable = false,
    --enable = true,
  },
}

-- Configure nvim-comment
-- require('nvim_comment').setup({
    -- Use `gcc` to comment a line in normal mode
    -- Use `gc` to comment a selection in visual mode
--    line_mapping = "gcc",
--    operator_mapping = "gc",
--})

require('nvim_comment').setup({
  -- Add any options here
  line_mapping = "<leader>cc",
  operator_mapping = "<leader>c",
  comment_empty = false,
})

-- Autopairs setup
require('nvim-autopairs').setup{}

-- Lualine setup for status line
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require('telescope').setup{
    defaults = {
        -- Default configuration for Telescope goes here:
        -- config_key = value,
        
        -- Increase search depth and file limit
        -- find_command = { "fd", "--type", "f", "--hidden", "--follow", "--max-depth", "10", "--max-results", "100000" },
        find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--follow", "--max-depth", "12", "--max-results", "100000" },

        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--hidden',
            '--no-ignore',
            '--smart-case'
        },

        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-x>"] = "close"
            },
            n = {
                ["<C-c>"] = "close",
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

-- To get fzf-native loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
