
-- Remove arrow keys
vim.keymap.set('n', '<up>', 'gk', { noremap = true })
vim.keymap.set('n', '<down>', 'gj', { noremap = true })
vim.keymap.set('n', '<left>', ':bprevious<CR>', { noremap = true })
vim.keymap.set('n', '<right>', ':bnext<CR>', { noremap = true })
vim.keymap.set('i', '<up>', '', { noremap = true })
vim.keymap.set('i', '<down>', '', { noremap = true })
vim.keymap.set('i', '<left>', '', { noremap = true })
vim.keymap.set('i', '<right>', '', { noremap = true })

-- Split navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- FZF
vim.keymap.set('n', '<leader>ff', ':Files<cr>', { noremap = true })
vim.keymap.set('n', '<leader>fg', ':GFiles<cr>', { noremap = true })
vim.keymap.set('n', '<leader>fc', ':Ag<cr>', { noremap = true })
vim.keymap.set('n', '<leader>fb', ':Buffers<cr>', { noremap = true })

-- ZK-NVIM
local zk = require("zk")

vim.keymap.set('n', '<leader>zkse', ':ZkNotes { hrefs = { "Evergreen" }, sort = { "modified" } }<CR>', { noremap = true })
vim.keymap.set('n', '<leader>zksl', ':ZkNotes { hrefs = { "Literature" }, sort = { "modified" } }<CR>', { noremap = true })

vim.keymap.set('n', '<leader>zkli', ':ZkInsertLink<CR>', { noremap = true })
vim.keymap.set('n', '<leader>zklf', ':ZkLinks<CR>', { noremap = true })
vim.keymap.set('n', '<leader>zklb', ':ZkBacklinks<CR>', { noremap = true })

vim.keymap.set('n', '<leader>zkne', function() zk.new({ dir = "Evergreen", title = vim.fn.input("Title: ", "") }) end, { noremap = true })
vim.keymap.set('n', '<leader>zknl', function() zk.new({ dir = "Literature", title = vim.fn.input("Title: ", "") }) end, { noremap = true })

vim.keymap.set('n', '<leader>zkj', function() zk.new({ dir = "Journal/daily" }) end, { noremap = true })

-- LuaSnip
local ls = require("luasnip")

vim.keymap.set({"i"}, "<Tab>", function() ls.expand_or_jump() end, {})
vim.keymap.set({"s"}, "<C-J>", function() ls.jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, {silent = true})
