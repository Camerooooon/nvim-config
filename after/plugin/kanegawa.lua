-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = false,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {
            LineNr = { bg = colors.palette.sumiInk3, fg = colors.palette.sumiInk5, italic = true },
            SignColumn = { bg = colors.palette.sumiInk3, fg = colors.palette.sumiInk5, italic = true },
            TreesitterContext = { bg = colors.palette.sumiInk3, fg = colors.palette.sumiInk5, italic = true },
            GitSignsAdd = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnGreen, italic = true },
            GitSignsDelete = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnRed, italic = true },
            GitSignsChange = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnYellow, italic = true },
            GitSignsUntracked = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnYellow, italic = true },
            NoiceCmdlinePopupBorder = { bg = colors.palette.sumiInk3, fg = colors.palette.dragonBlue, italic = true },
            NoicePopupBorder = { bg = colors.palette.sumiInk3, fg = colors.palette.dragonBlue, italic = true },
            NoicePopupmenuBorder = { bg = colors.palette.sumiInk3, fg = colors.palette.dragonBlue, italic = true },
            NoiceCmdlinePopupBorder = { bg = colors.palette.sumiInk3, fg = colors.palette.dragonBlue, italic = true },
            NoiceCmdlinePopupBorderSearch = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnYellow, italic = true },
            NoiceCmdlineIconSearch = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnRed, italic = true },
            NoiceConfirmBorder = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnGreen, italic = true },
            NoiceCmdlineIcon = { bg = colors.palette.sumiInk3, fg = colors.palette.autumnRed, italic = true },
            NoiceConfirm = { bg = colors.palette.sumiInk3, fg = colors.palette.fujiWhite, italic = true },
            DiagnosticSignWarn = { bg = colors.palette.sumiInk3 },
            DiagnosticSignHint = { bg = colors.palette.sumiInk3 },
            DiagnosticSignInfo = { bg = colors.palette.sumiInk3 },
            DiagnosticSignOkay = { bg = colors.palette.sumiInk3 },
            DiagnosticSignError = { bg = colors.palette.sumiInk3 },
        }
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

vim.cmd.colorscheme "kanagawa"
vim.cmd([[highlight DiagnosticUnderlineWarn gui=none]])

vim.g.neovide_title_background_color = string.format("%x", vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("SignColumn")}).bg)
