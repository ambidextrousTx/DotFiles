-- Require our own modularized configs
require('core.keymaps')
require('core.plugins')
require('core.plugin_config.init')
require('core.lsp')


-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.encoding = 'utf-8'
vim.opt.cursorline = true
vim.opt.showcmd = true
vim.opt.laststatus = 2

-- Use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Automatically read the changes when the file changes
vim.o.autoread = true
--
-- Automatically write the changes to the file when the focus changes
vim.o.autowrite = true

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Split to the bottom and right by default
vim.o.splitbelow = true
vim.o.splitright = true

-- Don't break words on line wrap
vim.o.linebreak = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- 80 colums
vim.o.colorcolumn = '80'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('~/.vim/undo')

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show markers
-- Show the text about to change
vim.o.cpoptions = '$'

-- Show tab, eol, and some other characters
vim.o.list = true
vim.cmd [[ set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:· ]]

-- Offset 5 rows top and bottom when scrolling
vim.o.scrolloff = 5

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.material_style = "deep ocean"

-- Set default GUI font
vim.cmd [[set guifont="Source Code Pro:h18"]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

vim.keymap.set('n', '<leader>mt', require('material.functions').find_style, { desc = '[M]aterial [T]hemes' })

-- Abbreviations
vim.cmd [[ 
  iabbrev teh the 
  iabbrev adn and
  iabbrev thign thing
  iabbrev thigns things
  iabbrev waht what
  iabbrev tehn then
  iabbrev wnat want
  iabbrev omw on my way
]]

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
