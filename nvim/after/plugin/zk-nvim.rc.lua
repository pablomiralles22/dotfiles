require("zk").setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "fzf",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

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
