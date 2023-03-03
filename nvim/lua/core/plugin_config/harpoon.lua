local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = '[A]dd file to [H]arpoon list'} )
vim.keymap.set('n', '<leader>ht', ui.toggle_quick_menu, { desc = '[H]arpoon view [T]oggle'} )

vim.keymap.set('n', '<leader>h1', function() ui.nav_file(1) end, { desc = '[H]arpoon file 1'} )
vim.keymap.set('n', '<leader>h2', function() ui.nav_file(2) end, { desc = '[H]arpoon file 2'} )
vim.keymap.set('n', '<leader>h3', function() ui.nav_file(3) end, { desc = '[H]arpoon file 3'} )
vim.keymap.set('n', '<leader>h4', function() ui.nav_file(4) end, { desc = '[H]arpoon file 4'} )
