require("zk").setup({ picker = "telescope" })

local zk = require("zk")
local api = require("zk.api")
local util = require("zk.util")
local commands = require("zk.commands")

commands.add("ZkCustomNewFromTitleSelection", function(options)
  local location = util.get_lsp_location_from_selection()
  local selected_text = util.get_text_in_range(location.range)
  assert(selected_text ~= nil, "No selected text")

  local curr_note_rel_path = vim.fn.expand('%')
  local curr_note_path = util.resolve_notebook_path(0)
  local curr_notebook_path = util.notebook_root(curr_note_path)

  local def_options = {
    select = {"filenameStem", "title"},
    hrefs = {curr_note_rel_path}
  }

  api.list(curr_notebook_path, def_options,
    function(err, res)
      assert(not err, tostring(err))
      opt = {
        insertLinkAtLocation = location,
        title = selected_text,
        extra = {
          srcFilename = res[1].filenameStem,
          srcTitle = res[1].title
        }
      }
      zk.new(vim.tbl_deep_extend("force", opt, options or {}))
    end)

end, { needs_selection = true })

vim.keymap.set('n', '<leader>zkse', ':ZkNotes { hrefs = { "Evergreen" }, sort = { "modified" } }<CR>', { noremap = true })
vim.keymap.set('n', '<leader>zksl', ':ZkNotes { hrefs = { "Literature" }, sort = { "modified" } }<CR>', { noremap = true })

vim.keymap.set('n', '<leader>zkli', ':ZkInsertLink { sort = { "modified" } } <CR>', { noremap = true })
vim.keymap.set('n', '<leader>zklf', ':ZkLinks<CR>', { noremap = true })
vim.keymap.set('n', '<leader>zklb', ':ZkBacklinks<CR>', { noremap = true })

vim.keymap.set('n', '<leader>zkne', function() zk.new({ dir = "Evergreen", title = vim.fn.input("Title: ", "") }) end, { noremap = true })
vim.keymap.set('n', '<leader>zknl', function() zk.new({ dir = "Literature", title = vim.fn.input("Title: ", "") }) end, { noremap = true })

vim.keymap.set('v', '<leader>zknt', ':ZkNewFromTitleSelection { dir = "Evergreen" }<CR>', { noremap = true })

vim.keymap.set('n', '<leader>zkj', function() zk.new({ dir = "Journal/daily" }) end, { noremap = true })
