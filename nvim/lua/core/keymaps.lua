-- All keymaps
-- [[ Basic Keymaps ]]
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Quickly move lines up and down in normal mode
vim.keymap.set('n', '-', 'ddp')
vim.keymap.set('n', '_', 'ddkP')

-- Quickly move and indent blocks of code
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Quickly move multiple lines up and down in visual mode
vim.keymap.set('v', '_', 'xkP`[V`]')
vim.keymap.set('v', '-', 'xp`[V`]')

-- Keep search matches in the middle of the window
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Keep half-page scolls in the middle of the window
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Copy to the system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Clear highlighted search matches
vim.keymap.set('n', '<leader><space>', ':noh<CR>')

-- Really not using ; and this saves the additional shift key press
vim.keymap.set('n', ';', ':')

-- Keep the cursor in place when joining lines. Do not use the z register
-- for anything else; Tip from Steve Losh¬
vim.keymap.set('n', 'J', 'mzJ`z')

-- Special characters
-- Insert the => used frequently in Ruby or elsewhere
vim.keymap.set('i', '<c-l>', '=>')

-- Insert checkmark using the Unicode codepoint¬
vim.keymap.set('n', '<leader>ch', 'i<C-v>u2713 <Esc>')

-- Insert space above and below
vim.keymap.set('n', '<leader>m', 'O<ESC>jo<ESC>k')

-- Keymaps for toggling options
-- Toggle between relative and absolute line numbering
vim.keymap.set('n', '<leader>sr', function ()
  vim.o.relativenumber = not vim.o.relativenumber
end)

-- Toggle spell check
-- Set to S because <leader>s should show all Telescope search
-- bindings via Which Key
vim.keymap.set('n', '<leader>S', function()
  vim.o.spell = not vim.o.spell
end)

-- Toggle listchars
vim.keymap.set('n', '<leader>l', function()
  vim.o.list = not vim.o.list
end)

-- Open the URL under cursor
-- https://www.reddit.com/r/neovim/comments/ro6oye/open_link_from_neovim/
vim.keymap.set('n', '<leader>o', [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
