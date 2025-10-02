require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'getWords()'}
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
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

function getWords()
    if vim.o.spell == false then
        local r,c = unpack(vim.api.nvim_win_get_cursor(0))
        return r .. ":" .. c
    else
        line = vim.api.nvim_get_current_line();
        -- Maybe not the best solution but I'm not sure how else to get the length of an iterator in lua
        local i = 0;
        for _ in string.gmatch(line, "%S+") do
            i = i + 1
        end
        return tostring(vim.fn.wordcount().words .. ":" .. i)
    end
end
