-------------------- PLUGINS -------------------------------
require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use "hoob3rt/lualine.nvim"
  use {"junegunn/fzf", run = function() vim.fn["fzf#install"](0) end}
  use "junegunn/fzf.vim"
  use "preservim/vim-markdown"
  use "neovim/nvim-lspconfig"
  use "mickael-menu/zk-nvim"
  use "morhetz/gruvbox"
  use "nordtheme/vim"
  use "L3MON4D3/LuaSnip"
  use 'lervag/vimtex'
end)


require("options")
require("mappings")
