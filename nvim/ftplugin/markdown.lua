
-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=false }

  -- vim.cmd(':silent ! open --background -a "Marked 2" .')
  
  -- Open the link under the caret.
  map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- Preview a linked note.
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

  map("n", "<leader>zd", "<Cmd>ZkNew { dir = 'Journal/daily' }<CR>", opts)

  -- Search slipbox
  map("n", "<leader>zse", "<Cmd>ZkNotes { hrefs = { 'Evergreen' }, sort = { 'modified' } }<CR>", opts)
  map("n", "<leader>zsl", "<Cmd>ZkNotes { hrefs = { 'Literature'}, sort = { 'modified' } }<CR>", opts)

  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.input('Directory: ', '', 'dir'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map("v", "<leader>znt", ":'<,'>ZkCustomNewFromTitleSelection { dir = 'Evergreen' }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = 'Evergreen', title = vim.fn.input('Title: ') }<CR>", opts)

  -- Open notes linking to the current buffer.
  map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
  -- Open notes linked by the current buffer.
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
  
  -- Open the code actions for a visual selection.
  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

vim.api.nvim_create_user_command("MarkedOpen", function()
  vim.cmd(":silent ! open --background -a 'Marked 2' .")
  -- vim.api.nvim_create_autocmd(
  --   "BufEnter",
  --   { command = 'silent ! touch "%:p"' }
  -- )
end, {})
