
require('lualine').setup {
  options = {
      theme = 'ayu_light',
      -- disabled_filetypes = { statusline = { 'markdown', 'pandoc', '' } },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
 
